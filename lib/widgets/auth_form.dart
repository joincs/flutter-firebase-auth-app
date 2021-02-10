import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _currentEmail = '';
  String _currentPassword = '';
  String _currentUsername = '';

  _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();

      // FirebaseAuth

      FirebaseAuth _auth = FirebaseAuth.instance;
      UserCredential result;
      try {
        if (isLogin) {
          result = await _auth.signInWithEmailAndPassword(
              email: _currentEmail, password: _currentPassword);
        } else {
          result = await _auth.createUserWithEmailAndPassword(
              email: _currentEmail, password: _currentPassword);
        }
        FirebaseFirestore.instance
            .collection("users")
            .doc(result.user.uid)
            .set({
          "email": _currentEmail,
          "username": _currentUsername,
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 20,
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  children: [
                    TextFormField(
                      key: ValueKey("Email"),
                      validator: (val) {
                        if (val.isEmpty || !val.contains("@")) {
                          return "Please, Enter a valid email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                      ),
                      onSaved: (val) {
                        _currentEmail = val;
                      },
                    ),
                    if (!isLogin)
                      TextFormField(
                        key: ValueKey("Username"),
                        validator: (val) {
                          if (val.length < 5) {
                            return "Username must not be less than 5 chars";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Username",
                        ),
                        onSaved: (val) {
                          _currentUsername = val;
                        },
                      ),
                    TextFormField(
                      key: ValueKey("Password"),
                      validator: (val) {
                        if (val.length < 6) {
                          return "Password must not be less than 5 chars";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                      onSaved: (val) {
                        _currentPassword = val;
                      },
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      onPressed: _submitForm,
                      child: Text(isLogin ? "Login" : "Sign Up"),
                      color: Colors.pink,
                      textColor: Colors.white,
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin
                            ? "Create an Account"
                            : "I already have an account",
                      ),
                      textColor: Colors.pink,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
