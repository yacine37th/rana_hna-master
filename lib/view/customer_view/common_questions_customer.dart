import 'package:flutter/material.dart';
import 'package:rana_hna/view/widgets.dart';

import '../../Themes/colors.dart';

class CommonQustionsCustomer extends StatelessWidget {
  const CommonQustionsCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text("Common questions"),
        backgroundColor: whiteColor,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              "How to apply for a RanaHna",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "You just need to install the application, register by putting your personal information and then enter your starting point and your destination The number of people and specify the type of transmission.",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "Is it possible to have an invoice for my race to justify my trips ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "Yes, you can request an invoice at the end of the race via the application, which you will receive by email.",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "How to get a code promo ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "Promo codes are systematically published on our official Facebook pages, and sent through in-app notifications",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "Is your service available every weekday and even at night ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "Yes, our driver-partners are available 24 hours a day, 7 days a week, you can make a request at any time of the day.",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "Can I choose between a female or male driver ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "Unfortunately this option is not yet available on the application, but it will be very soon!",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),

          // ListTile(
          //   title: Text(""),
          //   subtitle: Text(""),
          // ),
        ],
      ),
    );
  }
}
