import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningCard.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';

class Dining extends StatefulWidget{
  final List<DiningObject>? diningHalls;
  final String? email;
  final bool? isTesting;
  const Dining({super.key, this.diningHalls, this.email, this.isTesting,});

  @override
  State<Dining> createState() => _Dining();
}

class _Dining extends State<Dining> {
  // shared class with common utilities...
  UtilityWidget utilityWidget = UtilityWidget();

  String title = "Dining Services";
  String email = "";
  String service = "dining_service";
  List<String> data = [];

  // data variables for the widget...
  List<String> subs = [];

  // variable that checks if the user is subscribed for the service..
  bool isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    set(){
      context.read<UserData>().setEmail(widget.email!);
      context.read<Subscriptions>().addSub(service);
      context.read<Subscriptions>().setDiningHalls(widget.diningHalls!);
      context.read<Subscriptions>().updateDHFollowing('DH4');
    }
    setForTesting() async{
      if(widget.isTesting!=null){
        await Future.delayed(const Duration(seconds: 1));
        set();
      }
    }
    setForTesting();

    email = context.watch<UserData>().email;
    subs = context.watch<Subscriptions>().subs;

    // change is sub to true if the user is sub to dining services...
    if (subs.contains(service)) {
      setState(() {
        isSubscribed = true;
      });
    }

    return Scaffold(
      // conditional rendering
      // if sub show the actual dining halls
      // else show the sub page
      body: isSubscribed
          ? SingleChildScrollView(
              child: Column(
                children: [
                  utilityWidget.AppBar(title),
                  DiningCard(),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AddSub(title: title, service: service, isSubscribed: isSubscribed, setSubscribed: setSubscribed,),
              ],
            ),
    );
  }

  void setSubscribed(){
    setState(() {
      isSubscribed = true;
    });
  }

}
