import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// Uri to the API
String uri = "http://10.0.1.55:8000/";

class Buses extends StatefulWidget {
  bool sub;
  Buses({Key? key, required this.sub}) : super(key: key);

  @override
  State<Buses> createState() => _Buses();
}

class _Buses extends State<Buses> {
  UtilityWidget utilityWidget = UtilityWidget();

  //
  bool subscribed = false;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: subscribed ?  Column(
          children: [
            utilityWidget.AppBar("Bus Services"),
          ],
        ) :
          Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              _MustSub("Bus Services")
            ],
          ),
      );
  }

  Widget _MustSub(String title){

    return  Container(
      width: double.infinity,
      child: Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children:[
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Text("To access this service you must be subscribed"),
            loader ?
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
              child: const LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                colors: [Colors.blueGrey],
                strokeWidth: 2,
              ),
            )
            :
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: (){
                  setState(() {
                    loader = true;
                    Future<String> status = addSub("2381410@students.wits.ac.za", "Campus Control");
                    if(status == 'sent'){
                      subscribed = true;
                    }
                  });
                },
                child: const Text("Subscribe", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),))
          ]
      ),
    );
  }

  Future<String> addSub(String email, String service) async{
    var result =
        await http.post(Uri.parse("${uri}db/addSub/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "service": service
        }));
    var res = jsonDecode(result.body);

    return res['status'] as String;
  }
}
