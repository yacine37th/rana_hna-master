// ignore_for_file: unused_import, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/Themes/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'Themes/colors.dart';
 // ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'controller/search_trip_controller.dart';
import 'middleware/auth_middleware.dart';
import 'model/trip_model.dart';
import 'model/user_model.dart';
import 'utils/customer_home_screen_binding.dart';
import 'utils/driver_home_screen_binding.dart';
import 'utils/search_trip_binding.dart';
import 'utils/sign_in_bindning.dart';
import 'utils/sign_up_bindning.dart';
import 'utils/something_trip_binding.dart';
import 'utils/verify_email_binding.dart';
import 'view/choose_driver_customer.dart';
import 'view/customer_view/customer_home_screen.dart';
import 'view/customer_view/people_search_trip.dart';
import 'view/customer_view/something_search_trip.dart';
import 'view/driver_view/driver_home_screen.dart';
import 'view/my_transmitter_trips.dart';
import 'view/my_trips.dart';
import 'view/sign_in.dart';
import 'view/sign_up.dart';
import 'view/verify_email.dart';

User? currentUser = FirebaseAuth.instance.currentUser;
UserModel currentUserInfos = UserModel(
    currentUserUID: "",
    currentUserEmail: "",
    currentUserName: " ",
    currentUserImageURL: "",
    currentUserTrips: [],
    currentUserTransmitterTrips: []);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  currentUser = FirebaseAuth.instance.currentUser;
   if (currentUser != null) {
    await MainFunctions.getcurrentUserInfos();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rana Hna',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      theme: Themes.customLightTheme,
      getPages: [
        GetPage(
          name: "/SignUp",
          page: () => const SignUp(),
          binding: SignUpBinding(),
        ),
        GetPage(
            name: "/SignIn",
            page: () => const SignIn(),
            binding: SignInBinding(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: "/EmailVerification",
            page: () => const EmailVerification(),
            binding: EmailVerificationBinding()),
        GetPage(
          name: "/DriverOrCustomer",
          page: () => const DriverOrCustomer(),
        ),
        GetPage(
          name: "/DriverHomeScreen",
          page: () => const DriverHomeScreen(),
          binding: DriverHomeScreenBinding(),
        ),
        GetPage(
          name: "/CustomerHomeScreen",
          page: () => const CustomerHomeScreen(),
          binding: CustomerHomeScreenBinding(),
        ),
        GetPage(
          name: "/PeopleSearchTrip",
          page: () => const PeopleSearchTrip(),
          binding: PeopleTripBinding(),
        ),
        GetPage(
          name: "/SomethingSearchTrip",
          page: () => const SomethingSearchTrip(),
          binding: SomethingBinding(),
        ),
        GetPage(
          name: "/MyTrips",
          page: () => const MyTrips(),
        ),
        GetPage(
          name: "/MyTransmitterTrips",
          page: () => const MyTransmitterTrips(),
        ),
      ],
      initialRoute: "/SignIn",
    );
  }
}

class MainFunctions {
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');

 // static SharedPreferences? sharredPrefs;

  ///Check whether there is internet connection or not , it will display a snackbar message.
  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Get.closeCurrentSnackbar();

        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      Get.defaultPopGesture;
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(
            duration: const Duration(seconds: 5),
            message: "No connection to network",
            showProgressIndicator: true,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(
              Icons.report_problem,
              color: redColor,
            ));
      }

      return false;
    }
  }

  static Color generatePresizedColor(int namelength) {
    return profilColors[((namelength - 3) % 8).floor()];
  }

  static successSnackBar(String text) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          isDismissible: false,
          duration: const Duration(seconds: 3),
          message: text,
          backgroundColor: greenColor,
          showProgressIndicator: true,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(
            Icons.done,
            color: whiteColor,
          ));
    }
  }

  static somethingWentWrongSnackBar([String? errorText]) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          duration: const Duration(seconds: 5),
          message: errorText ?? "somethingWentWrong".tr,
          showProgressIndicator: true,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(
            Icons.report_problem,
            color: redColor,
          ));
    }
  }

  static getcurrentUserInfos() async {
    List<TripModel> tempMyTrips = [];
    List<String> myTripsUIDs = [];

    var queries = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("MyTrips")
        .get();
    queries.docs.forEach((element) {
      myTripsUIDs.add(element.id);
    });

    myTripsUIDs.forEach((element) async {
      var temp = await FirebaseFirestore.instance
          .collection("Trips")
          .doc(element)
          .get();
      TripModel tripTemp = TripModel(
          tripUID: temp["tripUID"],
          driverUID: temp["driverUID"],
          driverUserName: temp["driverUserName"],
          departure: temp["departure"],
          destination: temp["destination"],
          tripDate: temp["tripDate"],
          price: temp["price"],
          condition: temp["condition"],
          allSeats: temp["allSeats"],
          seatsLeft: temp["seatsLeft"]);
      tempMyTrips.add(tripTemp);
    });

    List<TripModel> tempMyTransmitterTrips = [];
    List<String> myTransmitterTripsUIDs = [];

    var queries1 = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("MyTransmitterTrips")
        .get();
    queries1.docs.forEach((element) {
      myTransmitterTripsUIDs.add(element.id);
    });

    myTransmitterTripsUIDs.forEach((element) async {
      var temp = await FirebaseFirestore.instance
          .collection("Trips")
          .doc(element)
          .get();
      TripModel tripTemp = TripModel(
          tripUID: temp["tripUID"],
          driverUID: temp["driverUID"],
          driverUserName: temp["driverUserName"],
          departure: temp["departure"],
          destination: temp["destination"],
          tripDate: temp["tripDate"],
          price: temp["price"],
          condition: temp["condition"],
          allSeats: temp["allSeats"],
          seatsLeft: temp["seatsLeft"]);
      tempMyTransmitterTrips.add(tripTemp);
    });

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .get()
        .then(
      (value) async {
        currentUserInfos = UserModel(
            currentUserUID: value["UID"],
            currentUserEmail: value["Email"],
            currentUserName: value["UserName"],
            currentUserImageURL: value["ImageURL"],
            currentUserTrips: tempMyTrips,
            currentUserTransmitterTrips: tempMyTransmitterTrips);
      },
    );
  }
}
