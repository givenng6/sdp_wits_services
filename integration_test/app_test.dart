import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end app test", () {
    testWidgets("continue as student", _continueAsStudentTests);
    testWidgets("continue as staff", _continueAsStaffTests);
  });
}

Future<void> _continueAsStudentTests(WidgetTester tester)async{
  final continueAsStudentButton =
  find.byKey(const Key('Continue as Student'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStudent = find.text('Continue as Student');
  expect(continueAsStudent, findsOneWidget);
  final continueAsStaff = find.text('Continue as Staff');
  expect(continueAsStaff, findsOneWidget);

  await tester.pumpAndSettle();
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
  await Future.delayed(const Duration(seconds: 1));
  final passwordIsTooShort = find.text('Password is too short!');
  expect(passwordIsTooShort, findsOneWidget);
  // await tester.tap(find.text('LOGIN'));
  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), '23123456@students.wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '1234567890');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findConfirmPasswordTextField(), '1234567890');
  await tester.pumpAndSettle();
  // FocusScope.of(context).unfocus();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'));
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 3));
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final enterUsernameToCompleteSignup = find.text('Enter your username in this form to complete signup');
  await tester.tap(find.text('SUBMIT'));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  expect(enterUsernameToCompleteSignup, findsOneWidget);
  final username = find.text('Username');
  expect(username, findsOneWidget);
  final usernameIsRequired = find.text('Username is required!');
  expect(usernameIsRequired, findsOneWidget);
  final submit = find.text('SUBMIT');
  expect(submit, findsOneWidget);
  final back = find.text('BACK');
  expect(back, findsOneWidget);
  await tester.enterText(findNthField(0), 'Nathi');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('BACK'));
  await tester.pumpAndSettle();
  expect(find.text('Email'), findsOneWidget);
}

Future<void> _continueAsStaffTests(WidgetTester tester) async{
  final continueAsStaffButton = find.byKey(const Key('Continue as Staff'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
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

  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), 'a23123456@wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '1234567890');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findConfirmPasswordTextField(), '1234567890');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'))
  ;await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 3));
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final enterUsernameToCompleteSignup = find.text('Enter your username in this form to complete signup');
  await tester.tap(find.text('SUBMIT'));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  expect(enterUsernameToCompleteSignup, findsOneWidget);
  final username = find.text('Username');
  expect(username, findsOneWidget);
  final usernameIsRequired = find.text('Username is required!');
  expect(usernameIsRequired, findsOneWidget);
  final submit = find.text('SUBMIT');
  expect(submit, findsOneWidget);
  final back = find.text('BACK');
  expect(back, findsOneWidget);
  await tester.enterText(findNthField(0), 'Nathi');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('BACK'));
  await tester.pumpAndSettle();
  expect(find.text('Email'), findsOneWidget);

  await Future.delayed(const Duration(seconds: 1));
}