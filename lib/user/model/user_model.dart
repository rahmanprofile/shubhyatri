import 'payment_method.dart';
import 'trips.dart';

class UserModel {
  UserModel({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.paymentMethod, 
      this.trips,});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    paymentMethod = json['payment_method'] != null ? PaymentMethod.fromJson(json['payment_method']) : null;
    if (json['trips'] != null) {
      trips = [];
      json['trips'].forEach((v) {
        trips!.add(Trips.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? email;
  String? phone;
  PaymentMethod? paymentMethod;
  List<Trips>? trips;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    if (paymentMethod != null) {
      map['payment_method'] = paymentMethod!.toJson();
    }
    if (trips != null) {
      map['trips'] = trips!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}