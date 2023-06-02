import 'package:get/get.dart';

import '../controller/customer_home_screen_controller.dart';

class CustomerHomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CustomerHomeScreenController());
  }
}
