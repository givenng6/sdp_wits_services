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
          DashHeader(),
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

  Widget DashHeader(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Suggestions:"),
          //Text("My Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SuggestedItem("Campus Health"),
              SuggestedItem("Events"),
              SuggestedItem("CCDU")
            ],
          )
        ],
      ),
    );
  }

  Widget SuggestedItem(String title){
    return Container(
      padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xff003b5c),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          _getIcon(title),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white))
        ],
      ),
    );
  }

  // return icon base on title...
  Widget _getIcon(String title){
    switch (title){
      case 'Campus Health':
        return Icon(Icons.health_and_safety, color: Colors.redAccent, size: 19,);
        break;
      case 'Events':
        return Icon(Icons.event, color: Colors.white, size: 19,);
        break;
      case 'CCDU':
        return Icon(Icons.health_and_safety_outlined, color: Colors.green, size: 19,);
        break;
      default:
        return Icon(Icons.home, color: Colors.white, size: 19,);
        break;
    }
  }
}