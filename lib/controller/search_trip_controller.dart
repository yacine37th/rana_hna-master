import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rana_hna/main.dart';
import 'package:rana_hna/model/trip_model.dart';
import 'package:rana_hna/model/user_model.dart';

class PeopleTripController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String? departure;
  String? destination;
  int avaliableSeats = 1;
  List<TripModel> tripsList = [];
  String? tripDate;

  void addAnAvailSeat() {
    if (avaliableSeats < 8) {
      avaliableSeats++;
    }
    update();
  }

  Future<void> minusAnAvailSeat() async {
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

  inputDate(DateTime value) {
    tripDate = MainFunctions.dateFormat.format(value);

    update();
  }

  Future searchTrip() async {
    if (await MainFunctions.checkInternetConnection()) {
      tripsList.clear();

      var trips = await FirebaseFirestore.instance
          .collection("Trips")
          // .where("departure", isEqualTo: departure)
          // .where("destination", isEqualTo: destination)
          .where("tripDate", isEqualTo: tripDate)
          .where("seatsLeft", isGreaterThanOrEqualTo: avaliableSeats)
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
    }

    return tripsList;
  }

  takeTheTrip(int index) async {
    if (await MainFunctions.checkInternetConnection()) {
      TripModel tripSelected = tripsList[index];

      bool canAdd = true;

      currentUserInfos.currentUserTrips?.forEach((element) {
        if (element.tripUID == tripSelected.tripUID) {
          canAdd = false;
        }
      });

      if (canAdd) {
        Get.defaultDialog(
            onWillPop: () {
              return Future.value(false);
            },
            barrierDismissible: false,
            title: "Please wait",
            content: const CircularProgressIndicator());
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser?.uid)
            .collection("MyTrips")
            .doc(tripSelected.tripUID)
            .set({"tripUID": tripSelected.tripUID});

        await FirebaseFirestore.instance
            .collection("Trips")
            .doc(tripSelected.tripUID)
            .collection("Customers")
            .doc(currentUser?.uid)
            .set({"customerUID": currentUser?.uid});

        await FirebaseFirestore.instance
            .collection("Trips")
            .doc(tripSelected.tripUID)
            .update({
          "seatsLeft": FieldValue.increment(-1),
        });
        tripSelected.seatsLeft = tripSelected.seatsLeft! - 1;
        currentUserInfos.currentUserTrips?.add(tripSelected);
        navigator?.pop();
        navigator?.pop();

        MainFunctions.successSnackBar(
            "You have registred in this trip successfully");
        update();
      } else {
        navigator?.pop();

        MainFunctions.somethingWentWrongSnackBar(
            "You did already register in this trip");
      }
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
}
