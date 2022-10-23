import 'dart:ui';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_wits_services/StaffApp/Buses/Controller/buses_controller.dart';
import 'package:sdp_wits_services/StaffApp/Events/Controllers/events_controller.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/protection.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'globals.dart' as globals;
import './StudentsApp/Providers/Subscriptions.dart';
import './StudentsApp/Providers/UserData.dart';
import 'package:provider/provider.dart';

Widget? nextScreen;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final eventsController = Get.put(EventsController());
  eventsController.getEvents();

  final busesController = Get.put(BusesController());
  busesController.getSharedPreferences();
  busesController.getRoutes();

  Get.put(Booked());
  await globals.getSharedPreferences();
  nextScreen = await globals.getData();
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => Subscriptions()),
        ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: const Main(),
      ),
  );
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  get getTo{
    globals.getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    // globals.getSharedPreferences();
    return GetMaterialApp(
      title: 'Wits Services',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        duration: 1000,
        splashIconSize: window.physicalSize.width-100,
        animationDuration: const Duration(milliseconds: 1000),
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: const Color(0xff003b5c),
        function: getTo,
        splash: Image.asset("assets/white_logo_nb.png"),
        nextScreen: nextScreen!,
      ),
    );
  }
}