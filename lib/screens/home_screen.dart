import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login App"),
        backgroundColor: Colors.pink,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
        ),
      ),
      body: Center(
        child: Text("Welcome to Home Page"),
      ),
    );
  }
}
