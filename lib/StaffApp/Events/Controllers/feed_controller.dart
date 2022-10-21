import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EventsController extends GetxController{
  var events = [].obs;

  getEvents()async{
    String uri = 'https://sdpwitsservices-production.up.railway.app/';
    // String uri = 'http://192.168.20.17:5000/';
    await http.get(Uri.parse('${uri}getEvents'),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
    ).then((value){
      events(jsonDecode(value.body).toList());
      debugPrint(events.toString());
    });
  }
}