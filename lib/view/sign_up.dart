import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/Themes/colors.dart';
import 'package:rana_hna/view/widgets.dart';

import '../controller/sign_up_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          const Positioned(top: 20, child: BackIconButton()),
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
                    key: signUpController.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Create a new account",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onSaved: (username) {
                            signUpController.userName = username?.trim();
                          },
                          onChanged: (username) {
                            signUpController.userName = username.trim();
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your username";
                            } else if (val.length > 10) {
                              return "Username can't be larger than 10 letter";
                            } else if (val.length < 3) {
                              return "Username can't be less than 3 letter";
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Username",
                            prefixIcon: Icon(Icons.person_pin_rounded),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                            signUpController.userEmailAddress =
                                emailAddress?.trim();
                          },
                          onChanged: (emailAddress) {
                            signUpController.userEmailAddress =
                                emailAddress.trim();
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                            hintText: 'E-mail',
                          ),
                        ),
                        const SizedBox(height: 10),
                        GetBuilder<SignUpController>(builder: (cntx) {
                          return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: signUpController.showPassword,
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
                              signUpController.userPassword = password?.trim();
                            },
                            onChanged: (password) {
                              signUpController.userPassword = password.trim();
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    signUpController.invertShowPassword();
                                  },
                                  icon: signUpController.showPassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              hintText: 'Password',
                            ),
                          );
                        }),
                        const SizedBox(height: 20),
                        TextButton(
                            onPressed: () {
                              if (signUpController.formKey.currentState!
                                  .validate()) {
                                signUpController.formKey.currentState!.save();
                                signUpController.createNewUser();
                              }
                            },
                            child: const Text("Sign up"))
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
