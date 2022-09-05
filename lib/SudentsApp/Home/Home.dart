import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Buses/Buses.dart';
import '../Menu/Menu.dart';
import '../Dining/Dining.dart';
import '../Dashboard/Dashboard.dart';
import '../Protection/Protection.dart';

// Uri to the API
String uri = "http://192.168.137.217:8000/";
class Home extends HookWidget {
  // init var
  String username = "", email = "";
  List<Widget> _screens = [];

  //constructor...
  Home(this.email, this.username, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subs = useState([]);
    var isFetching = useState(true);

    useEffect(() {
      Future<void> getSubs() async{
        await http.post(Uri.parse("${uri}db/getSub/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": email,
            })).then((value) {
          var json = jsonDecode(value.body);
          subs.value = json["subs"];
          isFetching.value = false;
        });

      }
     getSubs();
    }, []);



    _screens = [Dashboard(isFetching, subs), Buses(email, subs), Dining(email, subs), Protection(email, subs), Menu(email, username, subs)];
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
