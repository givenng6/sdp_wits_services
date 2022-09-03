import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../UtilityWidgets.dart';


class MenuAppBar extends HookWidget{


  // creating utility widget object...
  UtilityWidget utilityWidget = new UtilityWidget();

  String username = "", email = "";
  MenuAppBar(this.email, this.username, {Key? key}) : super(key: key);

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
            child: Row(
              children: [
                utilityWidget.CircularProfile(username),
                Text(username, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),)
        ],
      ),
    );
  }


}