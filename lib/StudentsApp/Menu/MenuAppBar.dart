import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';

class MenuAppBar extends StatefulWidget{
  const MenuAppBar({Key? key}) : super(key: key);

  @override
  State<MenuAppBar> createState() => _MenuAppBar();
}

class _MenuAppBar extends State<MenuAppBar>{

  // creating utility widget object...
  UtilityWidget utilityWidget = new UtilityWidget();

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
                utilityWidget.CircularProfile("Given Mathebula"),
                Text("Given Mathebula", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),)
        ],
      ),
    );
  }


}