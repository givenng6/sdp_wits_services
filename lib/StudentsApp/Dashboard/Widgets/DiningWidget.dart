import 'package:flutter/material.dart';

class DiningWidget extends StatefulWidget{

  @override
  State<DiningWidget> createState()=> _DiningWidget();
}

class _DiningWidget extends State<DiningWidget>{

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
            image: AssetImage('assets/food.jpg'),
            fit: BoxFit.cover
        ),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.restaurant_menu, color: Colors.white,),
              Text("Dining Menu",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
            ],
          ),
          MealWidget("Highfield Dining Hall", "Lunch", "11:00 - 14:00", "Dr G Mathebula"),
        ],
      ),
    );
  }


  Widget MealWidget(String DHName, String date, String time, String person){
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
          Text(DHName, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Text("Meal: " + date, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Time: " + time, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Personnel: " + person, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
        ],
      ),
    );
  }
}