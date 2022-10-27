import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StaffApp/Buses/Controller/buses_controller.dart';
import 'package:sdp_wits_services/StaffApp/Buses/View/buses_main.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/CampusControl.dart';
import 'package:sdp_wits_services/StaffApp/Dining/Package.dart';
import 'package:sdp_wits_services/StaffApp/Dining/SelectOptionItems.dart';
import 'package:sdp_wits_services/StaffApp/Dining/mealSelectionPage.dart';
import 'package:sdp_wits_services/StaffApp/Events/Controllers/events_controller.dart';
import 'package:sdp_wits_services/StaffApp/SelectDH.dart';
import 'package:sdp_wits_services/StaffApp/StaffPage.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusObject.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/Buses.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDU.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';
import 'package:sdp_wits_services/StudentsApp/Dashboard/Dashboard.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/Dining.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/ViewDH.dart';
import 'package:sdp_wits_services/StudentsApp/Events/events_object.dart';
import 'package:sdp_wits_services/StudentsApp/Home/Start.dart';
import 'package:sdp_wits_services/StudentsApp/Events/Events.dart' as studentsEvents;
import 'package:sdp_wits_services/StudentsApp/Protection/protection.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/main.dart' as app;
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart' as staff;
import 'package:sdp_wits_services/StudentsApp/Profile/Profile.dart' as students;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sdp_wits_services/globals.dart' as main_globals;
import 'package:sdp_wits_services/StaffApp/Campus Control/CampusControlGlobals.dart' as localGlobals;
import 'package:sdp_wits_services/StaffApp/DiningGlobals.dart' as globals;
import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // App Student
  group('1', () {
    testWidgets("login as student", _logInAsStudentTests);
  });
  group('1', () {
    testWidgets("signIn as student", _signInAsStudentTests);
  });
  group('1', () {
    testWidgets("_recover email student", _recoverStudentTests);
  });

  // App Staff
  group('1', () {
    testWidgets("login as staff", _logInAsStaffTests);
  });
  group('1', () {
    testWidgets("signIn as staff", _signInAsStaffTests);
  });
  group('1', () {
    testWidgets("_recover email staff", _recoverStaffTests);
  });

  // Buses
  group('1', () {
    testWidgets('unsubscribed student buses main', _unSubbedBusesTests);
  });
  group('1', () {
    testWidgets('subscribed student buses main', _subbedBusesTests);
  });
  group('1', () {
    testWidgets('staff buses main', _busesTests);
  });

  // Dashboard
  group('1', () {
    testWidgets("dashboard", _dashboardTests);
  });
  group('1', () {
    testWidgets("dining breakfast", _diningBreakfastTests);
  });
  group('1', () {
    testWidgets("dining lunch", _diningLunchTests);
  });

  // Dining
  group('1', () {
    testWidgets("Staff Dining", _staffDiningTests);
  });
  group('1', () {
    testWidgets("Student Dining", _studentDiningTests);
  });

  // Profile
  group('1', () {
    testWidgets("Students Profile", _studentsProfileTests);
  });
  group('1', () {
    testWidgets("Staff Profile", _staffProfileTests);
  });

  // Staff Dining
  group('1', () {
    testWidgets("selectWidget", _selectDHtest);
  });
  group('1', () {
    testWidgets("_selectItems", _selectItems);
  });

  // Students Dining
  group('1', () {
    testWidgets("Unsubscribed Students Dining", _unSubbedDiningTests);
  });
  group('1', () {
    testWidgets("Subscribed Students Dining", _subbedDiningTests);
  });
  group('1', () {
    testWidgets("Main Dining", _mainDiningTests);
  });

  // Stuff Campus Control
  group('1', () {
    testWidgets("Campus Control tests", _campusControlTest);
  });

  //
  group('1', () {
    testWidgets("SelectDepartment", _selectDepTest);
  });
  group('1', () {
    testWidgets("Check Buses", _checkBuses);
  });
  group('1', () {
    testWidgets("Check Campus Control", _checkCampusControl);
  });

  // Campus Control Students
  group('1', () {
    testWidgets("Unsubscribed Campus Control", _campusControlUnsubscribedTest);
  });
  group('1', () {
    testWidgets("Subscribed Campus Control", _campusControlSubscribedTest);
  });

  // CCDU Students
  group('1', () {

  });group('1', () {

  });group('1', () {

  });group('1', () {

  });

  group("end-to-end app test", () {

    testWidgets("Unsubscribed ccdu", _ccduUnsubscribedTest);
    testWidgets("Subscribed ccdu", _ccduSubscribedTest);
    testWidgets("StaffCCDU", _ccduStaffTests);

    // Start
    testWidgets("start", _start);

    // Events
    testWidgets("_eventsStudents", _eventsStudents);

  });
}

// App Student

Future<void> _logInAsStudentTests(WidgetTester tester)async{
  final continueAsStudentButton =
  find.byKey(const Key('Continue as Student'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.enterText(findNameTextField(), '2375736@students.wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('LOGIN'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _signInAsStudentTests(WidgetTester tester)async{
  final continueAsStudentButton =
  find.byKey(const Key('Continue as Student'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));

  await tester.tap(find.text('SIGNUP'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), '2375736@students.wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findConfirmPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findNthField(0), 'Nathi');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SUBMIT'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _recoverStudentTests(WidgetTester tester)async{
  final continueAsStudentButton =
  find.byKey(const Key('Continue as Student'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();

  await tester.enterText(findNameTextField(), '23123456@students.wits.ac.za');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Forgot Password?'), warnIfMissed: false);
  await tester.pumpAndSettle();


  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('RECOVER'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// App Staff

Future<void> _logInAsStaffTests(WidgetTester tester)async{
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStaff = find.text('Continue as Staff');

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();


  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), 'a2375736@wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('LOGIN'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _signInAsStaffTests(WidgetTester tester)async{
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStaff = find.text('Continue as Staff');

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), 'a2375736@wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findConfirmPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findNthField(0), 'Nathi');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SUBMIT'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _recoverStaffTests(WidgetTester tester)async{
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStaff = find.text('Continue as Staff');

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();

  await tester.enterText(findNameTextField(), 'a23123456@wits.ac.za');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Forgot Password?'), warnIfMissed: false);
  await tester.pumpAndSettle();


  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('RECOVER'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// Buses

String uri = "https://web-production-a9a8.up.railway.app/";

Future<void> _unSubbedBusesTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Subscriptions()),
    ChangeNotifierProvider(create: (_) => UserData()),
  ],
    child: const GetMaterialApp(home: Buses()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _subbedBusesTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';

  Widget widget = MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Subscriptions()),
    ChangeNotifierProvider(create: (_) => UserData()),
  ],
    builder: (context, _){
      set()async{
        await http.get(Uri.parse("${uri}db/getBusSchedule/"), headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        }).then((response) {
          debugPrint(response.body.toString());
          var toJSON = jsonDecode(response.body);
          List<BusObject> tempSchedule = [];
          for (var data in toJSON) {
            String pos = "";
            if (data['position'] != null) {
              pos = data['position'];
            }
            tempSchedule.add(BusObject(
                data['name'], data['id'], data['stops'], data['status'], pos));
          }
          context.read<Subscriptions>().addSub('bus_service');
          context.read<Subscriptions>().setBusSchedule(tempSchedule);
          context.read<UserData>().setEmail(email);
          context.read<UserData>().setUsername(username);
        });
        await http
            .post(Uri.parse("${uri}db/getBusFollowing/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": email,
            }))
            .then((value) {
          var busData = jsonDecode(value.body);
          List<String> busFollowing = [];
          for (String bus in busData) {
            busFollowing.add(bus);
          }
          context.read<Subscriptions>().updateBusFollowing(busFollowing);
        });
      }set();
      return const GetMaterialApp(home: Buses());
    },
  );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.pump(const Duration(seconds: 5));
}

Future<void> _busesTests(WidgetTester tester) async{
  const username = 'Nkosinathi Chuma';
  const email = 'a2375736@wits.ac.za';
  const onShift = false;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setBool('onShift', onShift);
  await tester.pump();

  Widget widget = GetMaterialApp(
    builder: (_,__){
      final busesController = Get.put(BusesController());
      busesController.getSharedPreferences();
      busesController.getRoutes();
      return const BusesMain();
    },
  );
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text("Route 1 - Full Circuit"), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text("Start Shift"), warnIfMissed: false);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text("End Shift"), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
}

// Dashboard

Future<void> _dashboardTests(WidgetTester tester) async {
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  List<DiningObject> diningHalls = [];
  var dhFollowing = 'DH4';

  await http
      .get(Uri.parse("${uri}db/getDiningHalls/"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  List<BusObject> busSchedule = [];
  List<String> busFollowing = [];

  await http
      .get(Uri.parse("${uri}db/getBusSchedule/"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  }).then((response) {
    var toJSON = jsonDecode(response.body);
    List<BusObject> tempSchedule = [];
    for (var data in toJSON) {
      String pos = "";
      if (data['position'] != null) {
        pos = data['position'];
      }
      tempSchedule.add(BusObject(
          data['name'], data['id'], data['stops'], data['status'], pos));
    }
    busSchedule = tempSchedule;
  });

  await http
      .post(Uri.parse("${uri}db/getBusFollowing/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "email": email,
      }))
      .then((value) {
    var busData = jsonDecode(value.body);
    busFollowing = List<String>.from(busData);
  });

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, _){
      set() async {
        await Future.delayed(const Duration(seconds: 1));
        context.read<Subscriptions>().addSub('bus_service');
        context.read<Subscriptions>().addSub('dining_service');
        context.read<Subscriptions>().addSub('campus_control');
        context.read<Subscriptions>().addSub('health');
        context.read<Subscriptions>().setBusSchedule(busSchedule);
        context.read<Subscriptions>().updateBusFollowing(busFollowing);
        context.read<Subscriptions>().updateDHFollowing(dhFollowing);
        context.read<Subscriptions>().setMealTime('Dinner');
        context.read<Subscriptions>().setDiningHalls(diningHalls);
      }set();
      Get.put(EventsController());
      return const GetMaterialApp(home: Dashboard(),);
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _diningBreakfastTests(WidgetTester tester) async {
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  List<DiningObject> diningHalls = [];
  var dhFollowing = 'DH4';

  await http
      .get(Uri.parse("${uri}db/getDiningHalls/"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, _){
      set() async {
        await Future.delayed(const Duration(seconds: 1));
        context.read<Subscriptions>().addSub('bus_service');
        context.read<Subscriptions>().addSub('dining_service');
        context.read<Subscriptions>().addSub('campus_control');
        context.read<Subscriptions>().addSub('health');
        context.read<Subscriptions>().setBusSchedule([]);
        context.read<Subscriptions>().updateBusFollowing([]);
        context.read<Subscriptions>().updateDHFollowing(dhFollowing);
        context.read<Subscriptions>().setMealTime('Breakfast');
        context.read<Subscriptions>().setDiningHalls(diningHalls);
      }set();
      Get.put(EventsController());
      return const GetMaterialApp(home: Dashboard(),);
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _diningLunchTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  List<DiningObject> diningHalls = [];
  var dhFollowing = 'DH4';

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, _){
      set()async{
        await Future.delayed(const Duration(seconds: 1));
        context.read<Subscriptions>().addSub('bus_service');
        context.read<Subscriptions>().addSub('dining_service');
        context.read<Subscriptions>().addSub('campus_control');
        context.read<Subscriptions>().addSub('health');
        context.read<Subscriptions>().setBusSchedule([]);
        context.read<Subscriptions>().updateBusFollowing([]);
        context.read<Subscriptions>().updateDHFollowing(dhFollowing);
        context.read<Subscriptions>().setMealTime("Lunch");
        context.read<Subscriptions>().setDiningHalls(diningHalls);
      }set();
      Get.put(EventsController());
      return const GetMaterialApp(home: Dashboard(),);
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// Dining

Future<void> _studentDiningTests(WidgetTester tester) async{
  const username = 'Lindokuhle Mabena';
  const email = 'a2355285@wits.ac.za';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  List<DiningObject> diningHalls = [];

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });
  await tester.pump();

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, _){
      set()async{
        await Future.delayed(const Duration(seconds: 1));
        context.read<UserData>().setEmail(email);
        context.read<Subscriptions>().addSub('dining_service');
        context.read<Subscriptions>().setDiningHalls(diningHalls);
        context.read<Subscriptions>().updateDHFollowing('DH4');
      }set();
      return const GetMaterialApp(home: Dining(),);
    },
  );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
}

Future<void> _staffDiningTests(WidgetTester tester) async{
  const username = 'Lindokuhle Mabena';
  const email = 'a2355285@wits.ac.za';
  const dhName = 'Ernest Openheimer';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('dhName', dhName);
  await tester.pump();

  Widget widget = const GetMaterialApp(
    home: mealSelecionPage(),
  );
  debugPrint('here');
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();

  final findLunchText = find.text('Lunch');
  final findDinnerText = find.text('Dinner');

  await tester.tap(findLunchText);
  await tester.pumpAndSettle();

  await tester.tap(findDinnerText);
  await tester.pumpAndSettle();

  await preferences.clear();
  await tester.pump(const Duration(seconds: 5));
}

// Profile

Future<void> _studentsProfileTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = 'a2375736@wits.ac.za';
  const subs = <String>['Dining Services', 'Bus Services', 'Campus Control'];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, _){
      set()async{
        await Future.delayed(const Duration(seconds: 1));
        context.read<UserData>().setEmail(email);
        context.read<UserData>().setUsername(username);
        for(String sub in subs){
          context.read<Subscriptions>().addSub(sub);
        }
      }set();

      return const GetMaterialApp(
          home: students.Profile());
    },
  );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('Logout')));
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));

  await tester.tap(find.text('Cancel'));
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));

  await tester.tap(find.byKey(const Key('lightDarkModeIcon Student')));
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('Logout')));
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));

  await tester.tap(find.text('Sign Out'));
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));

  await preferences.clear();
}

Future<void> _staffProfileTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = 'a2375736@wits.ac.za';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = GetMaterialApp(
    home: staff.Profile(email, username),
  );
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('Logout')));
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));

  await tester.tap(find.text('Cancel'));
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));

  await tester.tap(find.byKey(const Key('lightDarkModeIcon Staff')));
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('Logout')));
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));

  await tester.tap(find.text('Sign Out'));
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// Staff Dining

Future<void> _selectDHtest(WidgetTester tester)async{
  const username = 'Sabelo Mabena';
  const email = 'a2355285@wits.ac.za';

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('dhName', 'Convocation');
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  await tester.pumpWidget(HookBuilder(builder: (context) {

    return const GetMaterialApp(home: SelectDH());
  }));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _selectItems(WidgetTester tester) async {
  const username = 'Sabelo Mabena';
  const email = 'a2355285@wits.ac.za';

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('dhName', 'Convocation');
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Package package = Package(
      packageName: "Option A",
      items: [
        "Cheerios",
        "Corn Flakes",
        "Coco Pops",
        "Oats",
        "ProNutro",
        "All-Bran Flakes"
      ],
      id: "opA");

  await globals.getMenus();

  await tester.pumpWidget(GetMaterialApp(
    home: SelectOptionItems(
      package: package,
      type: "breakfast",
    ),
  ));

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// Students Dining

Future<void> _unSubbedDiningTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  var diningHalls = [];

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: const GetMaterialApp(
        home: Dining()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _subbedDiningTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  var diningHalls = <DiningObject>[];

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: GetMaterialApp(
        home: Dining(isTesting: true, email: email, diningHalls: diningHalls,)),
  );

  await tester.pumpWidget(widget);
  await tester.pump(const Duration(seconds: 3));

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

Future<void> _mainDiningTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  var diningHalls = [];

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return GetMaterialApp(home: ViewDH(diningHalls[0]));
  }));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

//Campus Control Staff

Future<void> _campusControlTest(WidgetTester tester) async {
  const username = 'Sabelo Mabena';
  const email = 'a2355285@wits.ac.za';

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('department', 'Campus Control');

  await main_globals.getSharedPreferences();
  String url = "https://sdpwitsservices-production.up.railway.app";

  await http.get(Uri.parse("$url/tempRoutes/AddStudents"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"
      });

  await tester.pump(const Duration(seconds: 1));

  await tester.pumpWidget(const GetMaterialApp(home: CampusControl()));

  await localGlobals.GetVehicles();

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 3));

  await tester.tap(find.byKey(const Key("KSD 731 GP")));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  final floatingActionBtn = find.byIcon(Icons.send);

  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final findCampusName = find.text("Business School");

  await tester.tap(find.text("Health Campus"));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.tap(findCampusName);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle();

  // await localGlobals.GetStudents();
  await tester.pumpAndSettle(const Duration(seconds: 3));
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key("student1@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("student2@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("student3@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final findStart = find.byKey(const Key("start"));

  await tester.tap(findStart);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final findStudentDigz = find.text("Student Digz");
  final findJOne = find.text("J-One");

  await tester.tap(findStudentDigz);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(findJOne);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  //End Shift
  final findEndShiftBtn = find.byIcon(Icons.exit_to_app);

  //Open bottom sheet
  await tester.tap(findEndShiftBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final endShiftBtn = find.text("End Shift");

  await tester.tap(endShiftBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await http.get(Uri.parse("$url/tempRoutes/RemoveStudents"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  });

  await preferences.clear();
  await tester.pump(const Duration(seconds: 5));
}

//
Future<void> _selectDepTest(WidgetTester tester) async {

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("email", "a2355285@wits.ac.za");
  sharedPreferences.setString("username", "Sabelo Mabena");
  await main_globals.getSharedPreferences();

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return const GetMaterialApp(home: StaffPage());
  }));

  await tester.pumpAndSettle(const Duration(seconds: 1));

  final findDining = find.text("Dining Services");

  await tester.tap(findDining);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.text("Convocation"));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.pumpAndSettle();

  final editIcon = find.byKey(const Key("Option A breakfast Edit"));

  await tester.tap(editIcon);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final item = find.text("Corn Flakes");

  await tester.tap(item);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final confirmBtn = find.byIcon(Icons.check);

  await tester.tap(confirmBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  // (find.byKey(const Key('loading')),findsWidgets);

  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.pumpAndSettle();

  //Lunch

  final lunchTab = find.byKey(const Key('lunchTab'));

  await tester.tap(lunchTab);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final editIcon2 = find.byKey(const Key("Option A lunch Edit"));

  await tester.tap(editIcon2);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final item2 = find.text("Pizza");

  await tester.tap(item2);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  await tester.tap(confirmBtn);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  // Dinner

  await tester.pumpAndSettle();

  final dinnerTab = find.byKey(const Key('dinnerTab'));

  await tester.tap(dinnerTab);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final editIcon3 = find.byKey(const Key("Option A dinner Edit"));

  await tester.tap(editIcon3);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final item3 = find.text("Ham");

  await tester.tap(item3);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  await tester.tap(confirmBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  await sharedPreferences.clear();
  await tester.pump(const Duration(seconds: 5));
}

Future<void> _checkBuses(WidgetTester tester) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("email", "a23552855@wits.ac.za");
  sharedPreferences.setString("username", "tester");
  await main_globals.getSharedPreferences();

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return const GetMaterialApp(home: StaffPage());
  }));

  await tester.pumpAndSettle(const Duration(seconds: 1));

  final card = find.text("Bus Services");

  await tester.tap(card);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.pumpAndSettle();
  await sharedPreferences.clear();
  await tester.pump(const Duration(seconds: 5));
}

Future<void> _checkCampusControl(WidgetTester tester) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("email", "a23552855@wits.ac.za");
  sharedPreferences.setString("username", "tester");
  await main_globals.getSharedPreferences();

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return const GetMaterialApp(home: StaffPage());
  }));

  await tester.pumpAndSettle(const Duration(seconds: 1));

  final card = find.text("Campus Control");

  await tester.tap(card);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.pumpAndSettle();
  await sharedPreferences.clear();
  await tester.pump(const Duration(seconds: 5));
}

// Campus Control Students

Future<void> _campusControlUnsubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: const GetMaterialApp(home: Protection()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
}

Future<void> _campusControlSubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, child) {
      set()async{
        await Future.delayed(const Duration(seconds: 1));
        context.read<Subscriptions>().addSub('campus_control');
      }set();
      Get.put(Booked());
      final busesController = Get.put(BusesController());
      busesController.getSharedPreferences();
      busesController.getRoutes();
      return const GetMaterialApp(home: Protection());
    },
  );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Book Ride'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('From'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('From'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('To'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('To'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
}

// CCDU Students

Future<void> _ccduUnsubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: const GetMaterialApp(home: CCDU()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));

  await tester.pump(const Duration(seconds: 2));
}

Future<void> _ccduSubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, child) {
      set()async{
        await Future.delayed(const Duration(seconds: 1));
        CCDUObject session = CCDUObject();
        session.setAppointment(
            '',
            'Pending',
            '12:30-13:30',
            '06/10/2022',
            'Meeting',
            't2375736@wits.ac.za',
            'Dr AP Chuma',
            'Online');
        context.read<Subscriptions>().addCCDUBooking(session);
      }set();
      return const GetMaterialApp(home: CCDU());
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.text('New Session'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.text('Online'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.text('Date'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.text('Submit'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
}

Future<void> _ccduStaffTests(WidgetTester tester) async {
  const username = 'Sabelo Mabena';
  const email = 'a2355285@wits.ac.za';

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('department', 'CCDU');

  await main_globals.getSharedPreferences();
  String url = "https://sdpwitsservices-production.up.railway.app";

  await http.get(Uri.parse("$url/ccdu/TestSetup/Init"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"
      });

  await tester.pumpWidget(const GetMaterialApp(home: CCDU()));
  await tester.pump(const Duration(seconds: 1));

  final profile = find.text("S");
  final allTab = find.text("All");
  final acceptedTab = find.text("Accepted");


  await tester.tap(allTab);
  await tester.pump(const Duration(seconds: 4));

  //All card
  await tester.tap(find.byKey(const Key("test1btn")));
  await tester.pump(const Duration(seconds: 2));

  final submitBtn = find.text("Submit");

  await tester.enterText(find.byKey(const Key("linkTextField")), "Some link");
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.tap(submitBtn);
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump(const Duration(seconds: 4));

  await tester.tap(find.text("Close"));
  await tester.pump(const Duration(seconds: 3));

  await tester.tap(acceptedTab);
  await tester.pump(const Duration(seconds: 4));

  await tester.pump(const Duration(seconds: 1));

  await tester.tap(profile);
  await tester.pump(const Duration(seconds: 1));


  await http.get(Uri.parse("$url/ccdu/TestSetup/Cleanup"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"
      });
  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// Start

Future<void> _start(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: GetMaterialApp(home: Start(email: '2375736@students.wits.ac.za', username: 'Nathi',)),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
}

// Events

Future<void> _eventsStudents(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, child) {
      Get.put(Booked());
      final eventsController = Get.put(EventsController());
      eventsController.getEvents();
      set()async{
        Future<void> getEvents(BuildContext context) async {
          await eventsController.getEvents();
          await http.get(Uri.parse("${uri}db/getEvents/"), headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          }).then((response) {
            var data = jsonDecode(response.body);
            List<EventObject> events = [];
            for(dynamic event in data){
              List<String> likes = [];
              for(String like in event["likes"]){
                likes.add(like);
              }
              EventObject curr = EventObject(event['title'], event['date'], event['time'], likes, event['venue'], event['type'], event['id'], event['imageUrl']);
              events.add(curr);
            }
            context.read<Subscriptions>().setEvents(events);
          });
        }
        await getEvents(context);
        Random rnd = Random();
        int studentNumber = 1912345 + rnd.nextInt(2512345 - 1912345);
        context.read<UserData>().setEmail('$studentNumber@students.wits.ac.za');
      }set();
      final busesController = Get.put(BusesController());
      busesController.getSharedPreferences();
      busesController.getRoutes();
      return const GetMaterialApp(home: studentsEvents.Events());
    },
  );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('like0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('image0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
}
