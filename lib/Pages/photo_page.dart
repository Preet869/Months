import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:month_project/componments/camera_logic.dart';

class PhotoPage extends StatefulWidget {
  final Function(File) addPhotoCallback;

  const PhotoPage({Key? key, required this.addPhotoCallback}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final CameraLogic _cameraLogic = CameraLogic();

  @override
  void initState() {
    super.initState();
    _cameraLogic.initializeCamera();
  }

  @override
  void dispose() {
    _cameraLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take a Photo"),
      ),
      body: FutureBuilder<void>(
        future: _cameraLogic.initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: CameraPreview(_cameraLogic.cameraController),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _cameraLogic.takePhoto(widget.addPhotoCallback);
                    Navigator.pop(context);
                  },
                  child: Text("Take Photo"),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error initializing camera"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
