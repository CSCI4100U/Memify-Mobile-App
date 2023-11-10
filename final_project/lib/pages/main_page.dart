import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'account_page.dart';
import 'gallery_page.dart';

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
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 230, 125, 14),
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 22, 22, 22),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
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

  void startCamera(int direction) async {
    cameras = await availableCameras();
    if (cameras.length < 2) {
      // device doesnt have both front and back camera
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
          ],
        ),
      );
    } catch (e) {
      return const Text("Could Not Preview Camera");
    }
  }
}
