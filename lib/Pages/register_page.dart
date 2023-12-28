import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:month_project/componments/botton.dart";
import "package:month_project/componments/text_field.dart";

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final comfirmPasswordTextController = TextEditingController();

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
                    Lottie.asset(
                    "/Users/ppreet/Desktop/Work/Programming/Projects/Months/month_project/images/calendar.json",
                    width: 100,
                    ),

                    //Title
                    // ignore: prefer_const_constructors
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

                    // comfirm password textfield
                    MyTextField(
                        controller: comfirmPasswordTextController,
                        hintText: 'Comfirm Password',
                        obscureText: true),
                    const SizedBox(height: 25),
                    //SignIn button
                    MyButton(onTap: () {}, text: 'Sign Up'),

                    SizedBox(height: 5),

                    //resigster link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a member?",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Sign Up",
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
