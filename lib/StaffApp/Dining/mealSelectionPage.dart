import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Dining/AccordionWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart';
import '../DiningGlobals.dart' as globals;

class mealSelecionPage extends StatefulWidget {
  const mealSelecionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<mealSelecionPage> createState() => _mealSelecionPageState();
}

class _mealSelecionPageState extends State<mealSelecionPage> {
  String username = " ";
  String email = "";
  String dhName = " ";

  getMenus() async {
    await globals.getMenus();
    debugPrint("in here");
    setState(() {});
  }

  void _getSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username')!;
    email = sharedPreferences.getString('email')!;
    dhName = sharedPreferences.getString('dhName')!;
    setState(() {});
  }

  @override
  void initState() {
    _getSharedPreferences();
    getMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getName();
    debugPrint("In build.... ${globals.ready}");
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF013152),
            title: Row(
              children: [
                const Icon(Icons.fastfood),
                const SizedBox(
                  width: 10.0,
                ),
                Text(dhName)
              ],
            ),
            centerTitle: true,
            actions: <Widget>[
              InkWell(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF013152),
                      child: Text(
                        username[0],
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(email, username)));
                  })
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                    text: 'Breakfast',
                    icon: Icon(
                        key: Key('breakfastTab'),
                        Icons.breakfast_dining_rounded)),
                Tab(
                    text: 'Lunch',
                    icon:
                        Icon(key: Key('lunchTab'), Icons.lunch_dining_rounded)),
                Tab(
                    text: 'Dinner',
                    icon: Icon(
                        key: Key('dinnerTab'), Icons.dinner_dining_rounded)),
              ],
            ),
          ),
          body: TabBarView(children: [
            AccordionWidget(type: "breakfast"),
            AccordionWidget(type: "lunch"),
            AccordionWidget(type: "dinner"),
          ])),
    );
  }
}
