// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shubhyatri/user/controller/resource/request_controller.dart';
import '../../model/address_model.dart';
import '../../model/direction_details.dart';
import '../app_data.dart';
import '../map_keys.dart';

class AddressAssistant {
  static Future searchCoordinatesAddress(BuildContext context, Position position) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKeys";
    var placeAddress = "";
    String str1, str2, str3, str4 = '';
    final response = await RequestController.getRequest(url);
    if (response["status"] == "OK") {
      str1 = response['results'][0]['address_components'][1]['long_name'];
      str2 = response['results'][0]['address_components'][2]['long_name'];
      str3 = response['results'][0]['address_components'][5]['long_name'];
      str4 = response['results'][0]['address_components'][6]['long_name'];

      placeAddress = "$str1 ,$str2 ,$str3 ,$str4";
      debugPrint("Origin Place --> $placeAddress");
      AddressModel userPickUpAddress = AddressModel();
      userPickUpAddress.placeName = placeAddress;
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      Provider.of<AppData>(context, listen: false).getUserPickUpLocation(userPickUpAddress);
    }
    return placeAddress;
  }

  void obtainPlaceDirection(LatLng initialPosition, LatLng finalPosition) async {
    final url = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$apiKeys";
    final response = await RequestController.getRequest(url);
    if(response["status"] == "OK") {
      DirectionDetails directionDetails = DirectionDetails();
      directionDetails.encodedPoints = response["routes"][0]["overview_polyline"]["points"];

      directionDetails.distanceText = response["routes"][0]["legs"][0]["distance"]["text"];
      directionDetails.distanceValue = response["routes"][0]["legs"][0]["distance"]["value"];

      directionDetails.durationText = response["routes"][0]["legs"][0]["duration"]["text"];
      directionDetails.durationValue = response["routes"][0]["legs"][0]["duration"]["value"];
    }else {
      return;
    }
  }
}
