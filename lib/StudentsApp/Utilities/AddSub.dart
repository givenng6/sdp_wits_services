import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Uri to the API
String uri = "https://web-production-a9a8.up.railway.app/";

class AddSub extends StatefulWidget{
  String service, title;
  bool isSubscribed;
  final Function() setSubscribed;
  AddSub({required this.service, required this.title, required this.isSubscribed, required this.setSubscribed});
  @override
  State<AddSub> createState() => _AddSub();
}

class _AddSub extends State<AddSub>{
  bool isLoading = false;
  List<String> subs = [];
  String email = "";

  @override
  Widget build(BuildContext context){
    subs = context.watch<Subscriptions>().subs;
    email = context.watch<UserData>().email;

    return  Container(
      width: double.infinity,
      child: Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children:[
            Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Text("To access this service you must be subscribed"),
            isLoading?
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
                    setState(() {
                      isLoading = true;
                    });
                    _addSub(email, widget.service, context);
                },
                child: const Text("Subscribe", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),))
          ]
      ),
    );
  }

  Future<void> _addSub(String email, String service, BuildContext context) async{
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
        context.read<Subscriptions>().addSub(service);
        widget.setSubscribed();
    });
  }

}