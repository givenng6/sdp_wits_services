import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDU.dart';
import 'package:sdp_wits_services/StudentsApp/Events/Events.dart';
import 'package:sdp_wits_services/StudentsApp/Health/Health.dart';
import 'package:sdp_wits_services/StudentsApp/Menu/Department.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import '../Utilities/AddSub.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String APP_VERSION = "version 1.0.4 (sprint4)";

class MenuItems extends StatefulWidget{
  final Function(int index) onNavigate;
  MenuItems({required this.onNavigate});
  @override
  State<MenuItems> createState() => _MenuItems();
}

class _MenuItems extends State<MenuItems> {
  List<Department> cardNames = [
    Department(title: "Bus Services", icon: Icons.directions_bus),
    Department(title: "Dining Services", icon: Icons.restaurant),
    Department(title: "Protection Services", icon: Icons.security),
    Department(title: "Campus Health", icon: Icons.health_and_safety),
    Department(title: "Counselling Careers Development Unit", icon: Icons.psychology_outlined),
    Department(title: "Events", icon: Icons.event),
  ];

  String email = "";
  List<String> subs = [];
  int screenIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    email = context.watch<UserData>().email;
    subs = context.watch<Subscriptions>().subs;

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
          widget.onNavigate(index + 1);
        }else{
          switch (index){
            case 3 :
              String title = "Campus Health";
              String service = "health";
              List<String> data = [email, title, service];
              if(subs.contains(service)){
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

              if(subs.contains(service)){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CCDU()),
                );
              }else{
                subDialog(context, data, subs);
              }
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


  void subDialog(BuildContext context, List<String> data, var subs){

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
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        primary: Colors.red                ),
                    onPressed: (){
                      setState(() {
                        Navigator.pop(context);
                      });
                      _addSub(data[0], data[2]);
                    },
                    child: const Text("Subscribe", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),))
              ]
            ),
          ),
        );
        }
    );
  }

  Future<void> _addSub(String email, String service) async{
    await http.post(Uri.parse("${uri}db/addSub/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "service": service
        })).then((value){
        context.read<Subscriptions>().addSub(service);
    });
  }
  
}