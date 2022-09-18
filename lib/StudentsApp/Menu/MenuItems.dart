import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/Buses.dart';
import 'package:sdp_wits_services/StudentsApp/Menu/Department.dart';
import 'package:sdp_wits_services/StudentsApp/Profile/Profile.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/Protection.dart';

const String APP_VERSION = "version 1.0.2 (sprint2)";

class MenuItems extends HookWidget {
  List<Department> cardNames = [

    Department(title: "Buses", icon: Icons.directions_bus),
    Department(title: "Dining Services", icon: Icons.restaurant),
    Department(title: "Protection", icon: Icons.security),
    Department(title: "Campus Health", icon: Icons.health_and_safety),
    Department(title: "CCDU", icon: Icons.psychology_outlined),
    Department(title: "Events", icon: Icons.event),
  ];

  String email = "", username = "";
  var subs = useState([]);

  MenuItems(this.email, this.username, this.subs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(children: [
        ListMenu(context),
        const Text(APP_VERSION, style: TextStyle(fontSize: 10, color: Colors.grey),),
      ],
      )
    );
  }

  Widget ViewCard(int index, BuildContext context){
    return GestureDetector(
      onTap: (){
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Protection(email, subs)),
        // );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child:  Icon(cardNames[index].icon, color: Colors.blue,),
            ),
            Text(cardNames[index].title, style: const TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }

  Widget ListMenu(BuildContext context){
    List<Widget> items = [];
    for(int i = 0; i < cardNames.length; i++){
      items.add(ViewCard(i, context));
    }

    return Column(children: items,);
  }
}