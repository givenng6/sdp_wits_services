
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
        Text('Convocation', style: TextStyle(color: Color(0xff003b5c), fontWeight: FontWeight.bold, fontSize: 15)),
        Text("A44 Wits East Campus", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),


        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                child: OutlinedButton(onPressed: (){
                }, child: const Text("View", style: TextStyle(color: Color(0xff003b5c)),))
            ),
          OutlinedButton(onPressed: (){

          }, child: Text("Follow", style: TextStyle(color: Color(0xff003b5c)),)),
        ],)
      ],)
    );

  }
}