class EndLocation {
  EndLocation({
      this.latitude, 
      this.longitude,});

  EndLocation.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  String? latitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}