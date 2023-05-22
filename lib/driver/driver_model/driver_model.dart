import 'current_location.dart';

class DriverModel {
  DriverModel({
    this.driverId,
    this.name,
    this.phoneNumber,
    this.email,
    this.carMake,
    this.carModel,
    this.carYear,
    this.licensePlateNumber,
    this.rating,
    this.numRidesCompleted,
    this.currentLocation,
    this.available,
    this.acceptingRides,
  });

  DriverModel.fromJson(dynamic json) {
    driverId = json['driver_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    carMake = json['car_make'];
    carModel = json['car_model'];
    carYear = json['car_year'];
    licensePlateNumber = json['license_plate_number'];
    rating = json['rating'];
    numRidesCompleted = json['num_rides_completed'];
    currentLocation = json['current_location'] != null
        ? CurrentLocation.fromJson(json['current_location'])
        : null;
    available = json['available'];
    acceptingRides = json['accepting_rides'];
  }
  String? driverId;
  String? name;
  String? phoneNumber;
  String? email;
  String? carMake;
  String? carModel;
  String? carYear;
  String? licensePlateNumber;
  double? rating;
  int? numRidesCompleted;
  CurrentLocation? currentLocation;
  bool? available;
  bool? acceptingRides;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['driver_id'] = driverId;
    map['name'] = name;
    map['phone_number'] = phoneNumber;
    map['email'] = email;
    map['car_make'] = carMake;
    map['car_model'] = carModel;
    map['car_year'] = carYear;
    map['license_plate_number'] = licensePlateNumber;
    map['rating'] = rating;
    map['num_rides_completed'] = numRidesCompleted;
    if (currentLocation != null) {
      map['current_location'] = currentLocation!.toJson();
    }
    map['available'] = available;
    map['accepting_rides'] = acceptingRides;
    return map;
  }
}
