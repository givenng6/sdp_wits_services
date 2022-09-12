import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './BusObject.dart';

class BusSchedule extends HookWidget{

  List<BusObject> busSchedule = [];
  BusSchedule(this.busSchedule, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(12),
      child: showNames()
    );
  }

  Widget BusItem(String route, String id, List<dynamic> stops){
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
          Text(route, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          const Text("", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          showList(stops),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: (){
                print(id);
              }, child: const Text("Follow"))
            ],
          )
        ],
      ),
    );
  }

  Widget showList(List<dynamic> stops){
      List<Widget> items = [];
      for(var location in stops){
        items.add(Text(location, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))));
      }

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
  }

  Widget showNames(){
    List<Widget> items = [];
    for(BusObject object in busSchedule){
      items.add(BusItem(object.getRouteName(), object.getID(), object.getStops()));
    }

    return Column(children: items);
  }

}