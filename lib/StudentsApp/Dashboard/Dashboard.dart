import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_indicator/loading_indicator.dart';
import './DashAppBar.dart';
import './Widgets/BusWidget.dart';
import './Widgets/DiningWidget.dart';
import './Widgets/ProtectionWidget.dart';
import './Widgets/EventsWidget.dart';
import './Widgets/HealthWidget.dart';


class Dashboard extends HookWidget{

  // list of dashboard widgets to show to user...
  List<Widget> _cards = [];

  var isFetching = useState(true);
  var subs = useState([]);
  var busSchedule = useState([]);
  var busFollowing = useState([]);
  var diningHalls = useState([]);
  var dhFollowing = useState("");
  var mealTime = useState("");
  Dashboard(this.isFetching, this.subs, this.busSchedule, this.busFollowing, this.diningHalls, this.dhFollowing, this.mealTime, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    for(String service in subs.value){
      switch (service){
        case 'bus_service':
          _cards.add(BusWidget(busSchedule, busFollowing));
          break;
        case 'dining_service':
          _cards.add(DiningWidget(diningHalls, dhFollowing, mealTime));
          break;
        case 'campus_control':
          _cards.add(ProtectionWidget());
          break;
        case 'events':
          _cards.add(EventsWidget());
          break;
        case 'health':
          _cards.add(HealthWidget());
          break;
      }
    }
    return Scaffold(
      body: Column(
        children: [
          const DashAppBar(),
          DashHeader(),
          Expanded(
              child: isFetching.value ?
              const LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Colors.blueGrey],
                strokeWidth: 2,
              )
              :
              ListView.builder(
                itemCount: _cards.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return _cards[index];
                }),)
        ],
      ),
    );
  }

  Widget DashHeader(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Suggestions:"),
          //Text("My Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SuggestedItem("Campus Health"),
              SuggestedItem("Events"),
              SuggestedItem("CCDU")
            ],
          )
        ],
      ),
    );
  }

  Widget SuggestedItem(String title){
    return Container(
      padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xff003b5c),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          _getIcon(title),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white))
        ],
      ),
    );
  }

  // return icon base on title...
  Widget _getIcon(String title){
    switch (title){
      case 'Campus Health':
        return Icon(Icons.health_and_safety, color: Colors.red, size: 19,);
        break;
      case 'Events':
        return Icon(Icons.event, color: Colors.white, size: 19,);
        break;
      case 'CCDU':
        return Icon(Icons.health_and_safety_outlined, color: Colors.green, size: 19,);
        break;
      default:
        return Icon(Icons.home, color: Colors.white, size: 19,);
        break;
    }
  }
}