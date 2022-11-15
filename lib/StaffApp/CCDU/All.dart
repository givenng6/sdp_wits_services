import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sdp_wits_services/main.dart';
import 'Booking.dart';
import 'ccduGlobals.dart' as localGlobals;

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);
  @override
  State<All> createState() => AllState();
}

class AllState extends State<All> {
  TextEditingController linkController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //Global key needed for the dialog and bottom sheet
  bool dialogLoading = false; //current state of the dialog, if true it shows the loading animation else the confirmation message.
  bool first = true;

  Future<void> acceptBooking(setState, Booking booking) async {
    await localGlobals.HandleBooking(booking);
    localGlobals.GetAllBookings();
    dialogLoading = false;
    first = false;
    setState(() {});
  }

  Future<void> confirmationDialog(Booking booking,BuildContext mainContext) async {
    showDialog(
      context: _scaffoldKey.currentContext == null?mainContext:_scaffoldKey.currentContext!,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (first) acceptBooking(setState, booking);
            return AlertDialog(
              content: SingleChildScrollView(
                child: Container(
                  child: dialogLoading
                      ? const LoadingIndicator(
                          indicatorType: Indicator.ballClipRotate)
                      : Column(
                          children: const [
                            Icon(
                              Icons.check_circle_outline,
                              size: 60,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Appointment confirmed")
                          ],
                        ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    dialogLoading = true;
                    first = true;
                    Navigator.pop(context);

                  },
                  child: const Text("Close"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> handleOnPressed(Booking booking,BuildContext context) async {
    //Handles the accept button for each card.
    //if the meeting location is online, show the link dialog else just send the booking to the db
    if (booking.location == "Online") {
      showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(15),
            height: 200,
            child: Column(
              children: [
                const Text("Link"),
                TextField(
                  key: const Key("linkTextField"),
                  controller: linkController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Link',
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      booking.setLink(linkController.text);
                      linkController.text = "";
                      dialogLoading = true;
                      Navigator.pop(context);
                      await confirmationDialog(booking,context);
                    },
                    child: const Text("Submit"))
              ],
            ),
          );
        }),
      );
    } else {
      dialogLoading = true;
      await confirmationDialog(booking,context);
    }
  }

  void init() async {
    await localGlobals.GetAllBookings();
    setState(() {});
  }

  @override
  void initState() {
    init();
    linkController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: RefreshIndicator(
            onRefresh: () async {
              await localGlobals.GetAllBookings();
              setState(() {});
            },
            child: Container(child: makeList())));
  }

  Widget dividerCard(String text) => Card(
      elevation: 7,
      color: Colors.grey,
      child: Container(
          padding: const EdgeInsets.all(5),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500),
          )));

  Widget makeList() {
    // the list of all the appointments.

    return ListView.builder(
        itemCount: localGlobals.AllBookings.length +
            localGlobals.MyBookings.length +
            1,
        itemBuilder: (context, index) {
          int myBookingsLen = localGlobals.MyBookings.length;
          int allBookingsLen = localGlobals.AllBookings.length;

          if (myBookingsLen > 0 && allBookingsLen == 0) {
            if (index == 0) {
              return dividerCard("My Bookings");
            } else {
              return _card(localGlobals.MyBookings[index - 1]);
            }
          } else if (myBookingsLen == 0 && allBookingsLen > 0) {
            if (index == 0) {
              return dividerCard("Other Bookings");
            } else {
              return _card(localGlobals.AllBookings[index - 1]);
            }
          } else {
            if (index == myBookingsLen) {
              return dividerCard("Other Bookings");
            } else {
              if (index < myBookingsLen) {
                return _card(localGlobals.MyBookings[index]);
              } else {
                return _card(
                    localGlobals.AllBookings[index - myBookingsLen - 1]);
              }
            }
          }
        });
  }

  Widget _card(Booking booking) {
    //Booking card
    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              booking.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            Text("Date: ${booking.date}"),
            Text("Time: ${booking.time}"),
            Text("Platform: ${booking.location}"),
            if (booking.description != "") const Text("Description"),
            if (booking.description != "") Text(booking.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    key: Key("${booking.id}btn"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF013152))),
                    onPressed: () async {
                      await handleOnPressed(booking,context);
                    },
                    child: const Text('ACCEPT')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
