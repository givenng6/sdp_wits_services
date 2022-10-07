import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:http/http.dart' as http;
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'dart:convert';
import './BusObject.dart';

// Uri to the API
String uri = "https://web-production-8fed.up.railway.app/";

class BusSchedule extends StatefulWidget{

  @override
  State<BusSchedule> createState() => _BusSchedule();
}

class _BusSchedule extends State<BusSchedule>{

  List<BusObject> busSchedule = [];
  List<String> busFollowing = [];
  String email = "";

  // constructor...
  // init data...
  _BusSchedule(){

  }

  // build and show the bus routes...
  @override
  Widget build(BuildContext context){
    email = context.watch<UserData>().email;
    busSchedule = context.watch<Subscriptions>().busSchedule;
    busFollowing = context.watch<Subscriptions>().busFollowing;
    return Container(
        padding: const EdgeInsets.all(12),
        child: showNames(context)
    );
  }

  Widget BusItem(String route, String id, List<dynamic> stops, bool isFollowing, BuildContext context){
    return Card(
      //color: Colors.white70,
        elevation: 2,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
                image: AssetImage('assets/white.jpg'),
                fit: BoxFit.cover
            ),
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
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child:  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white
                          ),
                          onPressed: (){

                            String status = "";
                            String pos = "Not available";

                            // search the route from the routes list...
                            for(BusObject bus in busSchedule){
                              if(id == bus.getID()){
                                status = bus.getStatus();
                                if(bus.getPosition() != ""){
                                  pos = bus.getPosition();
                                }
                              }
                            }

                            // bottom modal with the route data...
                            showModalBottomSheet(context: context,
                                builder: (builder) => Container(
                                  padding: const EdgeInsets.all(12),
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(route, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text("Status: $status"),
                                      Text("Current Position: $pos")
                                    ],
                                  ),
                                ));
                          },
                          child: const Text("Status", style: TextStyle(color: Color(0xff003b5c), fontSize: 14,fontWeight: FontWeight.bold),))
                  ),

                  // conditional rendering of the buttons...
                  isFollowing ?
                  const OutlinedButton(
                    // if already following this route...
                    // when pressed should do nothing...
                      onPressed: null,
                      child: Text("Following"))
                      :
                  ElevatedButton(
                    // show this button if not following the route...
                    // when clicked should follow the route...
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff003b5c)
                      ),
                      onPressed: (){
                        followBus(id, context);
                      }, child: const Text("Follow", style:  TextStyle(color: Color(0xffbf9b30), fontSize: 14,fontWeight: FontWeight.bold),))
                ],
              )
            ],
          ),
        ));
  }

  // iterate through the stops list and add text
  Widget showList(List<dynamic> stops){
    List<Widget> items = [];
    for(var location in stops){
      items.add(Text(location, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
  }

  // Iterate the bus routes and create card for each route...
  Widget showNames(BuildContext context){
    List<Widget> items = [];
    for(BusObject object in busSchedule){
      bool isFollowing = busFollowing.contains(object.getID());
      items.add(BusItem(object.getRouteName(), object.getID(), object.getStops(), isFollowing, context));
    }

    // return a column since it will accommodate many items...
    return Column(children: items);
  }

  // API call to follow a bus route...
  Future<void> followBus(String busID, BuildContext context) async{
    await http.post(Uri.parse("${uri}db/followBus/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "id": busID,
        })).then((value) {
      var json = jsonDecode(value.body);
      List<String> update = [];
      for(String sub in json){
        update.add(sub);
      }
      // update the bus following list...
      context.read<Subscriptions>().updateBusFollowing(update);
    });
  }

}