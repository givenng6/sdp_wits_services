import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusObject.dart';

class BusWidget extends HookWidget{

  var busSchedule = useState([]);
  var busFollowing = useState([]);
  BusWidget(this.busSchedule, this.busFollowing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    List<BusObject> busSchedule2 = [];
    List<String> busFollowing2 = [];

    for(BusObject data in busSchedule.value){
      busSchedule2.add(data);
    }

    for(String id in busFollowing.value){
      busFollowing2.add(id);
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
            image: AssetImage('assets/hall.jpg'),
            fit: BoxFit.cover
        ),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.bus_alert, color:  Color(0xff003b5c),),
              Text("Bus Services",
                style: TextStyle(fontWeight: FontWeight.bold, color:  Color(0xff003b5c)),)
            ],
          ),
          showBus(busFollowing2, busSchedule2)
        ],
      ),
    );
  }

  Widget BusItem(String route, String status, String nextStop, String timeEstimate){
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
          Text("Status: " + status, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Next Stop: " + nextStop, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Arriving In: " + timeEstimate, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
        ],
      ),
    );
  }
  
  Widget showBus(List<String> busFollowing, List<BusObject> busSchedule){
    List<Widget> buses = [];
    for(var bus in busFollowing){
      for(int i = 0; i < busSchedule.length; i++){
          String id = busSchedule[i].getID();
          if(id == bus){
            buses.add(BusItem(busSchedule[i].getRouteName(), "Enroute", "Yale Village", "5 mins"),);
            break;
          }
      }
    }

    if(busFollowing.isEmpty){
      buses.add(Text("No Data", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),));
    }

    return Column(children: buses);
  }
}