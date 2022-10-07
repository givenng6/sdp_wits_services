import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/book_ride.dart';
import 'package:url_launcher/url_launcher.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';
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

  @override
  Widget build(BuildContext context) {
    subs = context.watch<Subscriptions>().subs;

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
                            const Text('Driver: Jabu Maluleka', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                            const SizedBox(height: 10.0,),
                            const Text('From: Wits Main Campus', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                            const SizedBox(height: 10.0,),
                            const Text('To: Student Digz', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                            const SizedBox(height: 10.0,),
                            const Text('ETA: 7 mins', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                            const SizedBox(height: 10.0,),
                            const Spacer(),
                            Row(
                              children: const [
                                Text('Car Name: Honda', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                                Spacer(),
                                Text('Car Reg: RGB 716 GP', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
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
              children: [
                AddSub(
                    title: title,
                    service: service,
                    isSubscribed: isSubscribed,
                    setSubscribed: setSubscribed),
              ],
            ),
      floatingActionButton: SizedBox(
        height: 40.0,
        width: 130.0,
        child: FloatingActionButton(
          backgroundColor: const Color(0xff003b5c),
          onPressed: () => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => const BookRide()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          child: Row(
            children: [
              Spacer(),
              const Icon(Icons.book),
              Spacer(),
              const Text('Book Ride'),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

  void setSubscribed() {
    setState(() {
      isSubscribed = true;
    });
  }
}
