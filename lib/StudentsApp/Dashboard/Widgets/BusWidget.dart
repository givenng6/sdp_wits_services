import 'package:flutter/material.dart';

class BusWidget extends StatefulWidget{

  @override
  State<BusWidget> createState()=> _BusWidget();
}

class _BusWidget extends State<BusWidget>{

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
            image: AssetImage('assets/hall.jpg'),
            fit: BoxFit.cover
        ),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.bus_alert, color: Colors.white,),
              Text("Bus Services",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
            ],
          ),

        ],
      ),
    );
  }
}