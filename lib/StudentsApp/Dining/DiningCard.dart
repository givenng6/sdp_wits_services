
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sdp_wits_services/StudentsApp/Dining/ViewDH.dart';

// Uri to the API
String uri = "https://web-production-8fed.up.railway.app/";

class DiningCard extends HookWidget{

  List<DiningObject> diningHalls = [];
  var dhFollowing = useState("");
  String email = "";

  // constructor...
  // init data...
  DiningCard(this.email, this.diningHalls, this.dhFollowing, {Key? key}) : super(key: key);

  Widget build(BuildContext context){
    return Container(
        padding: const EdgeInsets.all(12),
        child: listDH(context)
    );}

      Widget DHItem(String name, String id, isFollowing, BuildContext context){
      return GestureDetector(
        // when tab a dh card
        // must open the whole menu of the dining hall
        onTap: (){
          int index = int.parse(id[2]) - 1;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewDH(diningHalls[index])),
          );
        },
          child:Card(
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
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(color:  Color(0xff003b5c), fontWeight: FontWeight.bold, fontSize: 15)),
          const Text("", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          const Text("A44 Wits East Campus", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // conditional rendering of the buttons...
            isFollowing ?
            const OutlinedButton(
                // if already following this dh...
                // when pressed should do nothing...
                onPressed: null,
                child: Text("Following"))
                :
            ElevatedButton(
                // show this button if not following the dining hall...
                // when clicked should follow the dh...
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xff003b5c)
                ),
                onPressed: (){
              followDH(id);
            }, child: const Text("Follow", style:  TextStyle(color: Color(0xffbf9b30), fontSize: 14,fontWeight: FontWeight.bold),))
        ],)
      ],)
    )));

  }

  // Iterate the dining halls and create card for each dh...
  Widget listDH(BuildContext context){
    List<Widget> items = [];
    for(DiningObject data in diningHalls){
      bool isFollowing = dhFollowing.value == data.getID();
      items.add(DHItem(data.getDiningName(), data.getID(), isFollowing, context));
    }

    // return a column since it will accommodate many items...
    return Column(children: items);
  }

  // API call to follow a bus route...
  Future<void> followDH(String dhID) async{
    await http.post(Uri.parse("${uri}db/followDiningHall/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "id": dhID,
        })).then((value) {
      var data = jsonDecode(value.body);
      // update the bus following list...
      // the whole should update...
      dhFollowing.value = data['id'];
    });
  }
}