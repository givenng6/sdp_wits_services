
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class DiningCard extends HookWidget{
  Widget build(BuildContext context){
    return Container( 
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text('Convocation'),
        Text('A43 East campus'),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          OutlinedButton(onPressed: (){

          }, child: Text("View")),
          OutlinedButton(onPressed: (){

          }, child: Text("Follow")),
        ],)
      ],)
    );

  }
}