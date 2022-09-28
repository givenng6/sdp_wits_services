import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDU.dart';
import 'package:sdp_wits_services/StudentsApp/Events/Events.dart';
import 'package:sdp_wits_services/StudentsApp/Health/Health.dart';
import 'package:sdp_wits_services/StudentsApp/Menu/Department.dart';

const String APP_VERSION = "version 1.0.3 (sprint3)";

class MenuItems extends HookWidget {
  List<Department> cardNames = [

    Department(title: "Bus Services", icon: Icons.directions_bus),
    Department(title: "Dining Services", icon: Icons.restaurant),
    Department(title: "Protection Services", icon: Icons.security),
    Department(title: "Campus Health", icon: Icons.health_and_safety),
    Department(title: "Counselling Careers Development Unit", icon: Icons.psychology_outlined),
    Department(title: "Events", icon: Icons.event),
  ];

  String email = "", username = "";
  var subs = useState([]);
  var screenIndex = useState(0);

  MenuItems(this.email, this.username, this.subs, this.screenIndex, {Key? key}) : super(key: key);

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
        if(index < 3){
          screenIndex.value = index + 1;
        }else{
          switch (index){
            case 3 :
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Health(email)),
              );
              break;
            case 4 :
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CCDU(email)),
              );
              break;
            case 5 :
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Events(email)),
              );
              break;
          }
        }
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