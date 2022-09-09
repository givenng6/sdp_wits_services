import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Buses/buses_main.dart';
import 'package:sdp_wits_services/StaffApp/Department.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({Key? key}) : super(key: key);

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  List<Department> departments = [
    Department(name: "Bus Services", icon: Icons.bus_alert),
    Department(name: "Campus Control", icon: Icons.security),
    Department(name: "Dining Hall", icon: Icons.fastfood),
    Department(name: "CCDU", icon: Icons.health_and_safety),
    Department(name: "Campus Health", icon: Icons.health_and_safety),
    Department(name: "Events", icon: Icons.event)
  ];

  void handleCard(int index) {
    String departmentName = departments[index].name;

    switch (departmentName) {
      case "Campus Control":
        {
          Navigator.pushReplacementNamed(context, "/CampusControl");
        }
        break;
      case "Bus Services":
        {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (BuildContext context) => const BusesMain()));
        }
        break;
      default:
        {
          return;
        }
    }
  }

  // List<Department>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff003b5c),
        appBar: AppBar(
          title: Image.asset("assets/NewLogo.jpg", fit: BoxFit.cover),
          actions: <Widget>[
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: const CircleAvatar(
                backgroundColor: Color(0xff31AFB4),
                child: Text(
                  "L",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
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
                    (index) => SizedBox(
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
                                      departments[index].icon,
                                      size: 60.0,
                                      color: const Color(0xff31AFB4),
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
