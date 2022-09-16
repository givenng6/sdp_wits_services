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

// Uri to the API
String uri = "https://web-production-8fed.up.railway.app/";

class Home extends HookWidget {
  // init var
  String username = "", email = "";
  List<Widget> _screens = [];

  //constructor...
  Home(this.email, this.username, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // data to pass to other screens...
    var busSchedule = useState([]);
    var diningHalls = useState([]);
    var subs = useState([]);
    var isFetching = useState(true);
    var busFollowing = useState([]);

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

      Future<void> getBusFollowing() async{
        await http.post(Uri.parse("${uri}db/getBusFollowing/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": email,
            })).then((value) {
          var busData = jsonDecode(value.body);
          busFollowing.value = busData;
        });
      }

      Future<void> getBusSchedule() async{
        await http.get(Uri.parse("${uri}db/getBusSchedule/"),
            headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
            }).then((response){
              var toJSON = jsonDecode(response.body);
              List<BusObject> tempSchedule = [];
              for(var data in toJSON){
                //print(data['name']);
                tempSchedule.add(BusObject(data['name'], data['id'], data['stops']));
              }
              busSchedule.value = tempSchedule;

        });
      }

      Future<void> getDiningHalls() async{
        await http.get(Uri.parse("${uri}db/getDiningHalls/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            }).then((response){
          var toJSON = jsonDecode(response.body);
          List<DiningObject> tempList = [];
          for(var data in toJSON){
            //print(data['name']);
            tempList.add(DiningObject(data['name'], data['id']));
          }
          diningHalls.value = tempList;

        });
      }

      getSubs();
      getBusSchedule();
      getBusFollowing();
      getDiningHalls();
    }, []);

    _screens = [Dashboard(isFetching, subs, busSchedule, busFollowing), Buses(email, subs, busSchedule, busFollowing), Dining(email, subs, diningHalls), Protection(email, subs), Menu(email, username, subs)];
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
