import 'package:flutter/material.dart';
import './MenuAppBar.dart';
import './MenuItems.dart';

class Menu extends StatefulWidget{
  final Function(int index) onNavigate;
  const Menu({super.key, required this.onNavigate});
  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           MenuAppBar(),
           MenuItems(onNavigate: widget.onNavigate)
        ],
      ),
    );
  }
}