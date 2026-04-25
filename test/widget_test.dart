import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pro_link/main.dart';

Future<void> _useLargeSurface(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(1080, 2400));
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

void main() {
  testWidgets('Role selector renders all three role buttons', (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    expect(find.text('Pro-Link'), findsOneWidget);
    expect(find.textContaining('Administrator'), findsWidgets);
    expect(find.textContaining('Mentor'), findsWidgets);
    expect(find.textContaining('Intern'), findsWidgets);
  });

  testWidgets('Tapping Intern button navigates to the intern dashboard',
      (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    await tester.tap(find.text('Continue as Intern'));
    await tester.pumpAndSettle();

    expect(find.text('Intern Dashboard'), findsOneWidget);
    expect(find.textContaining('Work ID'), findsWidgets);
  });

  testWidgets('Admin dashboard shows pending interns and approves them',
      (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    await tester.tap(find.text('Continue as Administrator'));
    await tester.pumpAndSettle();

    expect(find.text('Administrator Dashboard'), findsOneWidget);
    expect(find.text('Amine Kacem'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Approve').first);
    await tester.pumpAndSettle();

    expect(find.text('Amine Kacem'), findsNothing);
  });
}
