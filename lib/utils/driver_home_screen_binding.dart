import 'package:get/get.dart';

import '../controller/driver_home_screen_controller.dart';
 
class DriverHomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DriverHomeScreenController());
  }
}
