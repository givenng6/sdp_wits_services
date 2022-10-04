import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Utilities/AddSub.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';

class CCDU extends StatefulWidget{

  @override
  State<CCDU> createState() => _CCDU();
}

class _CCDU extends State<CCDU>{
  String email = "";

  String meetingLocation = 'Online';
  String theCounsellor = '';
  List<String> places = ['Online', 'OnSite'];
  List<String> counsellors = ['', 'Given', 'Mathebula'];
  List<CCDUObject> sessions = [];
  String description = "";

  TimeOfDay time = TimeOfDay(hour: 09, minute: 00);
  DateTime date = DateTime(2022, 10, 14);

  @override 
  Widget build(BuildContext context){
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
                                    print(date);
                                    print(time);
                                    print(meetingLocation);
                                    print(theCounsellor);
                                    print(description);
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
}