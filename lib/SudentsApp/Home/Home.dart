import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Text("Home"),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            label: 'Dashboard', icon: Icon(Icons.dashboard)),
        BottomNavigationBarItem(label: 'Buses', icon: Icon(Icons.bus_alert))
      ]),
    );
  }
}
