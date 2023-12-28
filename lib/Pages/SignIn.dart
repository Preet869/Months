// ignore_for_file: prefer_const_constructors

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

//Text editing controllers
final emailTextController = TextEditingController();
final passwordTextController = TextEditingController();

class _LoginPageState extends State<SignInPage> {
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
                    "/Users/ppreet/Desktop/Work/Programming/Projects/Months/month_project/images/calendar.json",
                    width: 100,
                    ),

                    //Title
                    Text(
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
                    MyButton(onTap: () {}, text: 'Sign In'),

                    SizedBox(height: 5),

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
