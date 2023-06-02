class TripModel {
  late String? tripUID;
  late String? driverUID;
  late String? driverUserName;
  late String? departure;
  late String? destination;
  late String? tripDate;
  late int? price;
  late String? condition;
  late int? allSeats;
  late int? seatsLeft;

  TripModel(
      {required this.tripUID,
      required this.driverUID,
      required this.driverUserName,
      required this.departure,
      required this.destination,
      required this.tripDate,
      required this.price,
      required this.condition,
      required this.allSeats,
      required this.seatsLeft,
      F});
}
