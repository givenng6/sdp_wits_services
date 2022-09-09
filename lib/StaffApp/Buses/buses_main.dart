import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Routes.dart';

class BusesMain extends StatefulWidget {
  const BusesMain({Key? key}) : super(key: key);

  @override
  State<BusesMain> createState() => _BusesMainState();
}

class _BusesMainState extends State<BusesMain> {
  String? username;

  getSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username');
    debugPrint(username);
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  List<List<Routes>> routes = [
    [Routes(
        route: 'YVL > AMIC > NSW > REN > WJ > WEC > EOH > KNK > AMIC',
        time: '06:20 to 09:00 – every 10 minutes (Shuttle)'),
    Routes(
        route: 'AMIC > NSW > REN > WJ > WEC > EOH > KNK > YVL > AMIC',
        time: '06:40 to 09:00 – every 10 minutes'),
    Routes(
        route: 'AMIC > NSW > REN > WJ > WEC > EOH > KNK > YVL > AMIC',
        time: '09:15 to 12:15 – every 15 minutes'),
    Routes(
        route: 'AMIC > YVL > KNK > EOH > WEC > WJ > REN > NSW',
        time: '12:30 to 23:30 “reverse” circuit on the half hour'),
    Routes(
        route: 'AMIC > NSW > REN > WJ > WEC > EOH > KNK > YVL > AMIC',
        time: '18:00 – 00:00 – normal circuit on the hour'),],

    [Routes(
        route: '2B – AMIC > REN > WEC > REN > AMIC',
        time: '06:45 to 08:45 – every 30 minutes'
        '\n09:30 to 17:30 – hourly on the half hour'),],

    [Routes(
        route: '3A - WJ > AMIC > WJ',
        time: '07:00 to 09:00 – every 20 minutes (Shuttle)'
        '\n09:00 to 17:00 – hourly on the hour from WJ'
    '\n09:30 to 17:30 – hourly on the half hour from AMIC Deck'),
    Routes(
        route: '3B – WJ > WEC > WJ',
        time: '06:45 to 09:15 – every 15 minutes (Shuttle)'
        '\n09:30 to 15:00 – every 30 minutes (Departs WJ)'
      '\n15:20 to 18:00 – every 20 minutes (Departs WEC)'),
    Routes(
        route: '3C – WJ > WEC > WJ > AMIC',
        time: '18:30; 19:30; 20:30; 21:30; 22:30; 23:30 (Departs WJ)'
        '\n18:00; 19:00; 20:00; 21:00; 22:00; 23:00; 00:00 (Departs Amic)'),],

    [Routes(
        route: '4A – WEC > AMIC > WEC',
        time: '06:50 to 09:00 – every 30 minutes(Shuttle)'
        '\n09:30 to 17:30 – hourly on the half hour'),
    Routes(
        route: '4B – YVL > AMIC > WEC > YVL',
        time: '07:00 to 09:00 – hourly on the hour'),
    Routes(
        route: 'AMIC > YVL > AMIC > WEC > AMIC',
        time: '09:50 to 16:50 – hourly on the hour'),],

    [Routes(
        route: 'KNK > EOH > AMIC',
        time: '07:00 to 09:00 – every 20 minutes (Shuttle – from Rock Ridge Road)'
        '\n10:00; 11:00; 12:00; 13:00; 14:00 15:00 16:00; 17:00 (from St David’s Place)'),
    Routes(
        route: 'EOH > KNK (St David’s Place) > AMIC',
        time: '07:00 to 08:00 – every 20 minutes'),
    Routes(
        route: 'AMIC > EOH > KNK (St David’s Place) > AMIC',
        time: '08:30 to 17:30 – every 30 minutes'),],

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            collapsedHeight: 60,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: const [
                  Icon(Icons.bus_alert, color: Colors.black,),
                  SizedBox(width: 10.0,),
                  Text('Buses', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ],
              ),
              // title: Text('Buses', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              // background: Icon(Icons.bus_alert, size: 60.0,),
              // centerTitle: true,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: [
              (username != null)
                  ? InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff003b5c),
                          radius: 22.0,
                          child: Text(username![0]),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()));
                      },
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: const CircleAvatar(
                        backgroundColor: Color(0xff003b5c),
                        radius: 22.0,
                        child: Text('W'),
                      ),
                    ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  color: Colors.white,
                  child: Card(
                    color: const Color(0xFF003b5c),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Route ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: routes[index].length,
                              itemBuilder: (context, i) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(routes[index][i].route),
                                      Text(routes[index][i].time),

                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: routes.length,
            ),
          ),
        ],
      ),
    );
  }
}
