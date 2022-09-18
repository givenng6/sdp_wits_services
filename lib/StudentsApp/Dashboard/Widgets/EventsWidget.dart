import 'package:flutter/material.dart';

class EventsWidget extends StatefulWidget{

  @override
  State<EventsWidget> createState()=> _EventsWidget();
}

class _EventsWidget extends State<EventsWidget>{

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
            image: AssetImage('assets/events.jpg'),
            fit: BoxFit.cover
        ),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.event, color: Colors.white,),
              Text("Events",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
            ],
          ),

        ],
      ),
    );
  }
}