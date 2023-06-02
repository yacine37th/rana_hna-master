import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../main.dart';
import 'widgets.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    MainFunctions.checkInternetConnection();
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                decoration: BoxDecoration(
                    color: lightBlueColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: tealColor)),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: currentUserInfos.currentUserImageURL == ""
                              ? CircleAvatar(
                                  backgroundColor:
                                      MainFunctions.generatePresizedColor(
                                          currentUserInfos
                                              .currentUserName!.length),
                                  child: Text(
                                    currentUserInfos.currentUserName![0]
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 35, color: blackColor),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      currentUserInfos.currentUserImageURL!),
                                ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(currentUserInfos.currentUserName!,
                            style: const TextStyle(
                                fontSize: 30,
                                color: blackColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${currentUser?.email}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(blackColor),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.purple.withOpacity(0.5))),
                        icon: const Icon(Icons.car_repair),
                        onPressed: () async {
                          Get.toNamed("/MyTrips");
                        },
                        label: const Text("My trips",
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    const SizedBox(height: 10),
                    TextButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(blackColor),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.cyan.withOpacity(0.5))),
                        icon: const Icon(Icons.adf_scanner_outlined),
                        onPressed: () async {
                          Get.toNamed("/MyTransmitterTrips");
                        },
                        label: const Text("My transmitter trips",
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    const SizedBox(height: 10),
                    TextButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(blackColor),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.red.withOpacity(0.5))),
                        icon: const Icon(Icons.logout),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut().then((value) {
                            currentUser = null;

                            Get.offAllNamed("/SignIn");
                          });
                        },
                        label: const Text("Sign Out",
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
