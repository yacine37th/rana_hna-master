import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/main.dart';

class AddTripController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String? departure;
  String? destination;
  int? price;
  String condition = "";
  int avaliableSeats = 1;
  String? tripDate;

  void addAnAvailSeat() {
    if (avaliableSeats < 8) {
      avaliableSeats++;
    }
    update();
  }

  inputDate(DateTime value) {
    tripDate = MainFunctions.dateFormat.format(value);

    update();
  }

  void minusAnAvailSeat() {
    if (avaliableSeats > 1) {
      avaliableSeats--;
    }
    update();
  }

  inputDeparture(String? input) {
    departure = input?.trim();
    update();
  }

  inputDestination(String? input) {
    destination = input?.trim();
    update();
  }

  inputPrice(int? input) {
    price = input;
    update();
  }

  inputCondition(String input) {
    condition = input.trim();
    update();
  }

  void addATrip() async {
    if (await MainFunctions.checkInternetConnection()) {
      DocumentReference tripRef =
          FirebaseFirestore.instance.collection('Trips').doc();
      // TripModel tripModel = TripModel(
      //     tripUID: tripRef.id,
      //     driverUID: currentUser?.uid,
      //     departure: departure,
      //     destination: destination,
      //     price: price,
      //     condition: condition,
      //     allSeats: avaliableSeats,
      //     seatsLeft: avaliableSeats);
      Get.defaultDialog(
          title: "Please wait", content: const CircularProgressIndicator());

      await FirebaseFirestore.instance.collection("Trips").doc(tripRef.id).set({
        "tripUID": tripRef.id,
        "driverUID": currentUser?.uid,
        "driverUserName": currentUserInfos.currentUserName,
        "departure": departure,
        "destination": destination,
        "tripDate": tripDate,
        "price": price,
        "condition": condition,
        "allSeats": avaliableSeats,
        "seatsLeft": avaliableSeats
      }).whenComplete(() {
        Get.back();

        MainFunctions.successSnackBar("Trip created successfully");
      });
    }
  }
}
