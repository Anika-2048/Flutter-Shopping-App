import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_core/services/auth_service.dart';
import 'components/my_button.dart';
import 'components/my_textfield.dart';
import 'components/square_tile.dart';
import 'homepage.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user up method
  Future<void> signUserUp() async {
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
    try {
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
      }else{
        Navigator.pop(context);
        passwordUnmatch();
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        weakPassword();
      }else if(e.code == 'email-already-in-use'){
        alreadyUser();
      }else{
        therewaserror();
      }
    }
  }

  void passwordUnmatch(){
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                  child: Text(
                    'Password does not match confirmed password.',
                    style: TextStyle(color: Colors.white),
                  )
              )
          );
        }
    );
  }

  void therewaserror(){
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                  child: Text(
                    'There was an error signing you up :(',
                    style: TextStyle(color: Colors.white),
                  )
              )
          );
        }
    );
  }

  void weakPassword(){
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                  child: Text(
                    'Weak password. Do you wanna get hacked, dummy? Put a stronger password!',
                    style: TextStyle(color: Colors.white),
                  )
              )
          );
        }
    );
  }

  void alreadyUser(){
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                  child: Text(
                    'This email is already in use. Not you? Too bad...',
                    style: TextStyle(color: Colors.white),
                  )
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              // logo
              const Icon(
                Icons.lock,
                size: 50,
              ),
          
              const SizedBox(height: 10),
          
              // Let's create an account for you!
              Text(
                'Let\'s create an account for you!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
          
              const SizedBox(height: 10),
          
              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
          
              const SizedBox(height: 10),
          
              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
          
              const SizedBox(height: 10),
          
              //confirm password
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
          
              const SizedBox(height: 10),
          
              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 15),
          
              // sign in button
              MyButton(
                onTap: signUserUp,
                text: 'Sign Up',
              ),
          
              const SizedBox(height: 20),
          
              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 30),
          
              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(
                    imagePath: 'lib/images/google logo.png',
                    onTap: AuthService().signInWithGoogle,
                  ),
          
                  const SizedBox(width: 25),
          
                  // apple button
                  // SquareTile(imagePath: 'lib/images/apple logo.png')
                ],
              ),
          
              const SizedBox(height: 50),
          
              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login here',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: AuthService().getOrCreateUser,
                    child: const Text(
                      'Continue without login?',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}