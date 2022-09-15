import 'package:flutter/material.dart';

class DiningWidget extends StatefulWidget{

  @override
  State<DiningWidget> createState()=> _DiningWidget();
}

class _DiningWidget extends State<DiningWidget>{

  @override
  Widget build(BuildContext context){
    return Container(
      //height: 300,
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
            children: const [
              Icon(Icons.restaurant_menu, color: Colors.white,),
              Text("Dining Menu",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),

            ],
          ),
          MenuItem("Main Dining Hall", "Lunch", "11:00 - 14:00", "kkk"),
        ],
      ),
    );
  }

  Widget MenuItem(String route, String status, String nextStop, String timeEstimate){
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
          Text("Meal: " + status, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Time: " + nextStop, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 1", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 2" , style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 3", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 4", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 5", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
        ],
      ),
    );
  }
}