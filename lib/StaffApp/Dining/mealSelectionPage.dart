import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'selectBeakfastPage.dart';
import 'selectLunchPage.dart';
import 'selectDinnerPage.dart';

class mealSelecionPage extends StatefulWidget {
  final DateTime dateTime;
  mealSelecionPage({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  @override
  State<mealSelecionPage> createState() => _mealSelecionPageState();
}

class _mealSelecionPageState extends State<mealSelecionPage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title:
                  Text(DateFormat.yMMMEd().format(widget.dateTime).toString()),
              centerTitle: true,
              bottom: const TabBar(
                tabs: [
                  Tab(
                      text: 'Breakfast',
                      icon: Icon(Icons.breakfast_dining_rounded)),
                  Tab(text: 'Lunch', icon: Icon(Icons.lunch_dining_rounded)),
                  Tab(text: 'Dinner', icon: Icon(Icons.dinner_dining_rounded)),
                ],
              ),
            ),
            body: TabBarView(children: [
              selectBrakefastPage(dateTime: widget.dateTime),
              selectLunchPage(dateTime: widget.dateTime),
              selectDinnerPage(dateTime: widget.dateTime),
            ])),
      );
}
