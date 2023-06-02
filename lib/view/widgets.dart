import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/Themes/colors.dart';

import '../main.dart';
import '../model/user_model.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.maxFinite,
      child: Image.asset(
        "assets/images/backgroundImage.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}

class ActiveBottomBarIcon extends StatelessWidget {
  const ActiveBottomBarIcon({
    super.key,
    required this.widgetIcon,
  });
  final Widget widgetIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: tealColor),
      child: widgetIcon,
    );
  }
}

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        navigator!.pop();
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: tealColor,
      ),
    );
  }
}

class ProfilePictureForOtherUsers extends StatelessWidget {
  const ProfilePictureForOtherUsers({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    //  await CachedNetworkImage.evictFromCache(url);4
    // ImageCache().clear();
    return SizedBox(
        height: 40,
        width: 40,
        child: !(userModel.currentUserImageURL == "")
            ? ClipOval(
                child: Image.network(
                userModel.currentUserImageURL!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ClipOval(
                    child: Container(
                      alignment: Alignment.center,
                      color: MainFunctions.generatePresizedColor(
                          userModel.currentUserName!.length),
                      child: Text(
                        userModel.currentUserName![0].toUpperCase(),
                        style: const TextStyle(fontSize: 19),

                        // style: const TextStyle(
                        //     fontSize: 27, color: purpleTextColor),
                      ),
                    ),
                  );
                },
              ))
            : ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  color: MainFunctions.generatePresizedColor(
                      userModel.currentUserName!.length),
                  child: Text(
                    userModel.currentUserName![0].toUpperCase(),
                    style: const TextStyle(fontSize: 19),
                  ),
                ),
              ));
  }
}
