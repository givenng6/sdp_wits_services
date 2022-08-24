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

        ],
      ),
    );
  }
}