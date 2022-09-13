import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './BusObject.dart';

// Uri to the API
String uri = "https://web-production-8fed.up.railway.app/";

class BusSchedule extends HookWidget{

  List<BusObject> busSchedule = [];
  var busFollowing = useState([]);
  BusSchedule(this.busSchedule, this.busFollowing,{Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(12),
      child: showNames()
    );
  }

  Widget BusItem(String route, String id, List<dynamic> stops, bool isFollowing){
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
              }, child: const Text("Status")),
              isFollowing ?
              const OutlinedButton(
                  onPressed: null,
                  child: Text("Following"))
              :
              OutlinedButton(onPressed: (){
                followBus(id);
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
      bool isFollowing = busFollowing.value.contains(object.getID());
      items.add(BusItem(object.getRouteName(), object.getID(), object.getStops(), isFollowing));
    }

    return Column(children: items);
  }

  Future<void> followBus(String busID) async{
    await http.post(Uri.parse("${uri}db/followBus/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": '2381410@students.wits.ac.za',
          "id": busID,
        })).then((value) {
      var json = jsonDecode(value.body);
      busFollowing.value = json;
    });
  }

}