// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';

class ccdu extends StatefulWidget {
  const ccdu({Key? key}) : super(key: key);

  @override
  State<ccdu> createState() => ccduState();
}


class ccduState extends State<ccdu>{

  // TODO fil the bookings array with data from the database
  List<dynamic> bookings = [{'name': 'Khotsos', 'email': 'example@email.com', 'date': '12/12/2020', 'time': '10:30', 'description': 'CCDU staff app'}];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('CCDU', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xff003b5c),),
        body: bookings.isNotEmpty?
        SingleChildScrollView(
          child: Column(
          children:[

            makeList()
          ],
        )
        )
            : Center(
          child: Text("Requests empty", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),),
        )
      ),
    );
  }

  Widget makeList(){
    List<Widget> listCards = [];

    for(var booking in bookings){
      listCards.add(_card(booking['name'], booking['email'], booking['date'], booking['time'], booking['description']));
    }

    return Column(children: listCards);
  }

  Widget _card(String name, String email, String date, String time, String description){
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Name: $name"),
            Text("Email: $email"),
            Text("Date: $date"),
            Text("Time: $time"),
            Text("Description"),
            Text(description),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child:  ElevatedButton(onPressed: (){

                    // TODO Bonga to implement logic

                  }, child: Text('DECLINE')),
                ),

                ElevatedButton(onPressed: (){

                  // TODO Bonga to implement logic
                }, child: Text('ACCEPT')),

              ],
            )
          ],
        ),
        // style: TextStyle(fontSize: 16),),
      ),

    );
  }
}





