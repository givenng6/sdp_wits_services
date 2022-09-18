library globals;

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dining/Package.dart';
import 'package:http/http.dart' as http;

String url = "https://sdp-staff-backend.herokuapp.com";
String dhName = "";

List<Package> breakfast = [];
List<Package> lunch = [];
List<Package> dinner = [];

List<Package> selectedBreakfast = [];
List<Package> selectedLunch = [];
List<Package> selectedDinner = [];

bool ready = false;

parse(curr) {
  List<Package> output = [];
  output.add(Package(
      packageName: "Option A",
      items: curr["OptionA"].cast<String>(),
      id: "opA"));
  output.add(Package(
      packageName: "Option B",
      items: curr["OptionB"].cast<String>(),
      id: "opB"));
  output.add(Package(
      packageName: "Option C",
      items: curr["OptionC"].cast<String>(),
      id: "opC"));
  return output;
}

parseSelected(curr) {
  List<Package> output = [];
  // debugPrint("$curr");
  output.add(Package(
      packageName: "Option A",
      items: curr["optionA"].cast<String>(),
      id: "1"));
  output.add(Package(
      packageName: "Option B",
      items: curr["optionB"].cast<String>(),
      id: "2"));
  output.add(Package(
      packageName: "Option C",
      items: curr["optionC"].cast<String>(),
      id: "3"));

  return output;
}

Future<void> getMenus() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  dhName = sharedPreferences.getString("dhName")!;
  var result = await http.post(Uri.parse("$url/Menus/GetMenus"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{"dhName": dhName}));
  var json = jsonDecode(result.body);

  breakfast = parse(json["original"]["breakfast"]);
  lunch = parse(json["original"]["lunch"]);
  dinner = parse(json["original"]["dinner"]);

  selectedBreakfast = parseSelected(json["selected"]["selectedBreakfast"]);
  selectedLunch = parseSelected(json["selected"]["selectedLunch"]);
  selectedDinner = parseSelected(json["selected"]["selectedDinner"]);

  debugPrint("hellllllooo");

  ready = true;
}
