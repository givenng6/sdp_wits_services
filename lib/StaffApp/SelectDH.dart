import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart';
import 'package:http/http.dart' as http;
import 'DiningGlobals.dart' as globals;

import 'Dining/mealSelectionPage.dart';

class SelectDH extends StatefulWidget {
  const SelectDH({Key? key}) : super(key: key);

  @override
  State<SelectDH> createState() => _SelectDHState();
}

class _SelectDHState extends State<SelectDH> {
  List<String> DiningHalls = [
    "Main",
    "Jubilee",
    "Convocation",
    "Highfield",
    "Ernest Openheimer",
    "Knockando"
  ];

  String username = " ";

  void getName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username')!;
    setState(() {});
  }

  void chooseDH(String dhName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? email = sharedPreferences.getString("email");
    sharedPreferences.setString('dhName', dhName);

    var result = await http.post(Uri.parse("${globals.url}/Users/AssignDep"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email!,
          "department": "Dining Services",
          "dhName": dhName
        }));
    var json = jsonDecode(result.body);

    debugPrint("${json["status"]}");

  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.fastfood),
            SizedBox(width: 10.0,),
            const Text("Dining Hall"),
          ],
        ),
        actions: [
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
                    MaterialPageRoute(builder: (context) => const Profile()));
              })
        ],
        backgroundColor: const Color(0xFF003b5c),
        centerTitle: false,
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
          child: ListView.builder(
              itemCount: DiningHalls.length,
              itemBuilder: (context, index) => Card(
                color:  const Color(0xFF003b5c),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 15.0),
                        child: ListTile(
                          enabled: true,
                          title: Center(
                            child: Text(
                              DiningHalls[index],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            chooseDH(DiningHalls[index]);
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (BuildContext context) => mealSelecionPage(dateTime: DateTime.now())));
                          },
                        )
                    ),
                  ],
                ),
              ))),
    );
  }
}
