import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Themes/colors.dart';
import '../controller/sign_in_controller.dart';
import 'widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: tealColor)),
                child: Form(
                    key: signInController.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Welcome to Rana Hna",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter an email";
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                .hasMatch(val)) {
                              return "Please enter a valid email";
                            }

                            return null;
                          },
                          onSaved: (emailAddress) {
                            signInController.userEmailAddress = emailAddress;
                          },
                          onChanged: (emailAddress) {
                            signInController.userEmailAddress =
                                emailAddress.trim();
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                            hintText: 'E-mail',
                          ),
                        ),
                        const SizedBox(height: 10),
                        GetBuilder<SignInController>(builder: (cntx) {
                          return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: signInController.showPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              }
                              if (value.length > 20) {
                                return "Password can't be larger than 20 letter";
                              }
                              if (value.length < 8) {
                                return "Password can't be smaller than 8 letter";
                              }

                              return null;
                            },
                            onSaved: (password) {
                              signInController.userPassword = password;
                            },
                            onChanged: (password) {
                              signInController.userPassword = password;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    signInController.invertShowPassword();
                                  },
                                  icon: signInController.showPassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              hintText: 'Password',
                            ),
                          );
                        }),
                        const SizedBox(height: 20),
                        TextButton(
                            onPressed: () {
                              if (signInController.formKey.currentState!
                                  .validate()) {
                                signInController.formKey.currentState!.save();
                                signInController.signInAUser();
                              }
                            },
                            child: const Text("Sign in")),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: const Text(
                              "Create a new account",
                              style: TextStyle(
                                color: tealColor,
                               ),
                            ),
                            onTap: () {
                              Get.toNamed("/SignUp");
                            },
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
