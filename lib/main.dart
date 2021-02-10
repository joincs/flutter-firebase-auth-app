import 'package:FirebaseAuth/screens/authscreen.dart';
import 'package:FirebaseAuth/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase Auth",
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return HomeScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}
