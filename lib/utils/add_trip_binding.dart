import 'package:get/get.dart';

import '../controller/add_trip_controller.dart';

class AddTripBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddTripController());
  }
}
