import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDU.dart';
import 'package:sdp_wits_services/StudentsApp/Events/Events.dart';
import 'package:sdp_wits_services/StudentsApp/Health/Health.dart';
import 'package:sdp_wits_services/StudentsApp/Menu/Department.dart';
import '../Utilities/AddSub.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
              String title = "Campus Health";
              String service = "health";
              List<String> data = [email, title, service];
              if(subs.value.contains(service)){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Health(email)),
                );
              }else{
                subDialog(context, data, subs);
              }
              break;
            case 4 :
              String title = "CCDU";
              String service = "health";
              List<String> data = [email, title, service];

              if(subs.value.contains(service)){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CCDU(email)),
                );
              }else{
                subDialog(context, data, subs);
              }
              break;
            case 5 :
              String title = "Events";
              String service = "events";
              List<String> data = [email, title, service];

              if(subs.value.contains(service)){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Events(email)),
                );
              }else{
                subDialog(context, data, subs);
              }
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
  
  void subDialog(BuildContext context, List<String> data, var subs){
    bool isLoading = false;
    showDialog(context: context,
        builder: (BuildContext context){
        return Center(
          child:  Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 3.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text(data[1], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(""),
                const Text("To access this service you must be subscribed"),
                isLoading ?
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
                  child: CircularProgressIndicator(),
                )
                    :
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        primary: Colors.red                ),
                    onPressed: (){
                      isLoading = true;
                      // must push data to database
                    },
                    child: const Text("Subscribe", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),))
              ]
            ),
          ),
        );
        }
    );
  }
  
}