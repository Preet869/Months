// ignore_for_file: prefer_const_constructors, unused_import, duplicate_ignore
import 'package:month_project/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:month_project/componments/button_app.dart';
import 'package:month_project/componments/count_down.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    void signOut() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Colors.transparent, elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          // ignore: prefer_const_constructors
          actions: [
            //sign out buttons
            IconButton(onPressed: signOut, icon: Icon(Icons.logout)),
          ],
        ),
        body: SafeArea(
            child: Center(
                child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                style: TextStyle(fontSize: 50),
                'Welcome to Months',
              ),
              const SizedBox(height: 50),
              Text(
                  style: TextStyle(fontSize: 25),
                  'Your next photo will be in...'),
              const SizedBox(height: 20),
              CountdownPage(),
              const SizedBox(height: 50),
              Text(style: TextStyle(fontSize: 25), 'Till then...'),
              const SizedBox(height: 50),
              MyButton(onTap: signOut, text: 'View Gallery'),
              const SizedBox(height: 10),
            ],
          ),
        ))));
  }
}
