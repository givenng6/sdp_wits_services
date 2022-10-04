import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';

class DiningWidget extends StatefulWidget{

  @override
  State<DiningWidget> createState() => _DiningWidget();
}

class _DiningWidget extends State<DiningWidget>{

  List<DiningObject> diningHalls = [];
  String dhFollowing = "";
  String mealTime = "";

  List<String> option1Meals = [];
  List<String> option2Meals = [];
  List<String> option3Meals = [];

  String times = "";

  @override
  Widget build(BuildContext context){
    diningHalls = context.watch<Subscriptions>().diningHalls;
    dhFollowing =  context.watch<Subscriptions>().dhFollowing;
    mealTime =  context.watch<Subscriptions>().mealTime;

    // flag used to know if the user is following any dining hall...
    bool none = true;
    String dhName = "";

    // update times based on the time of the day
    // if is following dh update the flag
    // get the correct meals to show based on the time of the day
    for(DiningObject data in diningHalls){
      if(data.getID() == dhFollowing){
        dhName = data.getDiningName();
         none = false;

         if(mealTime == "Breakfast"){
           times = "06:00 - 09:00";
           List<dynamic> bfA = data.bfA;
           List<dynamic> bfB = data.bfB;
           List<dynamic> bfC= data.bfC;
           for(int i = 0; i < bfA.length; i++){
             option1Meals.add(bfA[i]);
           }

           for(int i = 0; i < bfB.length; i++){
             option2Meals.add(bfB[i]);
           }

           for(int i = 0; i < bfC.length; i++){
             option3Meals.add(bfC[i]);
           }
         }else if(mealTime == "Lunch"){
           times = "11:00 - 14:00";
           List<dynamic> A = data.lA;
           List<dynamic> B = data.lB;
           List<dynamic> C = data.lC;
           for(int i = 0; i < A.length; i++){
             option1Meals.add(A[i]);
           }

           for(int i = 0; i < B.length; i++){
             option2Meals.add(B[i]);
           }

           for(int i = 0; i < C.length; i++){
             option3Meals.add(C[i]);
           }
         }else{
           times = "16:00 - 19:00";
           List<dynamic> A = data.dA;
           List<dynamic> B = data.dB;
           List<dynamic> C = data.dC;
           for(int i = 0; i < A.length; i++){
             option1Meals.add(A[i]);
           }

           for(int i = 0; i < B.length; i++){
             option2Meals.add(B[i]);
           }

           for(int i = 0; i < C.length; i++){
             option3Meals.add(C[i]);
           }
         }

      }
    }

    // the dining service main card shown on the dashboard
    return Container(
      //height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        image: const DecorationImage(
            image: AssetImage('assets/food.jpg'),
            fit: BoxFit.cover
        ),
      ),

      // conditional rendering
      // if not following a dh show text
      // NO DATA
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.restaurant_menu, color: Colors.white,),
              Text("Dining Menu",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
            ],
          ),
          none ?
          const Text("No Data", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),)
          :
          MenuItem(dhName, mealTime, times),
        ],
      ),
    );
  }

  // the card with intel...
  Widget MenuItem(String dh, String meal, String times){
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
          Text(dh, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Text("Meal: $meal", style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Time: $times", style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          const Text(""),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Option 1", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c))),
                Text("Option 2", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c))),
                Text("Option 3", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c))),
              ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              listItems("1", option1Meals),
              listItems("2", option2Meals),
              listItems("3", option3Meals),
            ],
          ),
        ],
      ),
    );
  }

  // iterating on all the meals available...
  Widget listItems(String optionNo, List<String> meals){
    List<Widget> items = [];
    for(String meal in meals){
      items.add(Text(meal, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c)),));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
  }
}