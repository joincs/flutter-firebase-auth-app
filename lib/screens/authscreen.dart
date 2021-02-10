import 'package:FirebaseAuth/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink,
        padding: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: AuthForm(),
      ),
    );
  }
}
