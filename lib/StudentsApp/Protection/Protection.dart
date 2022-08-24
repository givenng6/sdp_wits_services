import 'package:flutter/material.dart';
import '../AppBar.dart';

class Protection extends StatefulWidget{
  const Protection({Key? key}) : super(key: key);

  @override
  State<Protection> createState() => _Protection();
}

class _Protection extends State<Protection>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  Column(
        children: const [
          MyAppBar()
        ],
      ),
    );
  }
}