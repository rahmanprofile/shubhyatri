import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:provider/provider.dart';
import 'package:shubhyatri/user/view/pages/profile_page.dart';
import '../controller/app_data.dart';
import '../controller/map_keys.dart';
import '../controller/resource/address_assistant.dart';
import '../controller/resource/request_controller.dart';
import '../model/autocomplete_model.dart';
import 'components/category_component.dart';
import 'components/place_predictions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getUserCurrentLocation();
  }

  List<AutoCompleteModel> autoCompleteList = [];
  void getAutoCompleteLocation(String placeName) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$apiKeys&sessiontoken=1234567890";
    final response = await RequestController.getRequest(url);
    if (placeName.isNotEmpty) {
      if (response["status"] == "OK") {
        final predictions = response["predictions"];
        final placeList = (predictions as List)
            .map((e) => AutoCompleteModel.fromJson(e))
            .toList();
        setState(() {
          autoCompleteList = placeList;
        });
      }
    } else {
      return;
    }
  }

  Position? currentPosition;
  Future<Position> getUserCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
    });
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 16.0);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // ignore: use_build_context_synchronously
    final address = await AddressAssistant.searchCoordinatesAddress(context, position);
    debugPrint(address);
    return position;
  }

  int _value = 0;
  List<String> categoryListItem = [
    "Route",
    "Car",
    "Auto",
    "e-Rickshaw",
    "Bike",
    "Bus",
    "Loader"
  ];
  final dropController = TextEditingController();
  final pickController = TextEditingController();
  final Set<Marker> _markers = {};
  //final Set<Polyline> _polyline = {};
  List<LatLng> latLongPositionMarker = [];

  final Completer<GoogleMapController> _controller = Completer();
  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 16.0,
  );
  GoogleMapController? googleMapController;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(195.0, MediaQuery.of(context).size.width),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(CupertinoIcons.location_solid,
                                color: Colors.green, size: 16),
                            SizedBox(height: 10.0),
                            Icon(
                              CupertinoIcons.ellipsis_vertical,
                              size: 18,
                              color: Color(0xFF0071FF),
                            ),
                            SizedBox(height: 10.0),
                            Icon(CupertinoIcons.location_solid,
                                color: Colors.red, size: 16),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _searchPlaceCard(
                              Provider.of<AppData>(context, listen: false)
                                          .pickUpLocation !=
                                      null
                                  ? Provider.of<AppData>(context)
                                      .pickUpLocation!
                                      .placeName
                                      .toString()
                                  : "Your location",
                              pickController,
                              CupertinoIcons.chevron_right,
                              () {},
                              (value) {
                                setState(() {
                                  getAutoCompleteLocation(value);
                                });
                              },
                            ),
                            const SizedBox(height: 8.0),
                            _searchPlaceCard(
                              "Choose destination",
                              dropController,
                              CupertinoIcons.chevron_left,
                              () {},
                              (value) {
                                setState(() {
                                  getAutoCompleteLocation(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            List.generate(categoryListItem.length, (index) {
                          return CategoryComponentButton(
                            value: index,
                            groupValue: _value,
                            text: categoryListItem[index],
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          (autoCompleteList.isNotEmpty)
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: autoCompleteList.length,
                  itemBuilder: (context, index) {
                    return PlacePrediction(
                      autoCompleteModel: autoCompleteList[index],
                    );
                  })
              : Container(),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              mapToolbarEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              compassEnabled: true,
              rotateGesturesEnabled: true,
              trafficEnabled: true,
              buildingsEnabled: true,
              markers: _markers,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                googleMapController = controller;
                getUserCurrentLocation();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        },
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Icon(
              CupertinoIcons.person_fill,
              size: 30,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchPlaceCard(String text, TextEditingController controller,
      IconData icon, VoidCallback onTap, ValueChanged onChanged) {
    return Container(
      height: 45.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1.5),
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: TextFormField(
        style: GoogleFonts.jost(),
        controller: controller,
        onTap: onTap,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          hintStyle: GoogleFonts.jost(),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF0071FF),
            size: 18,
          ),
        ),
      ),
    );
  }


  //...........................................Other service's.....................
  void googleMapDirection() async {
    final direction = GoogleMapsDirections(apiKey: apiKeys);
    final result = await direction.directionsWithLocation(
       Location(lat: currentPosition!.latitude,lng: currentPosition!.longitude),
       Location(lat: 28.6359552,lng: 77.2472832),
   );
    final polyline = result.routes.first.overviewPolyline.points;
    final decodedPolyline = decodePolyline(polyline);
    final LatLngBounds latLongBounds = getBounds(decodedPolyline);
  }

  LatLngBounds getBounds(List<LatLng> points) {
    double southWestLat = double.infinity;
    double southWestLng = double.infinity;
    double northEastLat = -double.infinity;
    double northEastLng = -double.infinity;

    for (LatLng point in points) {
      if (point.latitude < southWestLat) {
        southWestLat = point.latitude;
      }
      if (point.longitude < southWestLng) {
        southWestLng = point.longitude;
      }
      if (point.latitude > northEastLat) {
        northEastLat = point.latitude;
      }
      if (point.longitude > northEastLng) {
        northEastLng = point.longitude;
      }
    }

    LatLng southWest = LatLng(southWestLat, southWestLng);
    LatLng northEast = LatLng(northEastLat, northEastLng);

    return LatLngBounds(southwest: southWest, northeast: northEast);
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = <LatLng>[];
    int index = 0;
    int len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng((lat / 1E5), (lng / 1E5)));
    }
    return points;
  }


}
