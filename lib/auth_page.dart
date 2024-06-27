import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_core/loginorregisterpage.dart';
import 'homepage.dart';

class Authpage extends StatelessWidget{
  const Authpage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const loginOrRegisterPage();
          }
        },
      )
    );
  }
}