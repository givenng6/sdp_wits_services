import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';

class HealthWidget extends StatefulWidget{

  @override
  State<HealthWidget> createState()=> _HealthWidget();
}

class _HealthWidget extends State<HealthWidget>{

  List<CCDUObject> ccduBookings = [];
  @override
  Widget build(BuildContext context){
    ccduBookings = context.watch<Subscriptions>().ccduBookings;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
            image: AssetImage('assets/health.jpg'),
            fit: BoxFit.cover
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.health_and_safety, color: Colors.green,),
              Text("Wellness Centre",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),)
            ],
          ),
         showWidget(),
        ],
      ),
    );
  }

  Widget showWidget(){
    List<Widget> items = [];

    if(ccduBookings.isNotEmpty){
      CCDUObject booking = ccduBookings[0];
      items.add(ItemWidget("CCDU", booking.date, booking.time, booking.counsellorName));
    }

    items.add(ItemWidget("Campus Health", "2022/09/06", "09:00", "Dr G Mathebula"),);

    return Column(children: items);
  }

  // Inner cards
  Widget ItemWidget(String department, String date, String time, String person){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0x80ffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(department, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Text("Appointment", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Date: " + date, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Time: " + time, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Personnel: " + person, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
        ],
      ),
    );
  }
}