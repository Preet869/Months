// ignore_for_file: prefer_const_constructors
import 'package:month_project/main.dart';
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
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        // ignore: prefer_const_constructors
        title: Text("Months"),
        actions: [
          //sign out buttons
          IconButton(onPressed: signOut, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
