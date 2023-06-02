import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/view/widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../Themes/colors.dart';

class DriverOrCustomer extends StatelessWidget {
  const DriverOrCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: tealColor)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Please choose one !"),
                    const SizedBox(height: 20),
                    TextButton.icon(
                        onPressed: () {
                          Get.toNamed("/CustomerHomeScreen");
                        },
                        icon: const Text("I'M a customer"),
                        label: const ImageIcon(
                            Svg("assets/icons/profile_2user_icon.svg"))),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: () {
                        Get.toNamed("/DriverHomeScreen");
                      },
                      icon: const Text("I'M a driver"),
                      label: const ImageIcon(
                          Svg("assets/icons/profile_circle_icon.svg")),
                    )
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
