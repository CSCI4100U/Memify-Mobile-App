import 'package:flutter/material.dart';
import '/firebase/auth.dart';
import '../database/settings_db.dart';
import '../database/options.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<Options>? userSettings;
  String? email = Auth().currentUser!.email;

  @override
  void initState() {
    super.initState();
    refreshSettings();
  }

  void refreshSettings() {
    if (email != null) {
      userSettings = SettingsDB().fetchSettings(email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController pfpController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        body: FutureBuilder<Options>(
          future: userSettings,
          builder: (context, AsyncSnapshot<Options> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              Auth().signOut();
              Navigator.pushNamed(context, "/Home");
            } else {
              Color isNoti = Colors.white;
              Color isAuto = Colors.white;
              if (snapshot.data?.autoLogin != 0) {
                isAuto = Colors.orange;
              }
              if (snapshot.data?.notifications != 0) {
                isNoti = Colors.orange;
              }
              return SingleChildScrollView(
                child: Column(
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
                          border: Border.all(
                              color: const Color.fromARGB(50, 255, 255, 255)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: GestureDetector(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Update PFP"),
                                        content: TextField(
                                          controller: pfpController,
                                          decoration: const InputDecoration(
                                              labelText: "Insert Image Link"),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () async {
                                                await SettingsDB().updatePfp(
                                                    pfpController.text, email!);
                                                setState(() {
                                                  refreshSettings();
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: const Text("Confirm"))
                                        ],
                                      );
                                    });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 40,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(snapshot.data!.pfp),
                                  radius: 37,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: Text(
                              "$email",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(height: 50),
                    Center(
                      child: Container(
                          height: 100,
                          width: 375,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(50, 255, 255, 255)),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                SettingsDB().updateNotifications(email!);
                                refreshSettings();
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  child: const Text(
                                    "Disable Notifications",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                ),
                                const SizedBox(width: 118),
                                Icon(
                                  Icons.circle,
                                  color: isNoti,
                                  size: 30,
                                )
                              ],
                            ),
                          )),
                    ),
                    Center(
                        child: Container(
                      height: 100,
                      width: 375,
                      decoration: const BoxDecoration(
                          border: Border(
                        left: BorderSide(
                            color: Color.fromARGB(50, 255, 255, 255)),
                        right: BorderSide(
                            color: Color.fromARGB(50, 255, 255, 255)),
                      )),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            SettingsDB().updateAutoLogin(email!);
                            refreshSettings();
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              child: const Text(
                                "Disable Auto Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                            const SizedBox(width: 135),
                            Icon(
                              Icons.circle,
                              color: isAuto,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    )),
                    Center(
                        child: Container(
                      height: 100,
                      width: 375,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(50, 255, 255, 255)),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: const Text(
                                    'Contact Memify@gmail.com For Support!'),
                                children: <Widget>[
                                  SimpleDialogOption(
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text("Confirm",
                                          textAlign: TextAlign.center),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              child: const Text(
                                "Help & Support",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                            const SizedBox(width: 162),
                            const Icon(
                              Icons.support_agent_outlined,
                              color: Colors.white,
                              size: 35,
                            )
                          ],
                        ),
                      ),
                    )),
                    const SizedBox(height: 50),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: const Text('Confirm logout?'),
                                children: <Widget>[
                                  SimpleDialogOption(
                                    child: const Text("Yes"),
                                    onPressed: () async {
                                      await Auth().signOut();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
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
            return const SizedBox();
          },
        ));
  }
}
