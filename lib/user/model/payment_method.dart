class PaymentMethod {
  PaymentMethod({
      this.type, 
      this.number, 
      this.expiration, 
      this.cvv,});

  PaymentMethod.fromJson(dynamic json) {
    type = json['type'];
    number = json['number'];
    expiration = json['expiration'];
    cvv = json['cvv'];
  }
  String? type;
  String? number;
  String? expiration;
  String? cvv;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['number'] = number;
    map['expiration'] = expiration;
    map['cvv'] = cvv;
    return map;
  }

}