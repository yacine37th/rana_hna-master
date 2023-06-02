import 'package:flutter/material.dart';
import 'package:rana_hna/view/widgets.dart';

import '../../Themes/colors.dart';

class CommonQustionsDriver extends StatelessWidget {
  const CommonQustionsDriver({super.key});

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
              "How to join RanaHna ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "It's simple, you just have to go to the RanaHna headquarters, you will fill in an information sheet, and our RanaHna recruitment manager will give you an appointment to attend a training session.",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "How can I contact you ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "You can reach us via customer service 24/7 on 0658068810. And also via Messenger and Facebook. We will be happy to answer you !",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "How long does the formation ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "You should know that the training takes practically the whole morning, minimum 03 hours between the theoretical training and the validation of the file, as well as the installation of the application and finalizing the process.",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "Do I have to show up with my vehicle ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "The day you go to the RanaHna headquarters, it is very important to show up with your vehicle so that our technician can carry out a check.",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "What are the places with strong asked ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "Where there are RanaHna customers, there is demand! It is up to you to ensure good service delivery. A satisfied customer is the best business strategy.",
              style: TextStyle(color: greyColor, fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "What time of day do I can work ?",
              style: TextStyle(
                  color: blackColor, fontSize: 19, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "Choose a schedule and adapt it to your family and social life, but you can work 24/7, because the more you work, the more you will increase your earnings.",
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
