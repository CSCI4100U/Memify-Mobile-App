import 'package:flutter/material.dart';
import 'dart:io';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<File> imageFiles = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    final directory = Directory('/data/user/0/com.example.final_project/cache');
    if (await directory.exists()) {
      final List<FileSystemEntity> files = directory.listSync();
      final List<File> images = files
          .where((file) => file is File && file.path.endsWith('.jpg'))
          .map((file) => File(file.path))
          .toList();

      setState(() {
        imageFiles = images;
      });
    }
  }

  Future<void> refreshGallery() async {
    await loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        title: const Text(
          "Gallery",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: refreshGallery,
        child: imageFiles.isEmpty
            ? const Center(
          child: Text(
            'No images found.',
            style: TextStyle(color: Colors.white),
          ),
        )
        : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10, // Vertical spacing
            crossAxisSpacing: 10, // Horizontal spacing
          ),
          itemCount: imageFiles.length,
          itemBuilder: (context, index) {
            File imageFile = imageFiles[index];
            return Image.file(imageFile);
          },
        ),

      ),
    );
  }
}
