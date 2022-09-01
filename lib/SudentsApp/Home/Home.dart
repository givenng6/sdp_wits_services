import 'package:flutter/material.dart';
import '../Buses/Buses.dart';
import '../Menu/Menu.dart';
import '../Dining/Dining.dart';
import '../Dashboard/Dashboard.dart';
import '../Protection/Protection.dart';

class Home extends StatefulWidget {
  // required data
  String username, email;
  Home({Key? key, required this.username, required this.email}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {

  bool sub = true;
  // var to keep track of the screen to show...
  int _screenIndex = 0;
  final List<Widget> _screens = [Dashboard(username: "The username"), Buses(sub: false), const Dining(), const Protection(), const Menu()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_screenIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screenIndex,
        selectedItemColor:  const Color(0xff003b5c),
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
        BottomNavigationBarItem(
              label: 'Menu', icon: Icon(Icons.menu)),
      ]),
    );
  }

  // method to change the bottom nav index...
  void _onNavigate(int index){
    setState(() {
      _screenIndex = index;
    });
  }
}
