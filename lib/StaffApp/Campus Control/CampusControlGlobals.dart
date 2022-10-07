library globals;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sdp_wits_services/StaffApp/Campus%20Control/Vehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';

String url = "https://sdp-staff-backend.herokuapp.com";
// String url = "http://localhost:5000";
late Vehicle vehicle;
String campusName = "";
List<Vehicle>vehicles = [];
List<String>campuses = [];

Future<void> StartShift(String campusNamee)async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? username = sharedPreferences.getString("username");
  Map<String,dynamic> info ={
    "campusName": campusNamee,
    "carName": vehicle.name,
    "numPlate": vehicle.id,
    "driverName": username!,
    "seats": vehicle.seats
  };
  campusName = campusNamee;

  var result = await http.post(Uri.parse("$url/CampusControl/StartShift"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, dynamic>{"info": info}));

  var json = jsonDecode(result.body);

  debugPrint("$json");

}

Future<void> GetVehicles()async {

  var result = await http.get(Uri.parse("$url/CampusControl/GetVehicles"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },);

  var json = jsonDecode(result.body);

  GetCampus();

  if(json["status"]=="success"){
      List temp = json["vehicles"] as List;
    vehicles.clear();
    for(int i = 0;i<temp.length;i++){
      vehicles.add(Vehicle(temp[i]));
    }

  }
}

Future<void> EndShift()async {
  var result = await http.post(Uri.parse("$url/CampusControl/EndShift"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, dynamic>{"campusName": campusName,"numPlate":vehicle.id}));

}

Future<void> GetCampus()async {

  var result = await http.get(Uri.parse("$url/CampusControl/GetCampus"),
    headers: <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8",
    },);

  var json = jsonDecode(result.body);


  if(json["status"]=="success"){
    List temp = json["campus"] as List;
    campuses.clear();
    for(int i = 0;i<temp.length;i++){
      campuses.add(temp[i]);
    }

  }

}