import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/main.dart' as app;
import 'package:sdp_wits_services/StaffApp/Buses/buses_main.dart' as buses;
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart' as profile;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end buses test", () {
    testWidgets("Staff Buses", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      Widget createWidgetForTesting({required Widget child}) {
        return MaterialApp(
          home: child,
        );
      }
      const username = 'Nkosinathi Chuma';
      const email = 'a2375736@wits.ac.za';
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool( 'onShift', false);
      preferences.setString('username', username);
      preferences.setString('email', email);

      await tester.pumpWidget(createWidgetForTesting(child: const buses.BusesMain()));
      await tester.pumpAndSettle();
      final witsServices = find.text('Buses');
      expect(witsServices, findsOneWidget);

      await tester.pump(const Duration(seconds: 1));
      final circleAvatar = find.byType(CircleAvatar);
      expect(circleAvatar, findsOneWidget);
      preferences.clear();
      await tester.pumpAndSettle();
    });
    testWidgets("Staff Profile", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      Widget createWidgetForTesting({required Widget child}) {
        return MaterialApp(
          home: child,
        );
      }
      const username = 'Nkosinathi Chuma';
      const email = 'a2375736@wits.ac.za';
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('username', username);
      preferences.setString('email', email);

      await tester.pumpWidget(createWidgetForTesting(child: profile.Profile(email, username)));
      await tester.pumpAndSettle();
      final findUsername = find.text(username);
      final findEmail = find.text(email);
      final findIconButtons = find.byType(IconButton);
      final findIcon = find.byType(Icon);
      final findClipOval = find.byType(ClipOval);
      expect(findUsername, findsOneWidget);
      expect(findEmail, findsOneWidget);
      expect(findIcon, findsWidgets);
      expect(findIconButtons, findsWidgets);
      expect(findClipOval, findsWidgets);
      preferences.clear();
      await tester.pump(const Duration(seconds: 1));

    });
  });
}
