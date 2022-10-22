import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart';

import 'Accpted.dart';
import 'All.dart';


class CCDU extends StatefulWidget {
  const CCDU({
    Key? key,
  }) : super(key: key);

  @override
  State<CCDU> createState() => _CCDUState();
}

class _CCDUState extends State<CCDU> {
  String username = " ";
  String email = "";
  String Date = " ";
  String Time = " ";
  String Description = " ";


  void _getSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username')!;
    email = sharedPreferences.getString('email')!;
    Date = sharedPreferences.getString('Date')!;
    Time = sharedPreferences.getString('Time')!;
    Description =  sharedPreferences.getString('Description')!;
    setState(() {});
  }

  @override
  void initState() {
    _getSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getName();
    // debugPrint("In build.... ${globals.ready}");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF013152),
            title: Row(
              children: [
                const Icon(Icons.psychology_outlined),
                const SizedBox(
                  width: 10.0,
                ),
                Text('CCDU')
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
                    text: 'Accepted',
                    icon: Icon(
                        key: Key('dinnerTab'), Icons.dinner_dining_rounded)),
                Tab(
                    text: 'All',
                    icon: Icon(
                        key: Key('breakfastTab'),
                        Icons.all_out_rounded)),
              ],
            ),
          ),
          body: TabBarView(children: [
            Accepted(),
            All()
            //AccordionWidget(type: "All"),
            //AccordionWidget(type: "Accepted")
          ])),
    );
  }
}
