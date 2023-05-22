import 'package:flutter/material.dart';

import '../components/vehicle_details_component.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title:const Text("Overview Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:const [
            //SizedBox(height: 10.0),
            VehicleDetailsComponent(),
          ],
        ),
      ),
    );
  }
}
