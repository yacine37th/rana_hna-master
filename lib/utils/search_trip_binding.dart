import 'package:get/get.dart';

 import '../controller/search_trip_controller.dart';

class PeopleTripBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PeopleTripController());
  }
}
