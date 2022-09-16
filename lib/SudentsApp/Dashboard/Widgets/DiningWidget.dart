import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/SudentsApp/Dining/DiningObject.dart';


class DiningWidget extends HookWidget{

  var diningHalls = useState([]);
  var dhFollowing = useState("");
  DiningWidget(this.diningHalls, this.dhFollowing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    bool none = true;
    String dhName = "";

    for(DiningObject data in diningHalls.value){
      if(data.getID() == dhFollowing.value){
        dhName = data.getDiningName();
         none = false;
      }
    }

    return Container(
      //height: 300,
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
            image: AssetImage('assets/food.jpg'),
            fit: BoxFit.cover
        ),
      ),

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
          Text("No Data", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),)
          :
          MenuItem(dhName, "Lunch", "11:00 - 14:00", "kkk"),
        ],
      ),
    );
  }

  Widget MenuItem(String route, String status, String nextStop, String timeEstimate){
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
          Text("Meal: " + status, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Time: " + nextStop, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 1", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 2" , style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 3", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 4", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
          Text("Meal 5", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff003b5c))),
        ],
      ),
    );
  }
}