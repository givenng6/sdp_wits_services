import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/main.dart' as app;

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end app test", () {
    final continueAsStudentButton =
        find.byKey(const Key('Continue as Student'));
    final continueAsStaffButton = find.byKey(const Key('Continue as Staff'));

    testWidgets("continue as student", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 5000));
      await tester.pumpAndSettle();
      final continueAsStudent = find.text('Continue as Student');
      expect(continueAsStudent, findsOneWidget);
      final continueAsStaff = find.text('Continue as Staff');
      expect(continueAsStaff, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(continueAsStudentButton);
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      final witsServices = find.text('Wits Services');
      expect(witsServices, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('SIGNUP'));
      await tester.pumpAndSettle();
      final confirmPassword = find.text('Confirm Password');
      expect(confirmPassword, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();
      final resetYourPasswordHere = find.text('Reset your password here');
      expect(resetYourPasswordHere, findsOneWidget);
      final weWillSendALinkToTheEmailAccount =
          find.text('We will send a link to the email account.');
      expect(weWillSendALinkToTheEmailAccount, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('RECOVER'));
      await tester.pumpAndSettle();
      final invalidEmail = find.text('Invalid email!');
      expect(invalidEmail, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('BACK'));
      await tester.pumpAndSettle();
      final email = find.text('Email');
      expect(email, findsOneWidget);
      final password = find.text('Password');
      expect(password, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('SIGNUP'));
      await tester.pumpAndSettle();
      expect(invalidEmail, findsOneWidget);
      final passwordIsTooShort = find.text('Password is too short!');
      expect(passwordIsTooShort, findsOneWidget);
      await tester.enterText(findNameTextField(), '2375736@students.wits.ac.za');
      await Future.delayed(const Duration(seconds: 1));

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();
    });

    testWidgets("continue as staff", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 5000));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(continueAsStaffButton);
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      final witsServices = find.text('Wits Services');
      expect(witsServices, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('SIGNUP'));
      await tester.pumpAndSettle();
      final confirmPassword = find.text('Confirm Password');
      expect(confirmPassword, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();
      final resetYourPasswordHere = find.text('Reset your password here');
      expect(resetYourPasswordHere, findsOneWidget);
      final weWillSendALinkToTheEmailAccount =
          find.text('We will send a link to the email account.');
      expect(weWillSendALinkToTheEmailAccount, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('RECOVER'));
      await tester.pumpAndSettle();
      final invalidEmail = find.text('Invalid email!');
      expect(invalidEmail, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('BACK'));
      await tester.pumpAndSettle();
      final email = find.text('Email');
      expect(email, findsOneWidget);
      final password = find.text('Password');
      expect(password, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('SIGNUP'));
      await tester.pumpAndSettle();
      expect(invalidEmail, findsOneWidget);
      final passwordIsTooShort = find.text('Password is too short!');
      expect(passwordIsTooShort, findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
    });
  });
}
