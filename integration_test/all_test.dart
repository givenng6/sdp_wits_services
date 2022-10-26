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
  group("end-to-end app test", () {
    // App Student
    testWidgets("login as student", _logInAsStudentTests);
    testWidgets("signIn as student", _signInAsStudentTests);
    testWidgets("_recover email student", _recoverStudentTests);

    // App Staff
    testWidgets("login as staff", _logInAsStaffTests);
    testWidgets("signIn as staff", _signInAsStaffTests);
    testWidgets("_recover email staff", _recoverStaffTests);

    // Buses
    testWidgets('unsubscribed student buses main', _unSubbedBusesTests);
    testWidgets('subscribed student buses main', _subbedBusesTests);
    testWidgets('staff buses main', _busesTests);

    // Dashboard
    testWidgets("dashboard", _dashboardTests);
    testWidgets("dining breakfast", _diningBreakfastTests);
    testWidgets("dining lunch", _diningLunchTests);

    // Dining
    testWidgets("Staff Dining", _staffDiningTests);
    testWidgets("Student Dining", _studentDiningTests);

    // Profile
    testWidgets("Students Profile", _studentsProfileTests);
    testWidgets("Staff Profile", _staffProfileTests);

    // Staff Dining
    testWidgets("selectWidget", _selectDHtest);
    testWidgets("_selectItems", _selectItems);

    // Students Dining
    testWidgets("Unsubscribed Students Dining", _unSubbedDiningTests);
    testWidgets("Subscribed Students Dining", _subbedDiningTests);
    testWidgets("Main Dining", _mainDiningTests);

    // Stuff Campus Control
    testWidgets("Campus Control tests", _campusControlTest);

    //
    testWidgets("SelectDepartment", _selectDepTest);
    testWidgets("Check Buses", _checkBuses);
    testWidgets("Check Campus Control", _checkCampusControl);

    // Campus Control Students
    testWidgets("Unsubscribed Campus Control", _campusControlUnsubscribedTest);
    testWidgets("Subscribed Campus Control", _campusControlSubscribedTest);

    // CCDU Students
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
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStudent = find.text('Continue as Student');
  expect(continueAsStudent, findsWidgets);
  final continueAsStaff = find.text('Continue as Staff');
  expect(continueAsStaff, findsWidgets);

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final witsServices = find.text('Wits Services');
  expect(witsServices, findsWidgets);

  await tester.pumpAndSettle();
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
}

Future<void> _signInAsStudentTests(WidgetTester tester)async{
  final continueAsStudentButton =
  find.byKey(const Key('Continue as Student'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStudent = find.text('Continue as Student');
  expect(continueAsStudent, findsWidgets);
  final continueAsStaff = find.text('Continue as Staff');
  expect(continueAsStaff, findsWidgets);

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final witsServices = find.text('Wits Services');
  expect(witsServices, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
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
}

Future<void> _recoverStudentTests(WidgetTester tester)async{
  final continueAsStudentButton =
  find.byKey(const Key('Continue as Student'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStudent = find.text('Continue as Student');
  expect(continueAsStudent, findsWidgets);
  final continueAsStaff = find.text('Continue as Staff');
  expect(continueAsStaff, findsWidgets);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final witsServices = find.text('Wits Services');
  expect(witsServices, findsWidgets);

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

  await tester.pump(const Duration(seconds: 1));
}

// App Staff

Future<void> _logInAsStaffTests(WidgetTester tester)async{
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStudent = find.text('Continue as Student');
  expect(continueAsStudent, findsWidgets);
  final continueAsStaff = find.text('Continue as Staff');
  expect(continueAsStaff, findsWidgets);

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final witsServices = find.text('Wits Services');
  expect(witsServices, findsWidgets);

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
}

Future<void> _signInAsStaffTests(WidgetTester tester)async{
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStudent = find.text('Continue as Student');
  expect(continueAsStudent, findsWidgets);
  final continueAsStaff = find.text('Continue as Staff');
  expect(continueAsStaff, findsWidgets);

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final witsServices = find.text('Wits Services');
  expect(witsServices, findsWidgets);

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
}

Future<void> _recoverStaffTests(WidgetTester tester)async{
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStudent = find.text('Continue as Student');
  expect(continueAsStudent, findsWidgets);
  final continueAsStaff = find.text('Continue as Staff');
  expect(continueAsStaff, findsWidgets);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final witsServices = find.text('Wits Services');
  expect(witsServices, findsWidgets);

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

  await tester.pump(const Duration(seconds: 1));
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
    child: const MaterialApp(home: Buses()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  expect(find.text('Bus Services'), findsWidgets);
  expect(find.text('To access this service you must be subscribed'), findsWidgets);
  expect(find.text('Subscribe'), findsWidgets);

  await tester.pump(const Duration(seconds: 3));
  preferences.clear();
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
      return const MaterialApp(home: Buses());
    },
  );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  await tester.pump(const Duration(seconds: 15));
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

  Widget widget = MaterialApp(
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
  await tester.pump(const Duration(seconds: 2));
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
      return const MaterialApp(home: Dashboard(),);
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
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
      return const MaterialApp(home: Dashboard(),);
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
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
      return const MaterialApp(home: Dashboard(),);
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
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
      return const MaterialApp(home: Dining(),);
    },
  );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();
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

  Widget widget = const MaterialApp(
    home: mealSelecionPage(),
  );
  debugPrint('here');
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();

  final findDHTitle = find.text(dhName);
  final findUserInitial = find.text('L');
  final findBreakfastText = find.text('Breakfast');
  final findLunchText = find.text('Lunch');
  final findDinnerText = find.text('Dinner');
  final findOptionA = find.text('Option A');
  final findOptionB = find.text('Option B');
  final findOptionC = find.text('Option C');
  final findIcon = find.byType(Icon);
  expect(findDHTitle, findsWidgets);
  expect(findUserInitial, findsWidgets);
  expect(findBreakfastText, findsWidgets);
  expect(findLunchText, findsWidgets);
  expect(findDinnerText, findsWidgets);
  expect(findOptionA, findsWidgets);
  expect(findOptionB, findsWidgets);
  expect(findOptionC, findsWidgets);
  expect(findIcon, findsWidgets);
  await tester.tap(findLunchText);
  await tester.pumpAndSettle();

  expect(findOptionA, findsWidgets);
  expect(findOptionB, findsWidgets);
  expect(findOptionC, findsWidgets);

  await tester.tap(findDinnerText);
  await tester.pumpAndSettle();

  expect(findOptionA, findsWidgets);
  expect(findOptionB, findsWidgets);
  expect(findOptionC, findsWidgets);

  preferences.clear();
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

      return const MaterialApp(
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

  await tester.pump(const Duration(seconds: 1));

  preferences.clear();
}

Future<void> _staffProfileTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = 'a2375736@wits.ac.za';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MaterialApp(
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

  await tester.pump(const Duration(seconds: 1));
  preferences.clear();
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

    return const MaterialApp(home: SelectDH());
  }));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findCardItem = find.text('Main');
  final findSelectDH = find.text("Dining Hall");
  final findUserName = find.text("S");
  final findIcon = find.byIcon(Icons.fastfood);

  expect(findCardItem, findsWidgets);
  expect(findSelectDH, findsWidgets);
  expect(findUserName, findsWidgets);
  expect(findIcon, findsWidgets);

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
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


  await tester.pumpWidget(MaterialApp(
    home: SelectOptionItems(
      package: package,
      type: "breakfast",
    ),
  ));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findTitle = find.text('Select Items');
  final findItem = find.text("Oats");

  expect(findTitle, findsWidgets);
  expect(findItem, findsWidgets);

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
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
    child: const MaterialApp(
        home: Dining()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  expect(find.text('Dining Services'), findsWidgets);
  expect(find.text('To access this service you must be subscribed'), findsWidgets);
  expect(find.text('Subscribe'), findsWidgets);

  await tester.pump(const Duration(seconds: 3));
  preferences.clear();
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
    child: MaterialApp(
        home: Dining(isTesting: true, email: email, diningHalls: diningHalls,)),
  );

  await tester.pumpWidget(widget);
  await tester.pump(const Duration(seconds: 3));

  await tester.pumpAndSettle();
  expect(find.text('Dining Services'), findsWidgets);
  expect(find.text('Follow'), findsWidgets);
  expect(find.text('Following'), findsWidgets);
  expect(find.text('Main'), findsWidgets);
  expect(find.text('Jubilee'), findsWidgets);
  expect(find.text('Convocation'), findsWidgets);
  expect(find.text('Highfield'), findsWidgets);
  expect(find.text('Ernest Openheimer'), findsWidgets);
  expect(find.text('Knockando'), findsWidgets);
  expect(find.text('A44 Wits East Campus'), findsWidgets);

  await tester.pump(const Duration(seconds: 3));
  preferences.clear();
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
    return MaterialApp(home: ViewDH(diningHalls[0]));
  }));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  expect(find.text('Main'), findsWidgets);
  expect(find.text('Breakfast'), findsWidgets);
  expect(find.text('Lunch'), findsWidgets);
  expect(find.text('Dinner'), findsWidgets);
  expect(find.text('Option 1'), findsWidgets);
  expect(find.text('Option 2'), findsWidgets);
  expect(find.text('Option 3'), findsWidgets);

  for(int i = 0; i < diningHalls[0].bfA.length; i++) {
    expect(find.text(diningHalls[0].bfA[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].bfB.length; i++) {
    expect(find.text(diningHalls[0].bfB[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].bfC.length; i++) {
    expect(find.text(diningHalls[0].bfC[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].lA.length; i++) {
    expect(find.text(diningHalls[0].lA[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].lB.length; i++) {
    expect(find.text(diningHalls[0].lB[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].lC.length; i++) {
    expect(find.text(diningHalls[0].lC[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].dA.length; i++) {
    expect(find.text(diningHalls[0].dA[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].dB.length; i++) {
    expect(find.text(diningHalls[0].dB[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].dC.length; i++) {
    expect(find.text(diningHalls[0].dC[i]), findsWidgets);
  }

  await tester.pump(const Duration(seconds: 10));
  preferences.clear();
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

  await tester.pumpWidget(const MaterialApp(home: CampusControl()));

  await localGlobals.GetVehicles();
  // debugPrint("hh ${localGlobals.vehicles}");

  await tester.pumpAndSettle();

  // await tester.pump(const Duration(seconds: 6));

  final findCardItem = find.text('Campus Control');
  final findSelectDH = find.text("Vehicles");
  final findUserName = find.text("S");
  final findIcon = find.byIcon(Icons.security);

  expect(findCardItem, findsOneWidget);
  expect(findSelectDH, findsOneWidget);
  expect(findUserName, findsOneWidget);

  expect(findIcon, findsOneWidget);
  await tester.pump(const Duration(seconds: 3));

  final findNumPlate = find.text("- KSD 731 GP");
  expect(findNumPlate, findsOneWidget);
  final findCarName = find.text("Avanza");
  expect(findCarName, findsWidgets);

  await tester.tap(find.byKey(const Key("KSD 731 GP")));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  final floatingActionBtn = find.byIcon(Icons.send);
  expect(floatingActionBtn, findsOneWidget);

  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final findCampusName = find.text("Business School");
  expect(findCampusName, findsOneWidget);

  await tester.tap(find.text("Health Campus"));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.tap(findCampusName);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  expect(floatingActionBtn, findsOneWidget);

  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle();

  // await localGlobals.GetStudents();
  await tester.pumpAndSettle(const Duration(seconds: 3));
  await tester.pumpAndSettle();

  final findStudent1Name = find.text("Student One");
  final findStudent1res = find.text("- Student Digz");

  final findStudent2Name = find.text("Student Two");

  final findStudent3Name = find.text("Student One");
  final findStudent3res = find.text("- J-One");

  expect(findStudent1Name, findsWidgets);
  expect(findStudent1res, findsWidgets);

  expect(findStudent2Name, findsWidgets);

  expect(findStudent3Name, findsWidgets);
  expect(findStudent3res, findsWidgets);

  await tester.tap(find.byKey(const Key("student1@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("student2@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("student3@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final findStart = find.byKey(const Key("start"));

  expect(findStart, findsOneWidget);

  await tester.tap(findStart);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final findStudentDigz = find.text("Student Digz");
  final findJOne = find.text("J-One");

  expect(findStudentDigz, findsWidgets);
  expect(findJOne, findsWidgets);

  await tester.tap(findStudentDigz);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(findJOne);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  expect(floatingActionBtn, findsWidgets);

  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  //End Shift
  final findEndShiftBtn = find.byIcon(Icons.exit_to_app);
  expect(findEndShiftBtn, findsWidgets);

  //Open bottom sheet
  await tester.tap(findEndShiftBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final conText = find.text("Are you sure you want to end shift?");
  expect(conText, findsWidgets);

  final endShiftBtn = find.text("End Shift");
  expect(endShiftBtn, findsWidgets);
  expect(find.text("Cancel"), findsWidgets);

  await tester.tap(endShiftBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await http.get(Uri.parse("$url/tempRoutes/RemoveStudents"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  });

  // await tester.pump(const Duration(seconds: 0));
  preferences.clear();
}

//
Future<void> _selectDepTest(WidgetTester tester) async {

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("email", "a2355285@wits.ac.za");
  sharedPreferences.setString("username", "Sabelo Mabena");
  await main_globals.getSharedPreferences();

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return const MaterialApp(home: StaffPage());
  }));

  await tester.pumpAndSettle(const Duration(seconds: 1));

  expect(find.byKey(const Key("logoImg")),findsOneWidget);
  expect(find.text("Departments"),findsOneWidget);

  final findDining = find.text("Dining Services");
  expect(findDining,findsWidgets);

  await tester.tap(findDining);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.text("Convocation"));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.pumpAndSettle();

  final editIcon = find.byKey(const Key("Option A breakfast Edit"));
  expect(editIcon,findsWidgets);

  await tester.tap(editIcon);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final item = find.text("Corn Flakes");
  expect(item,findsOneWidget);

  await tester.tap(item);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final confirmBtn = find.byIcon(Icons.check);
  expect(confirmBtn,findsOneWidget);

  await tester.tap(confirmBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  // expect(find.byKey(const Key('loading')),findsWidgets);

  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.pumpAndSettle();

  //Lunch

  final lunchTab = find.byKey(const Key('lunchTab'));
  expect(lunchTab,findsOneWidget);

  await tester.tap(lunchTab);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final editIcon2 = find.byKey(const Key("Option A lunch Edit"));
  expect(editIcon2,findsWidgets);

  await tester.tap(editIcon2);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final item2 = find.text("Pizza");
  expect(item2,findsWidgets);

  await tester.tap(item2);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  expect(confirmBtn,findsOneWidget);

  await tester.tap(confirmBtn);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  // Dinner

  await tester.pumpAndSettle();

  final dinnerTab = find.byKey(const Key('dinnerTab'));
  expect(dinnerTab,findsOneWidget);

  await tester.tap(dinnerTab);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final editIcon3 = find.byKey(const Key("Option A dinner Edit"));
  expect(editIcon3,findsWidgets);

  await tester.tap(editIcon3);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final item3 = find.text("Ham");
  expect(item3,findsWidgets);

  await tester.tap(item3);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  expect(confirmBtn,findsOneWidget);

  await tester.tap(confirmBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  sharedPreferences.clear();

}

Future<void> _checkBuses(WidgetTester tester) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("email", "a23552855@wits.ac.za");
  sharedPreferences.setString("username", "tester");
  await main_globals.getSharedPreferences();

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return const MaterialApp(home: StaffPage());
  }));

  await tester.pumpAndSettle(const Duration(seconds: 1));

  final card = find.text("Bus Services");
  expect(card,findsOneWidget);

  await tester.tap(card);
  await tester.pumpAndSettle(const Duration(seconds: 3));
  expect(find.text("Buses"),findsWidgets);

  await tester.pumpAndSettle();
  sharedPreferences.clear();

}

Future<void> _checkCampusControl(WidgetTester tester) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("email", "a23552855@wits.ac.za");
  sharedPreferences.setString("username", "tester");
  await main_globals.getSharedPreferences();

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return const MaterialApp(home: StaffPage());
  }));

  await tester.pumpAndSettle(const Duration(seconds: 1));

  final card = find.text("Campus Control");
  expect(card,findsOneWidget);

  await tester.tap(card);
  await tester.pumpAndSettle(const Duration(seconds: 3));
  expect(find.text("Vehicles"),findsWidgets);

  await tester.pumpAndSettle();
  sharedPreferences.clear();
}

// Campus Control Students

Future<void> _campusControlUnsubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: const MaterialApp(home: Protection()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));

  expect(
      find.text('To access this service you must be subscribed'), findsWidgets);
  expect(find.text('Campus Control'), findsWidgets);
  expect(find.text('Subscribe'), findsWidgets);
  expect(find.text('Book Ride'), findsWidgets);

  await tester.pump(const Duration(seconds: 2));
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
      return const MaterialApp(home: Protection());
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

  await tester.pump(const Duration(seconds: 1));
}

// CCDU Students

Future<void> _ccduUnsubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: const MaterialApp(home: CCDU()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));

  expect(find.text('CCDU'), findsWidgets);
  // expect(find.text('Campus Control'), findsWidgets);
  expect(find.text('No Data'), findsWidgets);
  expect(find.text('New Session'), findsWidgets);

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
      return const MaterialApp(home: CCDU());
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));

  expect(find.text('CCDU'), findsWidgets);
  // expect(find.text('Campus Control'), findsWidgets);
  expect(find.text('Appointment 1'), findsWidgets);
  expect(find.text('Date: 06/10/2022'), findsWidgets);
  expect(find.text('Time: 12:30-13:30'), findsWidgets);
  expect(find.text('Counsellor: Dr AP Chuma'), findsWidgets);
  expect(find.text('Pending'), findsWidgets);
  expect(find.text('New Session'), findsWidgets);

  await tester.tap(find.text('New Session'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 2));

  // expect(find.text('New Session'), findsWidgets);
  // expect(find.text('Submit'), findsWidgets);
  // expect(find.text('Date'), findsWidgets);
  // expect(find.text('Change Date'), findsWidgets);
  // expect(find.text('Time'), findsWidgets);
  // expect(find.text('09:00'), findsWidgets);
  // expect(find.text('Change Time'), findsWidgets);
  // expect(find.text('Meeting Location'), findsWidgets);
  // expect(find.text('Online'), findsWidgets);
  // expect(find.text('Choose Counsellor (optional)'), findsWidgets);
  // expect(find.text('Add Description'), findsWidgets);
  expect(find.byType(Icon), findsWidgets);

  await tester.tap(find.text('Online'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.text('Date'), warnIfMissed: false);
  await tester.pumpAndSettle();

  // await tester.pump(const Duration(seconds: 2));

  // await tester.tap(find.byKey(const Key('Choose Counsellor')), warnIfMissed: false);
  // await tester.pumpAndSettle();
  //
  // await tester.pump(const Duration(seconds: 10));
  //
  // expect(find.text('Dr AP Chuma'), findsWidgets);
  //
  // await tester.pump(const Duration(seconds: 2));
  //
  // await tester.tap(find.text('Date'), warnIfMissed: false);
  // await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.text('Submit'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 2));
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

  await tester.pumpWidget(const MaterialApp(home: CCDU()));
  expect(find.text("No Upcoming Appointments"), findsOneWidget);
  await tester.pump(const Duration(seconds: 1));

  final ccduIcon = find.byIcon(Icons.psychology_outlined);
  final ccduText = find.text("CCDU");
  final profile = find.text("S");
  final allTab = find.text("All");
  final acceptedTab = find.text("Accepted");

  expect(ccduIcon, findsOneWidget);
  expect(ccduText, findsOneWidget);
  expect(profile, findsOneWidget);
  expect(allTab, findsOneWidget);
  expect(acceptedTab, findsOneWidget);

  await tester.tap(allTab);
  await tester.pump(const Duration(seconds: 4));

  //All card
  expect(find.text("Lindokuhle Mabena"), findsWidgets);
  expect(find.text("Date: 07/11/2022"), findsWidgets);
  expect(find.text("Time: 08:00-09:00"), findsWidgets);
  expect(find.text("Platform: Online"), findsWidgets);
  expect(find.text("Description"), findsWidgets);
  expect(find.text("Some description"), findsWidgets);
  expect(find.text("ACCEPT"), findsWidgets);
  expect(find.text("Other Bookings"), findsOneWidget);

  await tester.tap(find.byKey(const Key("test1btn")));
  await tester.pump(const Duration(seconds: 2));

  expect(find.text("Link"), findsWidgets);
  final submitBtn = find.text("Submit");
  expect(submitBtn, findsOneWidget);

  await tester.enterText(find.byKey(const Key("linkTextField")), "Some link");
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.tap(submitBtn);
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump(const Duration(seconds: 4));

  expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
  expect(find.text("Appointment confirmed"), findsOneWidget);
  expect(find.text("Close"), findsOneWidget);

  await tester.tap(find.text("Close"));
  await tester.pump(const Duration(seconds: 3));

  await tester.tap(acceptedTab);
  await tester.pump(const Duration(seconds: 4));

  expect(find.text("Lindokuhle Mabena"), findsWidgets);
  expect(find.text("Date: 07/11/2022"), findsWidgets);
  expect(find.text("Time: 08:00-09:00"), findsWidgets);
  expect(find.text("Platform: Online"), findsWidgets);
  expect(find.text("Description"), findsWidgets);
  expect(find.text("Some description"), findsWidgets);

  await tester.pump(const Duration(seconds: 1));

  await tester.tap(profile);
  await tester.pump(const Duration(seconds: 1));


  await http.get(Uri.parse("$url/ccdu/TestSetup/Cleanup"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"
      });
  await tester.pump(const Duration(seconds: 1));
  preferences.clear();
}

// Start

Future<void> _start(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: MaterialApp(home: Start(email: '2375736@students.wits.ac.za', username: 'Nathi',)),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 20));

  // expect(find.text('Campus Control'), findsWidgets);
  // expect(find.text('Ride Request'), findsWidgets);
  // expect(find.text('Dashboard'), findsWidgets);
  // expect(find.text('Buses'), findsWidgets);
  // expect(find.text('Dining Hall'), findsWidgets);
  // expect(find.text('Protection'), findsWidgets);
  // expect(find.text('Menu'), findsWidgets);
  // expect(find.byType(Icon), findsWidgets);

  await tester.pump(const Duration(seconds: 2));
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
      return const MaterialApp(home: studentsEvents.Events());
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

  await tester.pump(const Duration(seconds: 10));
}
