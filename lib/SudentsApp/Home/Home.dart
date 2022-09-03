import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../Buses/Buses.dart';
import '../Menu/Menu.dart';
import '../Dining/Dining.dart';
import '../Dashboard/Dashboard.dart';
import '../Protection/Protection.dart';


class Home extends HookWidget {
  // init var
  String username = "", email = "";
  List<Widget> _screens = [];
  List<bool> sub = [false, false];

  //constructor...
  Home(this.email, this.username, {Key? key}) : super(key: key);

  // var to keep track of the screen to show...


  @override
  Widget build(BuildContext context) {

    _screens = [Dashboard(username: username), Buses(), Dining(), Protection(), const Menu()];


    final screenIndex = useState(0);

    void _onNavigate(int index){
      screenIndex.value = index;
    }

    return Scaffold(
      body: _screens.elementAt(screenIndex.value),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenIndex.value,
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

}
