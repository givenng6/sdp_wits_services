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
  String email = "";
  BusSchedule(this.email, this.busSchedule, this.busFollowing,{Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(12),
      child: showNames()
    );
  }

  Widget BusItem(String route, String id, List<dynamic> stops, bool isFollowing){
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
                }, child: const Text("Status", style: TextStyle(color: Color(0xff003b5c), fontSize: 14,fontWeight: FontWeight.bold),))
              ),

              isFollowing ?
              const OutlinedButton(
                  onPressed: null,
                  child: Text("Following"))
              :
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff003b5c)
                  ),
                  onPressed: (){
                followBus(id);
              }, child: const Text("Follow", style:  TextStyle(color: Color(0xffbf9b30), fontSize: 14,fontWeight: FontWeight.bold),))
            ],
          )
        ],
      ),
    ));
  }

  Widget showList(List<dynamic> stops){
      List<Widget> items = [];
      for(var location in stops){
        items.add(Text(location, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)));
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
          "email": email,
          "id": busID,
        })).then((value) {
      var json = jsonDecode(value.body);
      busFollowing.value = json;
    });
  }

}