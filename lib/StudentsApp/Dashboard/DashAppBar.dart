import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';

class DashAppBar extends StatelessWidget{
  const DashAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    UtilityWidget utilityWidget = new UtilityWidget();

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 45, 0, 15),
      decoration: const BoxDecoration(
        color: Color(0xff003b5c)
      ),
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(image: AssetImage("assets/logo.png"), width: 120, height:  50,),
              utilityWidget.CircularProfile("Given Mathebula"),
            ],
          )

    );
  }
}