import 'package:flutter/material.dart';
import 'package:sdp_wits_services/SignupAndLogin/StudentsSignin.dart';
import 'package:sdp_wits_services/SignupAndLogin/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../SudentsApp/Profile/Profile.dart';
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart';
import 'selectBeakfastPage.dart';
import 'selectLunchPage.dart';
import '../DiningGlobals.dart' as globals;
import 'selectDinnerPage.dart';

class mealSelecionPage extends StatefulWidget {
  final DateTime dateTime;

  mealSelecionPage({
    Key? key,
    required this.dateTime,
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
    setState(() {});
  }

  void getName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username')!;
    email = sharedPreferences.getString('email')!;
    dhName = sharedPreferences.getString('dhName')!;
    setState(() {});
  }

  @override
  void initState() {
    getName();
    getMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getName();
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
                  margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF013152),
                    child: Text(
                      username[0],
                      style: const TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
                  onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile(email, username)));
              })
              /*PopupMenuButton(
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF013152),
                      child: Text(
                        username[0],
                        style: const TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: ListTile(
                            ,
                            title: Text('Logout'),
                          ),
                        ),
                      ])*/
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                    text: 'Breakfast',
                    icon: Icon(Icons.breakfast_dining_rounded)),
                Tab(text: 'Lunch', icon: Icon(Icons.lunch_dining_rounded)),
                Tab(text: 'Dinner', icon: Icon(Icons.dinner_dining_rounded)),
              ],
            ),
          ),
          body: TabBarView(children: [
            selectBrakefastPage(
              dateTime: widget.dateTime,
            ),
            selectLunchPage(dateTime: widget.dateTime),
            selectDinnerPage(dateTime: widget.dateTime),
          ])),
    );
  }
}
