import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Utilities/AddSub.dart';

class CCDU extends HookWidget{
  // global variables to be used on the widgets...
  String title = "Counselling Careers Development Unit";
  String email = "";
  String service = "health";
  List<String> data = [];

  CCDU(this.email, {Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context){
    var subs = useState([]);
    var isSubscribed = useState(true);
    data = [email, title, service];

    String meetingLocation = 'Online';
    String theCounsellor = '';
    List<String> places = ['Online', 'OnSite'];
    List<String> counsellors = ['', 'Given', 'Mathebula'];

    TimeOfDay time = TimeOfDay(hour: 09, minute: 00);
    DateTime date = DateTime(2022, 10, 14);

    return Scaffold(

      
      appBar: AppBar(title: const Text('CCDU'), backgroundColor: Color(0xff003b5c),),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              //isScrollControlled: true,
              builder: (builder) => Container(
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
                        ElevatedButton(onPressed: (){},
                            child: Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff003b5c)
                            ),
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
                        Text(date.day.toString().padLeft(2, '0') + '/' + date.month.toString().padLeft(2, '0') + '/' + date.year.toString(), style: TextStyle(fontWeight: FontWeight.w600)),
                        TextButton(onPressed: ()async{
                          DateTime? setDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2100)
                          );

                          if(setDate != null){
                            // update the date
                            date = setDate;
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
                      Text(time.hour.toString().padLeft(2, '0') + ":" + time.minute.toString().padLeft(2, '0'), style: TextStyle(fontWeight: FontWeight.w600)),
                      TextButton(onPressed: ()async{
                        TimeOfDay? setTime = await showTimePicker(
                            context: context, initialTime: time
                        );

                        if(setTime != null){
                          // update time
                          time = setTime;
                          print(time);
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
                      items: places.map((String places){
                        return DropdownMenuItem(
                          value: places,
                          child: Text(places),
                        );
                      }).toList(),
                      onChanged: (String? place){
                        // must update value
                        meetingLocation = place!;
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
                      items: counsellors.map((String counsellors){
                        return DropdownMenuItem(
                          value: counsellors,
                          child: Text(counsellors),
                        );
                      }).toList(),
                      onChanged: (String? counsellor){
                        // must update value
                        theCounsellor = counsellor!;
                      }),
                Row(
                  children: [
                    Icon(Icons.add, color: Colors.grey),
                    Text('Add Description'),
                  ],
                ),
                TextField(

                  )
                ],)
              ),
          );
        },
        backgroundColor: Color(0xff003b5c),
        icon: Icon(Icons.add),
        label: Text('New Session'),
      ),
      body: isSubscribed.value
          ? SingleChildScrollView(
        child: Column(
          children: [
           Text('Sub'),
          ],
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AddSub(isSubscribed, data, subs),
        ],
      ),
    );
  }
}