import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusObject.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';

class BusWidget extends StatefulWidget{

  @override
  State<BusWidget> createState() => _BusWidget();
}

class _BusWidget extends State<BusWidget>{
  List<BusObject> busSchedule = [];
  List<String> busFollowing = [];
  // constructor...
  _BusWidget(){
   busSchedule = context.watch<Subscriptions>().busSchedule;
   busFollowing  = context.watch<Subscriptions>().busFollowing;
  }

  @override
  Widget build(BuildContext context){

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        image: const DecorationImage(
            image: AssetImage('assets/hall.jpg'),
            fit: BoxFit.cover
        ),
      ),

      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bus_alert, color:  Color(0xff003b5c),),
              Text("Bus Services",
                style: TextStyle(fontWeight: FontWeight.bold, color:  Color(0xff003b5c)),)
            ],
          ),
          showBus(busFollowing, busSchedule)
        ],
      ),
    );
  }

  // the body of each bus card
  Widget BusItem(String route, String status, String nextStop){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0x80ffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(route, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Text("Status: $status", style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          nextStop != "" ?
          Text("Location: $nextStop", style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c)))
          :
          const Text("")
        ],
      ),
    );
  }

  // iterate through the bus following list and show bus cards...
  Widget showBus(List<String> busFollowing, List<BusObject> busSchedule){
    List<Widget> buses = [];
    for(var bus in busFollowing){
      for(int i = 0; i < busSchedule.length; i++){
          String id = busSchedule[i].getID();
          if(id == bus){
            String pos = "";
            if(busSchedule[i].getStatus() != "OFF"){
              pos = busSchedule[i].getPosition();
            }
            buses.add(BusItem(busSchedule[i].getRouteName(), busSchedule[i].getStatus(), pos),);
            break;
          }
      }
    }

    // if a user is not following anything show text
    // NO DATA
    if(busFollowing.isEmpty){
      buses.add(const Text("No Data", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),));
    }

    return Column(children: buses);
  }
}