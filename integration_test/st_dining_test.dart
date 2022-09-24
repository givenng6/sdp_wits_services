import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/Dining.dart';

void main(){
  group('Students Dining Test', () {
    testWidgets("Display Title", (WidgetTester tester) async {
        expect(find.text('Dining Services'), findsNothing);
  });
  });
}