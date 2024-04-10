import 'package:flutter/material.dart';

class TakePhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take a Photo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Logic to take a photo goes here
          },
          child: Text('Take Photo'),
        ),
      ),
    );
  }
}
