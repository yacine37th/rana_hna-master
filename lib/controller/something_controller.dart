import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/model/transmitter_type_model.dart';

import '../main.dart';
import '../model/trip_model.dart';
import '../model/user_model.dart';

class SomethingController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String? departure;
  String? destination;
  String? tripDate;

  TransmitterTypeModel? choosedTransmitterType;
  List<TransmitterTypeModel> transmitterTypeList = [
    TransmitterTypeModel(
        mainText: "Pharmaceutical",
        subText: "Needle, Medicine vial, Medical devices",
        image: "assets/icons/Pharmaceutical.png"),
    TransmitterTypeModel(
        mainText: "Foods",
        subText: "Vegetables, Fruits",
        image: "assets/icons/foods.png"),
    TransmitterTypeModel(
        mainText: "Leaves",
        subText: "Docs, Files",
        image: "assets/icons/leaves.png"),
    TransmitterTypeModel(
        mainText: "Devices",
        subText: "Phone, Television, Refrigerator",
        image: "assets/icons/devices.png"),
    TransmitterTypeModel(
        mainText: "Car components",
        subText: "Engine, Glass, Wheels",
        image: "assets/icons/car_comps.png"),
    TransmitterTypeModel(
        mainText: "Fragile",
        subText: "Home furnishings, Glass",
        image: "assets/icons/fragile.png"),
    TransmitterTypeModel(
        mainText: "Refrigerated",
        subText: "Meat ,Canned food, Yogurt",
        image: "assets/icons/refrigerated.png"),
  ];
  List<TransmitterTypeModel>? transmitterTypeListNotEdited;

  inputDeparture(String? input) {
    departure = input?.trim();
    update();
  }

  inputDestination(String? input) {
    destination = input?.trim();
    update();
  }

  inputDate(DateTime value) {
    tripDate = MainFunctions.dateFormat.format(value);

    update();
  }

  void chooseType(int index) {
    choosedTransmitterType = transmitterTypeList[index];
    navigator!.pop();

    update();
  }

  //////////////////search
  String? searchText;
  inputSearch(String? input) {
    searchText = input;
    update();
  }

  searchType(String inputSearch) {
    transmitterTypeList = List.from(transmitterTypeListNotEdited!);
    transmitterTypeList.removeWhere((element) {
      return (!(element.mainText!.toLowerCase())
          .contains(inputSearch.toLowerCase()));
    });

    if (transmitterTypeList.isEmpty) {
      transmitterTypeList = List.from(transmitterTypeListNotEdited!);
      transmitterTypeList.removeWhere((element) {
        return (!(element.subText!.toLowerCase())
            .contains(inputSearch.toLowerCase()));
      });
    }

    update();
  }
  //////////////////search

  List<TripModel> tripsList = [];

  Future searchTrip() async {
    tripsList.clear();

    var trips = await FirebaseFirestore.instance
        .collection("Trips")
        .where("tripDate", isEqualTo: tripDate)
        //   .where("departure", isEqualTo: departure)
        //   .where("destination", isEqualTo: destination)
        .get();
    trips.docs.forEach((element) async {
      TripModel tripTemp = TripModel(
          tripUID: element.get("tripUID"),
          driverUID: element.get("driverUID"),
          driverUserName: element.get("driverUserName"),
          departure: element.get("departure"),
          destination: element.get("destination"),
          tripDate: element.get("tripDate"),
          price: element.get("price"),
          condition: element.get("condition"),
          allSeats: element.get("allSeats"),
          seatsLeft: element.get("seatsLeft"));

      tripsList.add(tripTemp);

      tripsList.removeWhere((element) {
        return element.driverUID == currentUser?.uid;
      });
      tripsList.removeWhere((element) {
        return (element.departure?.toLowerCase() != departure?.toLowerCase());
      });
      tripsList.removeWhere((element) {
        return (element.destination?.toLowerCase() !=
            destination?.toLowerCase());
      });
    });

    update();
    return tripsList;
  }

  takeTransmitter(int index) async {
    navigator?.pop();

    Get.defaultDialog(
        onWillPop: () {
          return Future.value(false);
        },
        barrierDismissible: false,
        title: "Please wait",
        content: const CircularProgressIndicator());
    TripModel tripSelected = tripsList[index];

    bool canAdd = true;

    currentUserInfos.currentUserTransmitterTrips?.forEach((element) {
      if (element.tripUID == tripSelected.tripUID) {
        canAdd = false;
      }
    });
    if (canAdd) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser?.uid)
          .collection("MyTransmitterTrips")
          .doc(tripSelected.tripUID)
          .set({
        "tripUID": tripSelected.tripUID,
        "type": choosedTransmitterType?.mainText
      });

      await FirebaseFirestore.instance
          .collection("Trips")
          .doc(tripSelected.tripUID)
          .collection("TransmitterCustomers")
          .doc(currentUser?.uid)
          .set({
        "customerUID": currentUser?.uid,
        "type": choosedTransmitterType?.mainText
      });
      currentUserInfos.currentUserTransmitterTrips?.add(tripSelected);
      navigator?.pop();
      navigator?.pop();

      MainFunctions.successSnackBar(
          "You have registred your item in this trip successfully");
      update();
    } else {
      navigator?.pop();

      MainFunctions.somethingWentWrongSnackBar(
          "You did already register an item in this trip");
    }

    update();
  }

  filterByPrice() {
    tripsList.sort(
      (a, b) {
        return a.price!.compareTo(b.price as num);
      },
    );
    update();
  }

  filterBySeatsLeft() {
    tripsList.sort(
      (a, b) {
        return a.seatsLeft!.compareTo(b.seatsLeft as num);
      },
    );
    update();
  }

  @override
  void onInit() {
    transmitterTypeListNotEdited = List.from(transmitterTypeList);

    super.onInit();
  }
}
