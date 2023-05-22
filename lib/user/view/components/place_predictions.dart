import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/app_data.dart';
import '../../controller/map_keys.dart';
import '../../controller/resource/request_controller.dart';
import '../../model/address_model.dart';
import '../../model/autocomplete_model.dart';

class PlacePrediction extends StatelessWidget {
  final AutoCompleteModel autoCompleteModel;
  const PlacePrediction({Key? key, required this.autoCompleteModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: InkWell(
        onTap: () {
          getPlaceDetails(context, autoCompleteModel.placeId.toString());
        },
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Center(
                child: Icon(CupertinoIcons.location_solid,
                    color: Color(0xFF0071FF), size: 20),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    autoCompleteModel.mainText.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Product Sans",
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    autoCompleteModel.secondaryText.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: "Product Sans",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void getPlaceDetails(BuildContext context , String placeId) async {
    final url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKeys";
    final response = await RequestController.getRequest(url);
    if (response["status"] == "OK") {
      AddressModel addressModel = AddressModel();
      addressModel.id = placeId;
      addressModel.placeName = response["result"]["name"];
      addressModel.latitude = response["result"]["geometry"]["location"]["lat"];
      addressModel.longitude = response["result"]["geometry"]["location"]["lng"];
      // ignore: use_build_context_synchronously
      Provider.of<AppData>(context, listen: false).getUserDropUpLocation(addressModel);
      debugPrint("Destination Place --> ${addressModel.placeName}");
    } else {
      return;
    }
  }
}
