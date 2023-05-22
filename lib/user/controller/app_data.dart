import 'package:flutter/cupertino.dart';

import '../model/address_model.dart';

class AppData extends ChangeNotifier {
  AddressModel? pickUpLocation;
  void getUserPickUpLocation(AddressModel pickUpAddress) async {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  AddressModel? dropUpLocation;
  void getUserDropUpLocation(AddressModel dropUpAddress) async {
    dropUpLocation = dropUpAddress;
    notifyListeners();
  }
}
