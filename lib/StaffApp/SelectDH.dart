import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        title: const Text("DH Name"),
        centerTitle: true,
      ),
      body: Container(
          child: ListView.builder(
              itemCount: DiningHalls.length,
              itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      chooseDH(DiningHalls[index]);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (BuildContext context) => mealSelecionPage(dateTime: DateTime.now())));
                    },
                    title: Text(DiningHalls[index]),
                  ))),
    );
  }
}
