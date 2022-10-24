import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../View/buses_main.dart';

class BusesController extends GetxController{
  String uri = 'https://sdpwitsservices-production.up.railway.app/';
  String? username;
  String? email;
  var isFabVisible = true.obs;
  var shouldFabBeVisible = false.obs;
  var clickingEnabled = true.obs;
  var tapped = -1.obs;
  var selectedCardIndex = -1.obs;
  var fabDecoration =
  FabDecoration(text: 'Start Shift', color: const Color(0xFF03560F)).obs;

  List routes = [];

  List takenRoutes = [];

  handleCardOnTap(index) {
      if (tapped == index) {
        tapped = -1;
        shouldFabBeVisible(false);
      } else {
        tapped = index;
        selectedCardIndex = index;
        shouldFabBeVisible(true);
        isFabVisible(true);
      }
  }

  handleFloatingActionButton() async {
      isFabVisible(false);
    await Future.delayed(const Duration(milliseconds: 500));
      if (fabDecoration.value.text == 'Start Shift') {
        fabDecoration(FabDecoration(text: 'End Shift', color: const Color(0xFF851318)));
        clickingEnabled(false);
        assignDriverToRoute();
      } else {
        fabDecoration(FabDecoration(text: 'Start Shift', color: const Color(0xFF03560F)));
        clickingEnabled(true);
        removeDriverFromRoute();
      }
      isFabVisible(true);
  }

  assignDriverToRoute() async {
    Random random = Random();
    int randomNumber =
    random.nextInt(routes[selectedCardIndex]['stops'].length);
    String stop = routes[selectedCardIndex]['stops'][randomNumber];
    await http.post(Uri.parse("${uri}assignDriverToRoute"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          'routeId': routes[selectedCardIndex]['id'],
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
          'routeId': routes[selectedCardIndex]['id'],
          'driver': email!,
        }));
  }

  Future<void> getSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username');
    email = sharedPreferences.getString('email');
  }

  keepDriverOnShift() {
    for (int index = 0; index < routes.length; index++) {
      List driversOnRoute = routes[index]['driversOnRoute'].toList();
      if (driversOnRoute.isNotEmpty && driversOnRoute[0] == email) {
        tapped = index;
        selectedCardIndex = index;
        shouldFabBeVisible(true);
        isFabVisible(true);

        fabDecoration(FabDecoration(text: 'End Shift', color: const Color(0xFF851318)));
        clickingEnabled(false);
      } else if (driversOnRoute.isNotEmpty && driversOnRoute[0] != email) {
        takenRoutes.add(routes[index]);
      }
    }
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
      keepDriverOnShift();
    });
  }
}