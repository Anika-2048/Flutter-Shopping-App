import 'package:flutter/material.dart';
import 'package:shopping_core/loginpage.dart';
import 'package:shopping_core/registerpage.dart';

class loginOrRegisterPage extends StatefulWidget {
  const loginOrRegisterPage({super.key});

  @override
  State<loginOrRegisterPage> createState() => _loginOrRegisterPageState();
}

class _loginOrRegisterPageState extends State<loginOrRegisterPage>{
  bool showLoginPage = true;

  void togglePages(){
    setState((){
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
        onTap: () {
          togglePages();
        },
      );
    }else{
      return RegisterPage(
        onTap: () {
          togglePages();
        },
      );
    }
  }
}
