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

    return Scaffold(

      
      appBar: AppBar(title: const Text('CCDU'), backgroundColor: Color(0xff003b5c),),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (builder) => Container(
                //height: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('New Session', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text("Date"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("12/12/2010"),
                        TextButton(onPressed: (){},
                            child: Text('Change Date')
                        ),
                      ],
                    ),
                  Text("Time"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("12:00"),
                      TextButton(onPressed: (){},
                          child: Text('Change Time')
                      ),
                    ],
                  ),
                  Text('Meeting Location'),
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
                  Text('Choose Counsellor (optional)'),
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
                Text('Add Description'),
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