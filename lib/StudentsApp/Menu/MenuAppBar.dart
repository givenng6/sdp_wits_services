import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Profile/Profile.dart';
import '../UtilityWidgets.dart';


class MenuAppBar extends HookWidget{

  // creating utility widget object...
  UtilityWidget utilityWidget = UtilityWidget();

  String username = "", email = "";
  List<dynamic> subs = [];
  MenuAppBar(this.email, this.username, var subs,{Key? key}) : super(key: key){
    this.subs = subs.value;
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12, 45, 12, 12),
      decoration: BoxDecoration(
        color: Color(0xff003b5c)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: GestureDetector(
              child: Row(
                children: [
                  utilityWidget.CircularProfile(username),
                  Text(username, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
                ],
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(email, username, subs)),
                );
              },
            ),
          ),
          Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),)
        ],
      ),
    );
  }


}