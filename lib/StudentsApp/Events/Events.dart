import 'package:flutter/material.dart';

class Events extends StatefulWidget{
  @override
  State<Events> createState() => _Events();
}

class _Events extends State<Events>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Events'), backgroundColor: Color(0xff003b5c),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            eventCard("Joyers Celebration", "12/11/2022", "13:00")
          ],
        ),
      )
    );
  }

  Widget eventCard(String eventTitle, String date, String time){
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Text(date),
              Text(time)
            ],
          ),
          Text(eventTitle),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
                backgroundColor: const Color(0xff86B049),
                  shape: const StadiumBorder()
              ),
              onPressed: (){},
              child: const Text('Interested on the event', style: TextStyle(color: Colors.black),)
          )
        ],
      ),
    );
  }
}