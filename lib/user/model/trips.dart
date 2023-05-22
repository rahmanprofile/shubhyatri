import 'start_location.dart';
import 'end_location.dart';

class Trips {
  Trips({
      this.id, 
      this.startLocation, 
      this.endLocation, 
      this.distance, 
      this.fare, 
      this.timestamp,});

  Trips.fromJson(dynamic json) {
    id = json['id'];
    startLocation = json['start_location'] != null ? StartLocation.fromJson(json['start_location']) : null;
    endLocation = json['end_location'] != null ? EndLocation.fromJson(json['end_location']) : null;
    distance = json['distance'];
    fare = json['fare'];
    timestamp = json['timestamp'];
  }
  String? id;
  StartLocation? startLocation;
  EndLocation? endLocation;
  String? distance;
  String? fare;
  String? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (startLocation != null) {
      map['start_location'] = startLocation!.toJson();
    }
    if (endLocation != null) {
      map['end_location'] = endLocation!.toJson();
    }
    map['distance'] = distance;
    map['fare'] = fare;
    map['timestamp'] = timestamp;
    return map;
  }

}