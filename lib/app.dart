import 'package:flutter/material.dart';
import './SudentsApp/Home/Home.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
    );
  }
}
