import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';

class ViewDH extends HookWidget{

  DiningObject dining;
  ViewDH(this.dining, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(dining.getDiningName()), backgroundColor: const Color(0xff003b5c),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Breakfast", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const Text("Option A", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    listMeals(dining.bfA),
                    const Text("Option B", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    listMeals(dining.bfB),
                    const Text("Option C", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    listMeals(dining.bfC),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Lunch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    const Text("Option A", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    listMeals(dining.lA),
                    const Text("Option B", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    listMeals(dining.lB),
                    const Text("Option C", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    listMeals(dining.lC),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Dinner", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    const Text("Option A", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    listMeals(dining.dA),
                    const Text("Option B", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    listMeals(dining.dB),
                    const Text("Option C", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    listMeals(dining.dC),
                  ],
                ),
              ),
          ],
        )),
      )
    );
  }

  Widget listMeals(List<dynamic> meals){
    List<Widget> items = [];
    for(String meal in meals){
      items.add(Text(meal));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
  }
}