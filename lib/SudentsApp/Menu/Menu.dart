import 'package:flutter/material.dart';

class Menu extends StatefulWidget{
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text('Menu'),
    );
  }
}