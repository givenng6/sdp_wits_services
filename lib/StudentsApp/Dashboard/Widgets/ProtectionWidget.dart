import 'package:flutter/material.dart';

class ProtectionWidget extends StatefulWidget{

  @override
  State<ProtectionWidget> createState()=> _ProtectionWidget();
}

class _ProtectionWidget extends State<ProtectionWidget>{

  @override
  Widget build(BuildContext context){
    return Container(
      height: 200,
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
            image: AssetImage('assets/control.jpg'),
            fit: BoxFit.cover
        ),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.security, color: Colors.white,),
              Text("Campus Control",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
            ],
          ),
          ItemWidget("department", "date", "time", "person")
        ],
      ),
    );
  }

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
          Text("Ride Request", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Text("Driver: ", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("From: " + date, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Destination: " + time, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("Car Make: " + person, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
        ],
      ),
    );
  }
}