import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/StudentsApp/Utilities/PushNotification.dart';
import './appbar_widget.dart';
import './profile_widget.dart';

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  String username = "", email = "";
  List<String> subs = [];

  late final PushNotification pushNotification;

  @override
  void initState(){
    pushNotification = PushNotification();
    pushNotification.initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    email = context.watch<UserData>().email;
    username =  context.watch<UserData>().username;
    subs =  context.watch<Subscriptions>().subs;

    return Scaffold(
      appBar: BuildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ElevatedButton(onPressed:() async{
            print("notfy1");
            pushNotification.scheduleNotification(id: 0, title: "Dining Services", body: "Time to collect lunch", seconds: 5);
            print("notfy2");
          },
              child: Text("Not")),
          ProfileWidget(
            imagePath: 'https://images.unsplash.com/'
                'photo-1457449940276-e8deed18bfff?ixlib'
                '=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto'
                '=format&fit=crop&w=870&q=80',
            onClicked: () async {},
          ),
          //under profile widget, display the user name
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 50),
          const Center(
            child: Text(
              'Subscriptions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          showSubs(context)
        ],
      ),
    );
  }

  Widget buildName() => Column(children: [
        Text(username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const SizedBox(height: 4),
        Text(email, style: const TextStyle(color: Colors.grey))
      ]);

  Widget buildListView() {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: subs.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: Center(child: Text(subs[index])),
          );
        });
  }

  Widget subscriptionCard(BuildContext context, String subscription){
    String title = "";
    String img = "";

    switch(subscription){
      case "bus_service":
        title = "Bus Services";
        img = 'assets/hall.jpg';
        break;
      case "dining_service":
        title = "Dining Services";
        img = 'assets/food.jpg';
        break;
      case "campus_control":
        title = "Protection Services";
        img = 'assets/uni.jpeg';
        break;
      case "health":
        title = "Health Services";
        img = 'assets/health.jpg';
        break;
      default:
        title = "Services";
        img = 'assets/uni.jpeg';
        break;
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 5, 5),
      child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(55), // Image radius
                  child: Image.asset(img, fit: BoxFit.cover,),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.redAccent
                        ),
                        onPressed: (){
                          subDialog(context);
                        },
                        child: const Text("Unsubscribe", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget showSubs(BuildContext context){
    List<Widget> items = [];

    for(String name in subs){
      items.add(subscriptionCard(context, name));
    }

    return Column(children: items);
  }

  void subDialog(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context){
          return Center(
            child:  Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 3.4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: const Text("Action not available")
            ),
          );
        }
    );
  }

}
