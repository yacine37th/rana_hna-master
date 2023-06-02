import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../../Themes/colors.dart';
 import '../widgets.dart';

class PeopleOrSomething extends StatelessWidget {
  const PeopleOrSomething({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: tealColor)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Please choose",
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                        onPressed: () {
                          Get.toNamed("/PeopleSearchTrip");
                        },
                        icon: const Text("People"),
                        label: const ImageIcon(
                          Svg("assets/icons/multiple_users.svg"),
                        )),
                    const SizedBox(height: 10),
                    TextButton.icon(
                        onPressed: () {
                          Get.toNamed("/SomethingSearchTrip");
                        },
                        icon: const Text("Something"),
                        label: const Icon(Icons.adf_scanner_outlined)),
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
