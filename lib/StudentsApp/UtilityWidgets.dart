import 'package:flutter/material.dart';

// widgets to be reused across the students app

class UtilityWidget{

  Widget CircularProfile(String username){
    // getting the first character of the username to display...
    // display the circular badge...
    String char = username[0].toUpperCase();
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      height: 45,
      width: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blueGrey,
      ),
      child: Text(char, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25)),
    );
  }

}