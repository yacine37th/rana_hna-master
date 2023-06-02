import 'package:get/get.dart';
import 'package:rana_hna/controller/add_trip_controller.dart';

 
class DriverHomeScreenController extends GetxController {
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

  @override
  onInit() async {
    Get.put(AddTripController());
 
    update();

    super.onInit();
  }
}
