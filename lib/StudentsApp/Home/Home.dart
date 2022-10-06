import 'package:flutter/material.dart';
import '../Buses/Buses.dart';
import '../Menu/Menu.dart';
import '../Dining/Dining.dart';
import '../Dashboard/Dashboard.dart';
import '../Protection/protection.dart';

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

  List<Widget> _screens = [];

  //constructor...
  //Home(this.email, this.username, {Key? key}) : super(key: key);
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    _screens = [
      Dashboard(),
      Buses(),
      Dining(),
      Protection(),
      Menu(onNavigate: onNavigate),
    ];

    return Scaffold(
      body: _screens.elementAt(screenIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          selectedItemColor: const Color(0xff003b5c),
          onTap: onNavigate,
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
  void onNavigate(int index) {
    setState(() {
      screenIndex = index;
    });
  }


}
