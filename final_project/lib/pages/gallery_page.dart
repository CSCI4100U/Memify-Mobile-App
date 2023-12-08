import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<File> imageFiles = [];

  Future<File> convertImageToBlackAndWhite(File imageFile) async {
    final uri = Uri.parse('http://54.147.153.6/convert'); // Replace with your API URL
    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();
    if (response.statusCode == 200) {
      final convertedImageBytes = await response.stream.toBytes();

      // Generate a new file path for the converted image
      String directory = path.dirname(imageFile.path);
      print("Recieved file");
      String newFileName = path.basenameWithoutExtension(imageFile.path) + '_bw.jpg';
      String newFilePath = path.join(directory, newFileName);

      // Write the bytes to the new file
      final convertedImageFile = File(newFilePath);
      await convertedImageFile.writeAsBytes(convertedImageBytes);
      return convertedImageFile;
    } else {
      throw Exception('Failed to convert image. Status code: ${response.statusCode}');
    }
  }


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
          .where((file) => file is File && file.path.endsWith('.png'))
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
  void showPhotoOptions(File imageFile) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(imageFile),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text('Delete', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      imageFile.delete();
                      imageFiles.remove(imageFile);
                    });
                    Navigator.of(context).pop();
                  },
                ),
                //TextButton.icon(
                //  icon: const Icon(Icons.close, color: Colors.white),
                //  label: const Text('Close', style: TextStyle(color: Colors.white)),
                //  onPressed: () => Navigator.of(context).pop(),
               // ),
                Flexible(
                  child: TextButton.icon(
                    icon: const Icon(Icons.filter, color: Colors.white),
                    label: const Text('filter', style: TextStyle(color: Colors.white, fontSize: 12)),
                    onPressed: () async {
                      final convertedImageFile = await convertImageToBlackAndWhite(imageFile);
                      setState(() {
                        // Replace the original image with the converted image
                        imageFiles[imageFiles.indexOf(imageFile)] = convertedImageFile;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
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
              return GestureDetector(
              onTap: () => showPhotoOptions(imageFile),
              child: Image.file(imageFile),
              );
          },
        ),
      ),
    );
  }
}
