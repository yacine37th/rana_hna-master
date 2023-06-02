import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rana_hna/main.dart';
import 'package:rana_hna/view/widgets.dart';

import '../Controller/verify_email_controller.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    MainFunctions.checkInternetConnection();
    final EmailVerificationController emailVerificationController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const BackIconButton(),
        title: const Text("Email verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("A verification email has been sent to your email",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    emailVerificationController.resendVerificationEmail();
                  },
                  child: const Text("Resend verification email",
                      style: TextStyle(
                        fontSize: 20,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
