// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CameraLogic {
  late CameraController _cameraController;
  late Future<void> _initializeController;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeController = _cameraController.initialize();
  }

  Future<void> takePhoto(Function(File) addPhotoCallback) async {
    try {
      await _initializeController;
      final image = await _cameraController.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/${DateTime.now()}.jpg';
      await image.saveTo(filePath);

      final File photo = File(filePath);
      addPhotoCallback(photo);
    } catch (e) {
      print(e);
    }
  }

  CameraController get cameraController => _cameraController;

  Future<void> get initializeControllerFuture => _initializeController;

  void dispose() {
    _cameraController.dispose();
  }
}
