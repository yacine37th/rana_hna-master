import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../main.dart';

class CustomerHomeScreenController extends GetxController {
  int _currentBottomBarIndex = 0;

  int currentBottomBarIndex() {
    return _currentBottomBarIndex;
  }

  switchBetweenScreens(index) async {
    if (index == 0) {
      _currentBottomBarIndex = index;
    }
    if (index == 1) {
      _currentBottomBarIndex = index;

      // Apis.getFirebaseMessagingToken();
    }

    if (index == 2) {
      _currentBottomBarIndex = index;
    }

    update();
  }

  signOutOfAnExistingAccount() async {
    await FirebaseAuth.instance.signOut().then((value) {
      currentUser = null;

      Get.offAndToNamed("/SignIn");
    });
  }

  @override
  onInit() async {
 
    update();

    super.onInit();
  }
}
