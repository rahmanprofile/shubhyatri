class TravelHistoryModel{
  String? origin;
  String? destination;
  DateTime? time;

  TravelHistoryModel({
    this.origin,
    this.destination,
    this.time,
});

  TravelHistoryModel.fromJson(Map<String, dynamic> json) {
    origin = json["origin"];
    destination = json["destination"];
    time = json["time"];
  }
}