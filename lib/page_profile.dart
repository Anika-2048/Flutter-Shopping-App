import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProfileScreen>{
  User? user;

  @override
  void initState() {
    super.initState();
    // Listen to authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      setState(() {
        user = newUser;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context){
    FirebaseAuth.instance.currentUser?.reload();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          user?.isAnonymous ?? true ? "You're not logged in!" : "Logged in as: ${user!.email!}",
        ),
        const SizedBox(height: 50),
        Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              if (user != null) {
                await FirebaseAuth.instance.signOut();
              } else {
                await FirebaseAuth.instance.signInAnonymously();
              }
            },
            icon: Icon(user?.isAnonymous ?? true ? Icons.login : Icons.logout),
            label: Text(user?.isAnonymous ?? true ? "Click here to login" : "Click here to logout"),
          ),
        ),
      ],
    );
  }
}

