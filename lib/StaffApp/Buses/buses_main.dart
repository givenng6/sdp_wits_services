import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BusesMain extends StatefulWidget {
  const BusesMain({Key? key}) : super(key: key);

  @override
  State<BusesMain> createState() => _BusesMainState();
}

class _BusesMainState extends State<BusesMain> {
  String uri = 'https://sdp-staff-backend.herokuapp.com/';
  String? username;
  String? email;
  bool isFabVisible = true;
  bool shouldFabBeVisible = false;
  bool clickingEnabled = true;
  int tapped = -1;
  int selectedCardIndex = -1;
  FabDecoration fabDecoration =
      FabDecoration(text: 'Start Shift', color: const Color(0xFF03560F));

  List? routes;

  List takenRoutes = [];

  handleCardOnTap(index) {
    setState(() {
      if (tapped == index) {
        tapped = -1;
        shouldFabBeVisible = false;
      } else {
        tapped = index;
        selectedCardIndex = index;
        shouldFabBeVisible = true;
        isFabVisible = true;
      }
    });
  }

  handleFloatingActionButton() async {
    setState(() {
      isFabVisible = false;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      if (fabDecoration.text == 'Start Shift') {
        fabDecoration.text = 'End Shift';
        fabDecoration.color = const Color(0xFF851318);
        clickingEnabled = false;
        assignDriverToRoute();
      } else {
        fabDecoration.text = 'Start Shift';
        fabDecoration.color = const Color(0xFF03560F);
        clickingEnabled = true;
        removeDriverFromRoute();
        // tapped = -1;
        // shouldFabBeVisible = false;
      }
      isFabVisible = true;
    });
  }

  assignDriverToRoute() async {
    Random random = Random();
    int randomNumber =
        random.nextInt(routes![selectedCardIndex]['stops'].length);
    String stop = routes![selectedCardIndex]['stops'][randomNumber];
    await http.post(Uri.parse("${uri}assignDriverToRoute"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          'routeId': routes![selectedCardIndex]['id'],
          'driver': email!,
          'position': stop
        }));
  }

  removeDriverFromRoute() async {
    await http.post(Uri.parse("${uri}removeDriverFromRoute"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          'routeId': routes![selectedCardIndex]['id'],
          'driver': email!,
        }));
  }

  getSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username');
    email = sharedPreferences.getString('email');
    setState(() {});
  }

  keepDriverOnShift() {
    for (int index = 0; index < routes!.length; index++) {
      List driversOnRoute = routes![index]['driversOnRoute'].toList();
      if (driversOnRoute.isNotEmpty && driversOnRoute[0] == email) {
        tapped = index;
        selectedCardIndex = index;
        shouldFabBeVisible = true;
        isFabVisible = true;

        fabDecoration.text = 'End Shift';
        fabDecoration.color = const Color(0xFF851318);
        clickingEnabled = false;
      } else if (driversOnRoute.isNotEmpty && driversOnRoute[0] != email) {
        takenRoutes.add(routes![index]);
      }
    }
    debugPrint(takenRoutes.toString());
  }

  Future getRoutes() async {
    await http.get(
      Uri.parse("${uri}getRoutes"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
    ).then((value) {
      List json = jsonDecode(value.body);
      routes = json;
      // setState(() {});
      keepDriverOnShift();
    });
  }

  @override
  void initState() {
    getSharedPreferences();
    getRoutes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              if (!isFabVisible) {
                setState(() {
                  isFabVisible = true;
                });
              }
            } else if (notification.direction == ScrollDirection.reverse) {
              if (isFabVisible) {
                setState(() {
                  isFabVisible = false;
                });
              }
            }
            return true;
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 150.0,
                collapsedHeight: 60,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    children: const [
                      Icon(
                        Icons.bus_alert,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Buses',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                actions: [
                  (username != null)
                      ? InkWell(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xff003b5c),
                              radius: 22.0,
                              child: Text(
                                username![0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Profile(email, username)));
                          },
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: const CircleAvatar(
                            backgroundColor: Color(0xff003b5c),
                            radius: 22.0,
                            child: Text(''),
                          ),
                        ),
                ],
              ),
              (routes != null)
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return InkWell(
                            onTap: takenRoutes.contains(routes![index])?null: () => handleCardOnTap(index),
                            child: Card(
                              color: (index == tapped)
                                  ? Colors.grey
                                  : const Color(0xFF003b5c),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0, vertical: 15.0),
                                      child: ListTile(
                                        enabled: clickingEnabled,
                                        title: Center(
                                          child: Text(
                                            routes![index]['name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                        trailing: !takenRoutes.contains(routes![index])?null: const Text('TAKEN', style: TextStyle(color: Colors.white),),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: routes!.length,
                      ),
                    )
                  : const SliverToBoxAdapter(
                      child: Center(
                        child: Text(''),
                      ),
                    ),
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height/3,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: (isFabVisible && shouldFabBeVisible)
            ? SizedBox(
                height: 50.0,
                width: 100.0,
                child: FloatingActionButton(
                  backgroundColor: fabDecoration.color,
                  onPressed: () {
                    handleFloatingActionButton();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(fabDecoration.text),
                ),
              )
            : null);
  }
}

class FabDecoration {
  late String text;
  late Color color;

  FabDecoration({required this.text, required this.color});
}

//  http://192.168.7.225:5000/assignDriverToRoute
