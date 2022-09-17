library globals;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dining/Package.dart';
import 'package:http/http.dart' as http;

String url = "https://sdp-staff-backend.herokuapp.com";
String dhName = "";

List<Package> breakfast = [];
List<Package> lunch = [];
List<Package> dinner = [];

List<String> selectedBreakfast = [];
List<String> selectedLunch = [];
List<String> selectedDinner = [];

bool ready = false;

parse(curr) {
  List<Package> output = [];
  for (int i = 0; i < curr.length; i++) {
    dynamic temp = curr[i];
    List<String> items = [];
    for (int j = 0; j < temp["contents"].length; j++) {
      items.add(temp["contents"][j]);
    }
    output.add(Package(
        packageName: temp["packageName"], items: items, id: temp["id"]));
  }

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

  selectedBreakfast = json["selected"]["selectedBreakfast"].cast<String>();
  selectedLunch = json["selected"]["selectedLunch"].cast<String>();
  selectedDinner = json["selected"]["selectedDinner"].cast<String>();

  ready=true;
}
