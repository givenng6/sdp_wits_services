import 'package:flutter/material.dart';

class DiningWidget extends StatefulWidget{

  @override
  State<DiningWidget> createState()=> _DiningWidget();
}

class _DiningWidget extends State<DiningWidget>{

  @override
  Widget build(BuildContext context){
    return Container(
      height: 300,
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
              Text("Dining Services",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
            ],
          ),

        ],
      ),
    );
  }
}