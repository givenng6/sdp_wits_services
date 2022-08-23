import 'package:flutter/material.dart';
import './DashAppBar.dart';
import './Widgets/BusWidget.dart';
import './Widgets/DiningWidget.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          DashAppBar(),
          SingleChildScrollView(
            child: Column(
              children: [
                Text("My Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
                BusWidget(),
                DiningWidget(),

              ],
            ),

          ),

        ],
      ),
    );
  }
}