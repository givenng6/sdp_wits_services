import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Profile/Profile.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import '../UtilityWidgets.dart';

class MenuAppBar extends StatefulWidget{

  @override
  State<MenuAppBar> createState() => _MenuAppBar();
}


class _MenuAppBar extends State<MenuAppBar>{

  // creating utility widget object...
  UtilityWidget utilityWidget = UtilityWidget();

  String username = "";

  @override
  Widget build(BuildContext context){
    username = context.watch<UserData>().username;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 45, 12, 12),
      decoration: const BoxDecoration(
        color: Color(0xff003b5c)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 12, 0, 20),
            child: GestureDetector(
              child: Row(
                children: [
                  utilityWidget.CircularProfile(username),
                  Text(username, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
                ],
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ),
          const Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),)
        ],
      ),
    );
  }


}