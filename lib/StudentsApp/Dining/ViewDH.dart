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
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  image: const DecorationImage(
                      image: AssetImage('assets/breakfast.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Breakfast", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    listMeals(dining.bfA, "1"),
                    listMeals(dining.bfB, "2"),
                    listMeals(dining.bfC, "3"),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  image: const DecorationImage(
                      image: AssetImage('assets/junk.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Lunch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    listMeals(dining.lA, "1"),
                    listMeals(dining.lB, "2"),
                    listMeals(dining.lC, "3"),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  image: const DecorationImage(
                      image: AssetImage('assets/dinner.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Dinner", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    listMeals(dining.dA, "1"),
                    listMeals(dining.dB, "2"),
                    listMeals(dining.dC, "3"),
                  ],
                ),
              ),
          ],
        )),
      )
    );
  }

  Widget listMeals(List<dynamic> meals, String opt){
    List<Widget> items = [];

    items.add(Text("Option $opt", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),);
    for(String meal in meals){
      items.add(Text(meal, style: const TextStyle(fontWeight: FontWeight.w600),));
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0x80ffffff),
      ),child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: items),
    );
  }
}