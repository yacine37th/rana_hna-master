import 'package:get/get.dart';

import '../controller/something_controller.dart';

class SomethingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SomethingController());
  }
}
