import 'package:flutter/material.dart';
import '../AppBar.dart';

class Buses extends StatefulWidget{
  const Buses({Key? key}) : super(key: key);

  @override
  State<Buses> createState() => _Buses();
}

class _Buses extends State<Buses>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: const [
          MyAppBar()
        ],
      ),
    );
  }
}