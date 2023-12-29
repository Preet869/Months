// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("Months"),
        actions: [
          //sign out button
          IconButton(
            onPressed: signOut, 
            icon: Icon(Icons.logout)
            ),
        ],
      ),
    );
  }
}
