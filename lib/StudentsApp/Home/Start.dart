import 'package:flutter/material.dart';
import '../Providers/Subscriptions.dart';
import '../Buses/BusObject.dart';
import '../Dining/DiningObject.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/StudentsApp/Home/Home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Uri to the API
String uri = "https://web-production-8fed.up.railway.app/";

class Start extends StatefulWidget{
  @override
  State<Start> createState()=> _Start();
}

class _Start extends State<Start>{

  String email = "2381410@students.wits.ac.za";
  String username = "Given";
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    //getSharedPreferences();
    getSubs(context);
    getBusFollowing(context);
    getBusSchedule(context);
    getDiningHallFollowing(context);
    getDiningHalls(context);
    getMealTime(context);

  }

  // getSharedPreferences() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   username = sharedPreferences.getString('username');
  //   email = sharedPreferences.getString('email');
  // }

  Future<void> getSubs(BuildContext context) async {
    await http.post(Uri.parse("${uri}db/getSub/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
        })).then((value) {
          var json = jsonDecode(value.body);
          // update the sub provider
          for(String service in json["subs"]){
            context.read<Subscriptions>().addSub(service);
          }

        });
  }

  Future<void> getBusFollowing(BuildContext context) async {
    await http.post(Uri.parse("${uri}db/getBusFollowing/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
        })).then((value) {
        var busData = jsonDecode(value.body);
        List<String> busFollowing = [];
        for(String bus in busData){
          busFollowing.add(bus);
        }
        context.read<Subscriptions>().updateBusFollowing(busFollowing);
    });
  }

  Future<void> getBusSchedule(BuildContext context) async {
    await http.get(Uri.parse("${uri}db/getBusSchedule/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        }).then((response) {
        var toJSON = jsonDecode(response.body);
        List<BusObject> tempSchedule = [];
        for (var data in toJSON) {
        String pos = "";
        if (data['position'] != null) {
          pos = data['position'];
        }
        tempSchedule.add(BusObject(data['name'], data['id'], data['stops'], data['status'], pos));
      }
      context.read<Subscriptions>().setBusSchedule(tempSchedule);
      Future.delayed(const Duration(seconds: 5), (){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    Home()),
                (Route<dynamic> route) => false);
      });

    });
  }

  Future<void> getDiningHallFollowing(BuildContext context) async {
    await http.post(Uri.parse("${uri}db/getDiningHallFollowing/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
        })).then((value) {
        var data = jsonDecode(value.body);
        context.read<Subscriptions>().updateDHFollowing(data);
    });
  }

  Future<void> getDiningHalls(BuildContext context) async {
    await http.get(Uri.parse("${uri}db/getDiningHalls/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        }).then((response) {
      var toJSON = jsonDecode(response.body);
      List<DiningObject> tempList = [];
      for (var data in toJSON) {
        tempList.add(DiningObject(
            data['name'],
            data['id'],
            data['breakfast']['optionA'],
            data['breakfast']['optionB'],
            data['breakfast']['optionC'],
            data['lunch']['optionA'],
            data['lunch']['optionB'],
            data['lunch']['optionC'],
            data['dinner']['optionA'],
            data['dinner']['optionB'],
            data['dinner']['optionC']));
      }
      context.read<Subscriptions>().setDiningHalls(tempList);
    });
  }

  Future<void> getMealTime(BuildContext context) async {
    await http.get(Uri.parse("${uri}db/getTime/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        }).then((response) {
      var data = jsonDecode(response.body);
      context.read<Subscriptions>().setMealTime(data);
    });
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xff003b5c),
        ),
      ),
    );
  }
}