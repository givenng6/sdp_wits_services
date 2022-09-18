
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Uri to the API
String uri = "https://web-production-8fed.up.railway.app/";

class DiningCard extends HookWidget{

  List<DiningObject> diningHalls = [];
  var dhFollowing = useState("");
  String email = "";
  DiningCard(this.email, this.diningHalls, this.dhFollowing, {Key? key}) : super(key: key);

  Widget build(BuildContext context){
    return Container(
        padding: const EdgeInsets.all(12),
        child: listDH()
    );}

      Widget DHItem(String name, String id, isFollowing){
      return Card(
        color: Colors.white70,
          elevation: 2,
          child: Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: const EdgeInsets.all(12),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(color: Color(0xff003b5c), fontWeight: FontWeight.bold, fontSize: 15)),
          const Text("", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("A44 Wits East Campus", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
              followDH(id);
            }, child: const Text("Follow", style:  TextStyle(color: Color(0xffbf9b30), fontSize: 14,fontWeight: FontWeight.bold),))
        ],)
      ],)
    ));

  }

  Widget listDH(){
    List<Widget> items = [];
    for(DiningObject data in diningHalls){
      bool isFollowing = dhFollowing.value == data.getID();
      items.add(DHItem(data.getDiningName(), data.getID(), isFollowing));
    }

    return Column(children: items);
  }

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
      dhFollowing.value = data['id'];
    });
  }
}