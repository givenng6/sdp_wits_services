import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BusSchedule extends HookWidget{

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          BusItem("Route 1 - Full Circuit", "Enroute", "Yale Village", "5 mins"),
          BusItem("Route 1 - Full Circuit", "Enroute", "Yale Village", "5 mins"),
        ],
      ),
    );
  }

  Widget BusItem(String route, String status, String nextStop, String timeEstimate){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(route, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Text("", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Wits Amic Deck", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Noswal", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Rennie House", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Wits Education Campus", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: (){}, child: const Text("Follow"))
            ],
          )
        ],
      ),
    );
  }
}