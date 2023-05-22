import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VehicleDetailsComponent extends StatelessWidget {
  const VehicleDetailsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), color: Colors.white),
          child: const Center(
            child: Icon(CupertinoIcons.car_detailed,color: Color(0xFF0071FF),),
          ),
        ),
        const SizedBox(width: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:const [
                 Text("Swift Desire"),
                Text("Name : Aayush Pandey"),
                Text("Vehicle : DL 45 TY 9087"),
              ],
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const[
                 Text("Rs. 450"),
                 Text("Distance : 12KM"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
