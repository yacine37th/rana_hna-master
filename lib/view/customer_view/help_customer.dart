import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Themes/colors.dart';
import 'common_questions_customer.dart';

class HelpCustomer extends StatelessWidget {
  const HelpCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        children: [
          ListTile(
              leading: const Icon(Icons.phone),
              title: const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Helpline",
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
              ),
              subtitle: Text(
                "Available 24/24 hours",
                style: TextStyle(color: greyColor, fontSize: 15),
              ),
              onTap: () async {
                final uri = Uri(scheme: "tel", path: "0658068810");
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              }),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "Common questions",
                style: TextStyle(
                    color: blackColor,
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),
            ),
            subtitle: Text(
              "Find answers to your questions",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
            onTap: () {
              Get.to(() => const CommonQustionsCustomer());
            },
          )
        ],
      ),
    );
  }
}
