import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Utilities/AddSub.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCDU extends StatefulWidget{

  @override
  State<CCDU> createState() => _CCDU();
}

class _CCDU extends State<CCDU>{
  String email = "";

  String meetingLocation = 'Online';
  String theCounsellor = '';
  List<String> places = ['Online', 'In Person'];

  // list of counsellors name
  List<String> counsellors = [];
  List<String> counsellorsEmail = [];

  List<CCDUObject> sessions = [];
  String description = "";

  TimeOfDay time = TimeOfDay(hour: 09, minute: 00);
  DateTime date = DateTime(2022, 10, 14);

  // TODO get current date and the counsellors

  @override 
  Widget build(BuildContext context){
    counsellors =  context.watch<Subscriptions>().counsellorsName;
    counsellorsEmail = context.watch<Subscriptions>().counsellorsEmail;
    sessions = context.watch<Subscriptions>().ccduBookings;
    email = context.watch<UserData>().email;

    return Scaffold(

      appBar: AppBar(title: const Text('CCDU'), backgroundColor: Color(0xff003b5c),),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              //isScrollControlled: true,
              builder: (builder) {
                return StatefulBuilder(builder: (BuildContext context, StateSetter setState ){
                  return  Container(
                    //height: double.infinity,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('New Session', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                ElevatedButton(
                                  child: Text('Submit'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff003b5c)
                                  ),
                                  onPressed: () {
                                    int newHour = time.hour + 1;
                                    String timeFormat = time.hour.toString().padLeft(2, '0') + ":" + time.minute.toString().padLeft(2, '0') + "-" + newHour.toString().padLeft(2, '0') + ":" + time.minute.toString().padLeft(2, '0');
                                    String dateFormat = date.day.toString().padLeft(2, '0') + '/' + date.month.toString().padLeft(2, '0') + '/' + date.year.toString();
                                    verify(context, timeFormat, dateFormat, theCounsellor, description, meetingLocation);
                                  },
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.event, color: Colors.grey,),
                              Text("Date"),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(date.day.toString().padLeft(2, '0') + '/' + date.month.toString().padLeft(2, '0') + '/' + date.year.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w600)),
                              TextButton(onPressed: () async {
                                DateTime? setDate = await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(2100)
                                );

                                if (setDate != null) {
                                  // update the date
                                  setState(() {
                                    date = setDate;
                                  });
                                }
                              },
                                  child: Text('Change Date')
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.watch_later_outlined, color: Colors.grey),
                              Text("Time"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(time.hour.toString().padLeft(2, '0') + ":" + time.minute.toString().padLeft(2, '0'), style: TextStyle(fontWeight: FontWeight
                                  .w600)),
                              TextButton(onPressed: () async {
                                TimeOfDay? setTime = await showTimePicker(
                                    context: context, initialTime: time
                                );

                                if (setTime != null) {
                                  // update time
                                  setState(() {
                                    time = setTime;
                                  });
                                }
                              },
                                  child: Text('Change Time')
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_pin, color: Colors.grey),
                              Text("Meeting Location"),
                            ],
                          ),
                          DropdownButton(
                              isExpanded: true,
                              value: meetingLocation,
                              items: places.map((String places) {
                                return DropdownMenuItem(
                                  value: places,
                                  child: Text(places),
                                );
                              }).toList(),
                              onChanged: (String? place) {
                                // must update value
                                setState(() {
                                  meetingLocation = place!;
                                });
                              }),
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.grey),
                              Text('Choose Counsellor (optional)'),
                            ],
                          ),
                          DropdownButton(
                              isExpanded: true,
                              value: theCounsellor,
                              items: counsellors.map((String counsellors) {
                                return DropdownMenuItem(
                                  value: counsellors,
                                  child: Text(counsellors),
                                );
                              }).toList(),
                              onChanged: (String? counsellor) {
                                // must update value
                                setState(() {
                                  theCounsellor = counsellor!;
                                });
                              }),
                          Row(
                            children: [
                              Icon(Icons.add, color: Colors.grey),
                              Text('Add Description'),
                            ],
                          ),
                           TextField(
                              onChanged: (text){
                                description = text;
                              }
                            ),
                        ],)
                  );
                });

              }
          );
        },
        backgroundColor: Color(0xff003b5c),
        icon: Icon(Icons.add),
        label: Text('New Session'),
      ),
      body: sessions.isNotEmpty
          ? SingleChildScrollView(
        child: listAppointments(),
      )
          : Center(
          child: Text('No Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey)),
      ),
    );
  }

  Widget listAppointments(){
    List<Widget> items = [];

    int index = 1;
    for(CCDUObject booking in sessions){
      items.add(appointment(index, booking.date, booking.time, booking.counsellorName, booking.status));
      index++;
    }

    return Column(children: items);
  }

  void verify(BuildContext context, String time, String date, String counsellor, String description, String location){
    // validate date...
    addBooking(context, time, date);
    showDialog(context: context,
        builder: (BuildContext context){
          return Center(
            child:  Container(
              padding: EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 3.4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    CircularProgressIndicator(),
                  ]
              )
            ),
          );
        }
    );
  }

  void onError(BuildContext context, String time){
    showDialog(context: context,
        builder: (BuildContext context){
          return Center(
            child:  Container(
                padding: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 3.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Column(
                          children: [
                            Text('Data Validation Failed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text(""),
                            Text("The slot $time is not available", style: TextStyle(color: Colors.redAccent),)
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("OK"))
                        ],)
                    ],
                )
            ),
          );
        }
    );
  }



  Widget appointment(int index, String date, String time, String counsellor, String status){
    return Card(
      elevation: 3,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Appointment $index", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
          Text(""),
          Text("Date: $date", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
          Text("Time: $time", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
          Text("Counsellor: $counsellor", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
          status == 'Confirmed'? Text(status, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))
          : Text(status, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
        ],
      ),
    ));
  }

  Future<void> addBooking(BuildContext context, String time, String date) async {
    String id = "";
    for(int i = 0; i < counsellors.length; i++){
      if(counsellors[i] == theCounsellor){
        id = counsellorsEmail[i];
      }
    }
    await http.post(Uri.parse("${uri}db/bookingCCDU/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "time": time,
          "date": date,
          "description": description,
          "counsellor": id,
          "counsellorName": theCounsellor,
          "location": meetingLocation,

        })).then((value) {
          // TODO check the returned data if is valid
          bool isAvailable = jsonDecode(value.body)[0];
          print(isAvailable);
          if(isAvailable){
            setState(() {
              // add the session to the list...
              CCDUObject session = new CCDUObject();
              session.setAppointment('Pending', time, date, description, id, theCounsellor, meetingLocation);
              context.read<Subscriptions>().addCCDUBooking(session);

              // clear all fields..
              theCounsellor = "";
              description = "";

              // remove the dialog
              Navigator.pop(context);
            });
          }else{
            setState(() {
              // remove the dialog
              Navigator.pop(context);

              onError(context, time);
            });
          }
    });
  }


}