import 'package:flutter/material.dart';
import 'dart:io';

import 'package:month_project/Pages/photo_page.dart';

class GalleryPage extends StatelessWidget {
  final List<File> photos;
  final Function(File) addPhotoCallback;

  const GalleryPage(
      {Key? key, required this.photos, required this.addPhotoCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Image.file(photos[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PhotoPage(addPhotoCallback: addPhotoCallback)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
