import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Buses/Buses.dart';
import '../Menu/Menu.dart';
import '../Dining/Dining.dart';
import '../Dashboard/Dashboard.dart';
import '../Protection/Protection.dart';
import '../Buses/BusObject.dart';
import '../Dining/DiningObject.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';

// Uri to the API
String uri = "https://web-production-8fed.up.railway.app/";

class Home extends StatefulWidget{

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home>{

  void initState(){
    super.initState();
  }

  // init var
  String username = "", email = "";
  List<Widget> _screens = [];

  //constructor...
  //Home(this.email, this.username, {Key? key}) : super(key: key);
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {

    // print(context.watch<Subscriptions>().subs);
    // print(context.watch<Subscriptions>().busFollowing);
    // data to pass to other screens...
    // var busSchedule = useState([]);
    // var diningHalls = useState([]);
    // var subs = useState([]);
    // var isFetching = useState(false);
    // var busFollowing = useState([]);
    // var dhFollowing = useState("");
    // var mealTime = useState("");

    // use effect for API calls



    _screens = [
      // Dashboard(isFetching.value, subs.value, busSchedule.value, busFollowing.value, diningHalls.value,
      //     dhFollowing.value, mealTime.value),
      // Buses(email, context.watch<Subscriptions>().subs, busSchedule.value, busFollowing.value),
      // Dining(email, subs.value, diningHalls.value, dhFollowing.value),
      // Protection(email, subs),
      // Menu(email, username, subs.value, screenIndex)
      Center(child: Text("1"),),
      Buses(),
      Center(child: Text("3"),),
      Center(child: Text("4"),),
      Center(child: Text("5"),),
    ];

    return Scaffold(
      body: _screens.elementAt(screenIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          selectedItemColor: const Color(0xff003b5c),
          onTap: _onNavigate,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                label: 'Dashboard', icon: Icon(Icons.dashboard)),
            BottomNavigationBarItem(
                label: 'Buses', icon: Icon(Icons.bus_alert)),
            BottomNavigationBarItem(
                label: 'Dining Hall', icon: Icon(Icons.fastfood)),
            BottomNavigationBarItem(
                label: 'Protection', icon: Icon(Icons.security)),
            BottomNavigationBarItem(label: 'Menu', icon: Icon(Icons.menu)),
          ]),
    );
  }

  // method to change the bottom nav index...
  void _onNavigate(int index) {
    setState(() {
      screenIndex = index;
      print(screenIndex);
    });
  }

}
