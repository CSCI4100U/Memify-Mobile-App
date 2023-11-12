import 'package:flutter/material.dart';
import '/firebase/auth.dart';
import '/database/login_db.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      body: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 70, right: 230),
              child: Text(
                "Settings",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40),
              )),
          const SizedBox(height: 50),
          Center(
              child: Container(
            height: 100,
            width: 375,
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(50, 255, 255, 255)),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
          )),
          const SizedBox(height: 50),
          Center(
            child: Container(
              height: 100,
              width: 375,
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(50, 255, 255, 255)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
            ),
          ),
          Center(
              child: Container(
                  height: 100,
                  width: 375,
                  decoration: const BoxDecoration(
                      border: Border(
                    left: BorderSide(color: Color.fromARGB(50, 255, 255, 255)),
                    right: BorderSide(color: Color.fromARGB(50, 255, 255, 255)),
                  )))),
          Center(
              child: Container(
                  height: 100,
                  width: 375,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(50, 255, 255, 255)),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))))),
          const SizedBox(height: 50),
          Center(
            child: GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text('Confirm logout?'),
                      children: <Widget>[
                        SimpleDialogOption(
                          child: const Text("Yes"),
                          onPressed: () async {
                            await Auth().signOut();
                            await LoginDB().forgetAccount();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Signed Out',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 230, 125, 14),
                            ));
                            Navigator.pushNamed(context, '/home');
                          },
                        ),
                        SimpleDialogOption(
                          child: const Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: 380,
                height: 75,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 125, 14),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.0),
                    bottomLeft: Radius.circular(100.0),
                    topRight: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Color.fromARGB(255, 22, 22, 22),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
