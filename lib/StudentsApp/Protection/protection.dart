import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/book_ride.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/ride_object.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';
import 'package:sdp_wits_services/globals.dart' as globals;
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';

class Protection extends StatefulWidget {
  const Protection({super.key});

  @override
  State<Protection> createState() => _Protection();
}

class _Protection extends State<Protection> {
  UtilityWidget utilityWidget = UtilityWidget();

  String title = "Campus Control";
  String email = "";
  String service = "campus_control";
  List<String> data = [];

  List<String> subs = [];
  bool isSubscribed = false;
  RideObject ride = RideObject();

  final bookedController = Get.find<Booked>();

  Widget fabChild = Row(
    children: const <Widget>[
      Spacer(),
      Icon(Icons.book),
      Spacer(),
      Text('Book Ride'),
      Spacer()
    ],
  );

  bool isCancelingRide = false;

  @override
  Widget build(BuildContext context) {
    getResidences(context);
    getCampuses(context);
    bookedController.booked(context.watch<Subscriptions>().booked);
    subs = context.watch<Subscriptions>().subs;
    ride = context.watch<Subscriptions>().rideDetails;

    if(bookedController.booked.isTrue){
      setState(()=>fabChild = Row(
        children: const <Widget>[
          Spacer(),
          Icon(Icons.clear),
          Spacer(),
          Text('Cancel Ride'),
          Spacer()
        ],
      ));
    }

    if (subs.contains(service)) {
      setState(() {
        isSubscribed = true;
      });
    }

    return Scaffold(
      body: isSubscribed
          ? Column(
        children: [
          utilityWidget.AppBar(title),
          // const Spacer(),
          TextButton(
              onPressed: () async {
                final Uri url = Uri.parse(
                    'https://www.wits.ac.za/campus-life/safety-on-campus/');
                if (!await launchUrl(url)) {
                  throw 'Could not launch $url';
                }
              },
              child: const Text('About Protection Services')),
          if(context.watch<Subscriptions>().booked)
            Card(
              elevation: 2,
              child: Container(
                width: double.infinity,
                height: 180.0,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: AssetImage('assets/white.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0,),
                    Text('Driver: ${ride.driver}', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                    const SizedBox(height: 10.0,),
                    Text('From: ${ride.from}', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                    const SizedBox(height: 10.0,),
                    Text('To: ${ride.to}', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                    const SizedBox(height: 10.0,),
                    const Text('ETA: 7 mins', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                    const SizedBox(height: 10.0,),
                    const Spacer(),
                    Row(
                      children:  <Widget>[
                        Text('Car Name: ${ride.carName}', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                        Spacer(),
                        Text('Car Reg: ${ride.reg}', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                        Spacer()
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                  ],
                ),
              ),
            ),
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AddSub(
              title: title,
              service: service,
              isSubscribed: isSubscribed,
              setSubscribed: setSubscribed),
        ],
      ),
      floatingActionButton: isSubscribed? SizedBox(
        height: 40.0,
        width: 130.0,
        child: FloatingActionButton(
          backgroundColor: const Color(0xff003b5c),
          onPressed: (!context.watch<Subscriptions>().booked)
              ? () async {
            await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) => const BookRide());
            if (bookedController.booked.isTrue) {
              setState(()=>fabChild = Row(
                children: const <Widget>[
                  Spacer(),
                  Icon(Icons.clear),
                  Spacer(),
                  Text('Cancel Ride'),
                  Spacer()
                ],
              ));
            }
          }
              : () => showModalBottomSheet(context: context,
              backgroundColor: Colors.transparent,
              builder: (builder) =>
                  StatefulBuilder(builder: (_, StateSetter setState)=>
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0)
                          )
                        ),
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.height/4,
                    child: Column(
                      children: [
                        const Text("Are you sure you want to cancel your ride?",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                        ),
                        (isCancelingRide)?
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: JumpingText('Cancelling...',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18.0
                            ),
                          ),
                        ):
                        TextButton(onPressed: () async{
                          setState(() => isCancelingRide = true);
                          await cancelRide();
                          Get.back();
                          setState(() => isCancelingRide = false);
                        },
                            child: const Text("Cancel Ride",
                                key: Key('Cancel Ride'),
                                style: TextStyle(color: Colors.red))
                        ),
                        TextButton(onPressed: (){
                          Get.back();
                        },
                            child: const Text("Go Back")
                        ),
                      ],
                    ),)

              ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          child: fabChild,
        ),
      ):null,
    );
  }

  void setSubscribed() {
    setState(() {
      isSubscribed = true;
    });
  }

  String uri = "https://web-production-a9a8.up.railway.app/";
  Future<void> getResidences(BuildContext context) async{
    // residences = context.watch<Subscriptions>().residences;
    if(context.watch<Subscriptions>().residences.isEmpty){
      // print(context.watch<Subscriptions>().residences);
      await http.get(Uri.parse("${uri}db/getAllResidences"),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          }
      ).then((value){
        List residences = jsonDecode(value.body).toList();
        context.read<Subscriptions>().setResidences(residences);
      });
    }

  }

  Future<void> getCampuses(BuildContext context) async{
    if(context.watch<Subscriptions>().campuses.isEmpty){
      await http.get(Uri.parse("${uri}db/getAllCampuses"),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          }
      ).then((value){
        List campuses = jsonDecode(value.body).toList();
        context.read<Subscriptions>().setCampuses(campuses);
      });
    }
  }

  Future<void> cancelRide() async{
    await http.post(Uri.parse("${uri}db/cancelRide/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String?>{
          "email": globals.email,
          'from': ride.from
        })
    ).then((value){
      setState(() {
        fabChild = Row(
          children: const <Widget>[
            Spacer(),
            Icon(Icons.book),
            Spacer(),
            Text('Book Ride'),
            Spacer()
          ],
        );
        bookedController.booked(false);
        context.read<Subscriptions>().setBooked(false);
      });
    });
  }
}

class Booked extends GetxController{
  var booked = false.obs;
}