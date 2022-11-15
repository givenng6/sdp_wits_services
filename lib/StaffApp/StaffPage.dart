import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sdp_wits_services/StaffApp/Buses/View/buses_main.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/CampusControl.dart';
import 'package:sdp_wits_services/StaffApp/Department.dart';
import 'package:sdp_wits_services/StaffApp/Events/Views/events.dart';
import 'package:sdp_wits_services/StaffApp/SelectDH.dart';
import 'package:sdp_wits_services/StaffApp/CCDU/CCDU.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'DiningGlobals.dart' as globals;
import 'package:sdp_wits_services/globals.dart' as mainGlobals;

//Select department

class StaffPage extends StatefulWidget {
  const StaffPage({Key? key}) : super(key: key);

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  List<Department> departments = [
    Department(name: "Bus Services", icon: Icons.bus_alert),
    Department(name: "Campus Control", icon: Icons.security),
    Department(name: "Dining Services", icon: Icons.fastfood),
    Department(name: "CCDU", icon: Icons.health_and_safety),
    Department(name: "Events", icon: Icons.event),
  ];

  void chooseDep(String depName) async {
    //
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? email = sharedPreferences.getString("email");

    String? deviceID;
    await OneSignal.shared.getDeviceState().then((value) {
      deviceID = value!.userId;
    });

    await http.post(Uri.parse("${globals.url}/Users/AssignDep"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(
            <String, String>{"email": email!, "department": depName,"deviceID":deviceID!}));
  }

  void handleCard(int index) async {
    String departmentName = departments[index].name;
    chooseDep(departmentName);

    switch (departmentName) {
      case "Bus Services":
        {
          // debugPrint('here here');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const BusesMain()));
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString('department', 'Bus Services');
          mainGlobals.getSharedPreferences();
        }
        break;
      case "Dining Services":
        {
          // debugPrint('here here');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const SelectDH()));

          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString('department', 'Dining Services');
          mainGlobals.getSharedPreferences();
        }
        break;
      case "Campus Control":
        {
          // debugPrint('here here');

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const CampusControl()));
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString('department', 'Campus Control');
          mainGlobals.getSharedPreferences();
        }
        break;
      case "CCDU":
        {
          debugPrint('here here');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const CCDU()));
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString('department', 'CCDU');
          mainGlobals.getSharedPreferences();
        }
        break;
      case "Events":
        {

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Events()));

        }
        break;
      default:{
        return;
      }
    }
  }

  String username = " ";
    void getName() async {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      username = sharedPreferences.getString("username")!;
      setState(() {});
    }



    @override
    void initState() {
      getName();
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: const Color(0xff003b5c),
          appBar: AppBar(
            title: Image.asset("assets/NewLogo.jpg", fit: BoxFit.cover,
              key: const Key("logoImg"),),
            actions: <Widget>[
              Container(
                margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: CircleAvatar(
                  backgroundColor: const Color(0xff003b5c),
                  child: Text(
                    username[0],
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              )
            ],
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Departments",
                      style: TextStyle(fontSize: 35.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    children: List.generate(
                      departments.length,
                          (index) =>
                          SizedBox(
                            height: 100.0,
                            child: InkWell(
                              onTap: () {
                                handleCard(index);
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 60.0,
                                          child: Icon(
                                            key:Key(departments[index].name),
                                            departments[index].icon,
                                            size: 60.0,
                                            color: const Color(0xff003b5c),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          departments[index].name,
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                    ).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              )
            ],
          ));
    }
  }

