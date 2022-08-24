import 'package:flutter/material.dart';
import './DashAppBar.dart';
import './Widgets/BusWidget.dart';
import './Widgets/DiningWidget.dart';
import './Widgets/ProtectionWidget.dart';
import './Widgets/EventsWidget.dart';
import './Widgets/HealthWidget.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard>{

  // list of dashboard widgets to show to user...
  List<Widget> _cards = [BusWidget(), DiningWidget(), ProtectionWidget(), EventsWidget(), HealthWidget()];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          DashAppBar(),
          Text("My Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Expanded(
              child:
              ListView.builder(
                itemCount: _cards.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return _cards[index];
                }),)
        ],
      ),
    );
  }
}