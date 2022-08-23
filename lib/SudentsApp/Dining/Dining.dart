import 'package:flutter/material.dart';

class Dining extends StatefulWidget{
  const Dining({Key? key}) : super(key: key);

  @override
  State<Dining> createState() => _Dining();
}

class _Dining extends State<Dining>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text('Dining'),
    );
  }
}