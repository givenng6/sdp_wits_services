import 'package:flutter/material.dart';

class BusWidget extends StatefulWidget{

  @override
  State<BusWidget> createState()=> _BusWidget();
}

class _BusWidget extends State<BusWidget>{

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
            image: AssetImage('assets/hall.jpg'),
            fit: BoxFit.cover
        ),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.bus_alert, color:  Color(0xff003b5c),),
              Text("Bus Services",
                style: TextStyle(fontWeight: FontWeight.bold, color:  Color(0xff003b5c)),)
            ],
          ),
          BusItem("Route 1 - Full Circuit", "Enroute", "Yale Village", "5 mins"),
          BusItem("Route 6D - Rosebank", "OFF", "N/A", "N/A"),
        ],
      ),
    );
  }

  Widget BusItem(String route, String status, String nextStop, String timeEstimate){
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
          Text(route, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Text("Status: " + status, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Next Stop: " + nextStop, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Arriving In: " + timeEstimate, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
        ],
      ),
    );
  }
}