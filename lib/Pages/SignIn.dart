
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:month_project/componments/botton.dart';
import 'package:month_project/componments/text_field.dart';

class SignInPage extends StatefulWidget {
  final Function()? onTap;
  const SignInPage({super.key, required this.onTap});

  @override
  State<SignInPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignInPage> {
//Text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //sign user in
  void signIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      //pop loading cricle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //display error message
      displayMessage(e.code);
    }
  }

  // display a dialog message
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 0),
                    Lottie.asset(
                      "images/calendar.json",
                      width: 150,
                    ),

                    //Title
                    const Text(
                      style: TextStyle(fontSize: 50),
                      'Welcome to Months',
                    ),

                    const SizedBox(height: 50),
                    //email Textfield
                    MyTextField(
                        controller: emailTextController,
                        hintText: 'Email',
                        obscureText: false),
                    const SizedBox(height: 25),
                    //password box
                    MyTextField(
                        controller: passwordTextController,
                        hintText: 'Password',
                        obscureText: true),
                    const SizedBox(height: 25),

                    //SignIn button
                    MyButton(onTap: signIn, text: 'Sign In'),

                    const SizedBox(height: 5),

                    //resigster link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member?",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Register now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}
