// main_page.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'account_page.dart';
import 'gallery_page.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'getMeme.dart'; // Importing getMeme.dart
import 'image_utils.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentIndex = 1;
  final screens = [Account(), Cam(), Gallery()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 230, 125, 14),
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(200, 22, 22, 22),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 27,
            ),
            label: 'account',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              size: 27,
            ),
            label: 'camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_library,
              size: 27,
            ),
            label: 'gallery',
          )
        ],
      ),
    );
  }
}

// Camera widget
class Cam extends StatefulWidget {
  const Cam({super.key});

  @override
  State<Cam> createState() => _CamState();
}

class _CamState extends State<Cam> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;

  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }

  Future<void> sharePhoto(String imagePath) async {
    final File imageFile = File(imagePath);
    if (await imageFile.exists()) {
      await Share.shareXFiles([XFile(imagePath)], text: 'Check out my photo!');
    } else {
      // If the image file does not exist, show an error or handle appropriately.
      print('The image file does not exist!');
    }
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();
    if (cameras.length < 2) {
      // device doesn't have both front and back cameras
      direction = 0;
    }
    cameraController = CameraController(
        cameras[direction], ResolutionPreset.high,
        enableAudio: false);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  void showPhotoPreview(String imagePath, String memeText) {
    // Check for portrait mode
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              // Image widget
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Text overlay
              Positioned(
                bottom: 20,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black54,
                  child: Text(
                    memeText,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.8 / 2 -
                    60, // Adjusted position
                child: FloatingActionButton(
                  onPressed: () {
                    sharePhoto(imagePath); // Call sharePhoto method here
                  },
                  child: Icon(Icons.share, color: Colors.black),
                  // Ensure icon color is visible
                  backgroundColor: Colors.white, // Contrast with icon color
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.8 / 2 + 30,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Icon(Icons.close, color: Colors.black),
                  // Ensure icon color is visible
                  backgroundColor: Colors.white, // Contrast with icon color
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> capturePhoto() async {
    try {
      final XFile photo = await cameraController.takePicture();
      String memeText = await FirestoreService().getRandomMemeText();

      List<String> words = memeText.split(' ');

      List<String> lines = [];
      String currentLine = "";

      for (int i = 0; i < words.length; i++) {
        if (currentLine.isNotEmpty) {
          currentLine += " "; // Add a space between words
        }
        currentLine += words[i];

        if (currentLine.split(' ').length >= 4 || i == words.length - 1) {
          lines.add(currentLine);
          currentLine = "";
        }
      }

      String topText = "";
      String bottomText = "";

      if (lines.length <= 4) {
        topText = lines.getRange(0, lines.length).join('\n');
      } else {
        topText = lines.getRange(0, 4).join('\n');
        bottomText = lines.getRange(4, lines.length).join('\n');
      }

      // Use the ImageUtils class to draw text on the image
      File imageFile = File(photo.path);
      File newImage = await ImageUtils.drawVerticalTextOnImage(
          imageFile, topText, bottomText);

      // Now you can show the preview with the new image
      showPhotoPreview(newImage.path, memeText);
    } catch (e) {
      print("Error capturing photo: $e");
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: CameraPreview(cameraController),
            ),
            Positioned(
              top: 54.0,
              left: 16.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    direction = direction == 0 ? 1 : 0;
                    startCamera(direction);
                  });
                },
                child: const Icon(
                  Icons.flip_camera_android_outlined,
                  color: Color.fromARGB(255, 230, 125, 14),
                  size: 35,
                ),
              ),
            ),
            // Add a "Take Photo" button
            Positioned(
                bottom: 80,
                left: MediaQuery.of(context).size.width / 2 - 40,
                child: GestureDetector(
                    onTap: () => capturePhoto(),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white54,
                      ),
                      child: Center(
                          child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(140, 255, 255, 255),
                            border: Border.all(
                                color: Color.fromARGB(255, 230, 125, 14),
                                width: 3)),
                      )),
                    )))
          ],
        ),
      );
    } catch (e) {
      return const Text("Could Not Preview Camera");
    }
  }
}
