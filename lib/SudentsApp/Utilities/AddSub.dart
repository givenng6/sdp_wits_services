import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Uri to the API
String uri = "http://10.203.238.89:8000/";

class AddSub extends HookWidget{

  var isSubscribed = useState(false);
  var isLoading = useState(false);
  var subs = useState([]);
  List<String> data;

  AddSub(this.isSubscribed, this.data, this.subs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  Container(
      width: double.infinity,
      child: Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children:[
            Text(data[1], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Text("To access this service you must be subscribed"),
            isLoading.value ?
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
                    primary: Colors.red                ),
                onPressed: (){
                      isLoading.value = true;
                    _addSub(data[0], data[2]);
                },
                child: const Text("Subscribe", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),))
          ]
      ),
    );
  }

  Future<void> _addSub(String email, String service) async{
    await http.post(Uri.parse("${uri}db/addSub/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "service": service
        }));

    await Future.delayed(const Duration(seconds: 2), (){
        subs.value.add(service);
        isLoading.value = false;
        isSubscribed.value = true;
    });
  }

}