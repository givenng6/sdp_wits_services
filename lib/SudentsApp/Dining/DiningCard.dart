
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/SudentsApp/Dining/DiningObject.dart';


class DiningCard extends HookWidget{

  List<DiningObject> diningHalls = [];
  DiningCard(this.diningHalls, {Key? key}) : super(key: key);

  Widget build(BuildContext context){
    return Container(
        padding: const EdgeInsets.all(12),
        child: listDH()
    );}

      Widget DHItem(String name, String id){
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
          Text(name, style: TextStyle(color: Color(0xff003b5c), fontWeight: FontWeight.bold, fontSize: 15)),
          const Text("", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("A44 Wits East Campus", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                child: OutlinedButton(onPressed: (){
                }, child: const Text("View Menu", style: TextStyle(color: Color(0xff003b5c)),))
            ),
          OutlinedButton(onPressed: (){

          }, child: Text("Follow", style: TextStyle(color: Color(0xff003b5c)),)),
        ],)
      ],)
    );

  }

  Widget listDH(){
    List<Widget> items = [];
    for(DiningObject data in diningHalls){
      items.add(DHItem(data.getDiningName(), data.getID()));
    }

    return Column(children: items);
  }
}