import 'package:flutter/material.dart';
import './DashAppBar.dart';
import './Widgets/BusWidget.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          DashAppBar(),
          BusWidget()
        ],
      ),
    );
  }
}