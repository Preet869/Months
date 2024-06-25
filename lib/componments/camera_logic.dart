import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({Key? key}) : super(key: key);

  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  CameraController? _cameraController;
  Future<void>? _initializeController;
  String? _error;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission(); // Request camera permissions

    // Initialize the camera
    _initializeCameras();
  }

  void _initializeCameras() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _error = "No cameras available";
        });
        return;
      }

      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );

      // Start the camera initialization
      setState(() {
        _initializeController = _cameraController?.initialize();
      });
    } catch (e) {
      setState(() {
        _error = "Error initializing cameras: $e";
      });
    }
  }

  void _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  void _takePhoto() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        // Capture the photo
        final image = await _cameraController!.takePicture();
        print("Photo captured: ${image.path}"); // Placeholder logic
        // Here, you might save the photo, navigate, or do other logic with the captured image
      } catch (e) {
        print("Error capturing photo: $e");
      }
    }
  }

  @override
  void dispose() {
    _cameraController
        ?.dispose(); // Dispose of the controller to release resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Take a Photo"),
      ),
      body: _error != null
          ? Center(
              child: Text(_error!),
            )
          : FutureBuilder<void>(
              future: _initializeController,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display the camera preview
                      Expanded(
                        child: CameraPreview(_cameraController!),
                      ),
                      ElevatedButton(
                        onPressed: _takePhoto, // Capture a photo
                        child: const Text("Take a Photo"),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error initializing camera"),
                  );
                } else {
                  // While initializing, show a loading indicator
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }
}