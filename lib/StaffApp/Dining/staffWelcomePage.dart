import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import './mealSelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class staffWelcomePage extends StatefulWidget {
  const staffWelcomePage({Key? key}) : super(key: key);

  @override
  State<staffWelcomePage> createState() => _staffWelcomePageState();
}

class _staffWelcomePageState extends State<staffWelcomePage> {
  //datetime variable
  DateTime dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        dateTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //add an appbar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Flutter Tutorial',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Text(
              'Let students know whats on the menu for the date',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Column(
              children: [
                //display chosen date
                Text(
                  DateFormat.yMMMEd().format(dateTime).toString(),
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                Container(height: 40),
                //button
                MaterialButton(
                  onPressed: _showDatePicker,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Choose date',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  color: Color.fromARGB(255, 0, 30, 129),
                ),
                Container(height: 30),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              mealSelecionPage(dateTime: dateTime)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Proceeed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  color: Color.fromARGB(255, 0, 30, 129),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
