import 'package:rana_hna/model/trip_model.dart';

class UserModel {
  late String? currentUserUID;
  late String? currentUserName;
  late String? currentUserImageURL;
  late String? currentUserEmail;
  late List<TripModel>? currentUserTrips;
  late List<TripModel>? currentUserTransmitterTrips;

  UserModel(
      {required this.currentUserUID,
      required this.currentUserEmail,
      required this.currentUserName,
      required this.currentUserImageURL,
      required this.currentUserTrips,
      required this.currentUserTransmitterTrips});
}
