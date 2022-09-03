import 'package:flutter/material.dart';
import 'package:flutter_login/src/constants.dart';
import 'package:flutter_login/src/widgets/animated_button.dart';
import 'package:flutter_login/src/widgets/animated_icon.dart';
import 'package:flutter_test/flutter_test.dart';

bool? isSignup(WidgetTester tester) {
  return confirmPasswordTextFieldWidget(tester).enabled;
}

Finder findLogoImage() {
  return find.byType(Image);
}

Finder findTitle() {
  return find.byKey(kTitleKey);
}

Finder findNthField(int n) {
  return find.byType(TextFormField).at(n);
}

Finder findNameTextField() {
  return find.byType(TextFormField).at(0);
}

Finder findPasswordTextField() {
  return find.byType(TextFormField).at(1);
}

Finder findConfirmPasswordTextField() {
  return find.byType(TextFormField).at(2);
}

Finder findForgotPasswordButton() {
  return find.byType(MaterialButton).at(0);
}

Finder findSwitchAuthButton() {
  return find.byType(MaterialButton).at(1);
}

Finder findDebugToolbar() {
  return find.byKey(kDebugToolbarKey);
}

Image logoWidget(WidgetTester tester) {
  return tester.widget<Image>(findLogoImage());
}

TextField nameTextFieldWidget(WidgetTester tester) {
  return tester.widgetList<TextField>(find.byType(TextField)).elementAt(0);
}

TextField passwordTextFieldWidget(WidgetTester tester) {
  return tester.widgetList<TextField>(find.byType(TextField)).elementAt(1);
}

TextField confirmPasswordTextFieldWidget(WidgetTester tester) {
  return tester.widgetList<TextField>(find.byType(TextField)).elementAt(2);
}

AnimatedIconButton firstProviderButton() {
  return find.byType(AnimatedIconButton).evaluate().first.widget
  as AnimatedIconButton;
}

AnimatedButton submitButtonWidget() {
  return find.byType(AnimatedButton).evaluate().first.widget as AnimatedButton;
}

TextButton forgotPasswordButtonWidget() {
  return find.byType(TextButton).evaluate().first.widget as TextButton;
}

MaterialButton switchAuthButtonWidget() {
  return find.byType(MaterialButton).evaluate().last.widget as MaterialButton;
}

MaterialButton goBackButtonWidget() {
  return find.byType(MaterialButton).evaluate().last.widget as MaterialButton;
}

Text recoverIntroTextWidget() {
  return find.byKey(kRecoverPasswordIntroKey).evaluate().single.widget as Text;
}

Text recoverDescriptionTextWidget() {
  return find.byKey(kRecoverPasswordDescriptionKey).evaluate().single.widget
  as Text;
}