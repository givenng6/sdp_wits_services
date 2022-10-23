import 'package:flutter/material.dart';
import 'Booking.dart';
import 'ccduGlobals.dart' as localGlobals;

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  State<All> createState() => AllState();
}

class AllState extends State<All> {
  TextEditingController linkController = TextEditingController();

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
    return Scaffold(body: Container(child:makeList()));
  }

  String bottomSheetLoading = "initial";

  submit(Booking booking) async {
    booking.setLink(linkController.text);

    await localGlobals.HandleBooking(booking);
  }

  void handleOnPressed(Booking booking) async {
    if (booking.location == "Online") {
      showModalBottomSheet(
          context: context,
          builder: (builder) => Container(
                padding: const EdgeInsets.all(15),
                height: 200,
                child: Column(
                  children: [
                    const Text("Link"),
                    TextField(
                      controller: linkController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Link',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          submit(booking);
                        },
                        child: Text("Submit"))
                  ],
                ),
              ));
    } else {
      localGlobals.HandleBooking(booking);
    }

  }

  Widget makeMyList(){
    return ListView.builder(
        itemCount: localGlobals.MyBookings.length,
        itemBuilder: (context, index) =>
            _card(localGlobals.MyBookings[index]));
  }

  Widget makeList() {
    return ListView.builder(
        itemCount: localGlobals.AllBookings.length + localGlobals.MyBookings.length+1,
        itemBuilder: (context, index) {
          int myBookingsLen = localGlobals.MyBookings.length;
          int allBookingsLen = localGlobals.AllBookings.length;

          if(myBookingsLen>0 && allBookingsLen==0){
            return  _card(localGlobals.MyBookings[index]);
          }else if (myBookingsLen==0 && allBookingsLen>0){
            if(index==0){
              return const Text("Other Bookings");
            }else{
              return  _card(localGlobals.AllBookings[index-1]);
            }
          }else{
            if(index==myBookingsLen){
              return const Text("Other Bookings");
            }else{
              if(index<myBookingsLen){
                return  _card(localGlobals.MyBookings[index]);
              }else{
                return  _card(localGlobals.AllBookings[index-myBookingsLen-1]);
              }
            }

          }


        });
  }

  Widget _card(Booking booking) {
    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(booking.name,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
            Text("Date: ${booking.date}"),
            Text("Time: ${booking.time}"),
            Text("Platform: ${booking.location}"),
            if(booking.description!="")Text("Description"),
            if(booking.description!="")Text(booking.description),
            if (booking.type == "all")
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF013152))
                    ),
                      onPressed: () {
                        handleOnPressed(booking);
                      },
                      child: Text('ACCEPT')),
                ],
              )
          ],
        ),
      ),
    );
  }
}
