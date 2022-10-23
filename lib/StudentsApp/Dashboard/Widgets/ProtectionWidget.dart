import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/ride_object.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';

class ProtectionWidget extends StatefulWidget{

  @override
  State<ProtectionWidget> createState()=> _ProtectionWidget();
}

class _ProtectionWidget extends State<ProtectionWidget>{
  bool isRideRequested = false;
  RideObject ride = RideObject();
  @override
  Widget build(BuildContext context){
    isRideRequested = context.watch<Subscriptions>().booked;
    ride = context.watch<Subscriptions>().rideDetails;
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        image: const DecorationImage(
            image: AssetImage('assets/uni.jpeg'),
            fit: BoxFit.cover
        ),
      ),

      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.security, color: Colors.white,),
              Text("Campus Control",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
            ],
          ),
          isRideRequested ? 
          ItemWidget(ride.from, ride.to, ride.driver, ride.carName, ride.reg, ride.status)
          :
    Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: const Color(0x80ffffff),
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
    Text("You haven't requested a ride", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
    ],
    ),
    )
        ],
      ),
    );
  }

  Widget ItemWidget(String from, String to, String driver, String carName, String reg, String status){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0x80ffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Ride Request", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Text("From: " + from, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Destination: " + to, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Driver: " + driver, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Car Make: " + carName, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Reg: " + reg, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Status: " + status, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
        ],
      ),
    );
  }
}