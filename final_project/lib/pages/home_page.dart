import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 275),
          const Image(image: AssetImage('assets/images/face-analysis.png')),
          const SizedBox(height: 30),
          const Text(
            'Memefy',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Turn Your Selfies into LOL-fies',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 75,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: Container(
                  width: 150,
                  height: 45,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 230, 125, 14),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        bottomLeft: Radius.circular(100.0),
                        topRight: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0),
                      )),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Color.fromARGB(255, 22, 22, 22),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/signup'),
                child: Container(
                  width: 150,
                  height: 45,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        bottomLeft: Radius.circular(100.0),
                        topRight: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0),
                      )),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Color.fromARGB(255, 22, 22, 22),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
