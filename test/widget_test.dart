import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pro_link/data/mock_data.dart';
import 'package:pro_link/main.dart';

String _pw(String email) => MockData.seedPasswords[email]!;

Future<void> _useLargeSurface(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(1080, 2400));
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

Future<void> _signIn(
  WidgetTester tester,
  String email,
  String secret,
) async {
  await tester.enterText(find.widgetWithText(TextFormField, 'Email'), email);
  await tester.enterText(
    find.widgetWithText(TextFormField, 'Password'),
    secret,
  );
  await tester.tap(find.widgetWithText(ElevatedButton, 'Sign in'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Login screen renders branding and sign-in form', (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    expect(find.text('Pro-Link'), findsOneWidget);
    expect(find.text('Sign in'), findsWidgets);
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
    expect(find.text('Register as intern'), findsOneWidget);
  });

  testWidgets('Login validates empty inputs', (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign in'));
    await tester.pump();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('Login rejects invalid credentials', (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    const String email = 'admin@prolink.dz';
    await _signIn(tester, email, '${_pw(email)}-bad-suffix');

    expect(find.text('Invalid email or password'), findsOneWidget);
    expect(find.text('Administrator Dashboard'), findsNothing);
  });

  testWidgets('Admin login redirects to admin dashboard', (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    const String email = 'admin@prolink.dz';
    await _signIn(tester, email, _pw(email));

    expect(find.text('Administrator Dashboard'), findsOneWidget);
    expect(find.text('Amine Kacem'), findsOneWidget);
  });

  testWidgets('Mentor login redirects to mentor dashboard with name',
      (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    const String email = 'mentor@prolink.dz';
    await _signIn(tester, email, _pw(email));

    expect(find.text('Mentor Dashboard'), findsOneWidget);
    expect(find.text('Welcome, Mounir Saidi'), findsOneWidget);
  });

  testWidgets('Approved intern login redirects to intern dashboard',
      (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    const String email = 'sara.benali@univ-constantine2.dz';
    await _signIn(tester, email, _pw(email));

    expect(find.text('Intern Dashboard'), findsOneWidget);
    expect(find.text('Sara Benali'), findsWidgets);
  });

  testWidgets('Unapproved intern login lands on pending-approval screen',
      (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    const String email = 'yacine.haddadi@univ-constantine2.dz';
    await _signIn(tester, email, _pw(email));

    expect(find.text('Awaiting validation'), findsOneWidget);
    expect(find.text('Pending approval'), findsOneWidget);
  });

  testWidgets(
    'Approving a pending intern moves them to assignedInterns and marks them approved',
    (tester) async {
      const String internEmail = 'amine.kacem@univ-constantine2.dz';
      MockData.seedPasswords.putIfAbsent(internEmail, () => 'amine123');

      await _useLargeSurface(tester);
      await tester.pumpWidget(const ProLinkApp());

      const String adminEmail = 'admin@prolink.dz';
      await _signIn(tester, adminEmail, _pw(adminEmail));
      expect(find.text('Administrator Dashboard'), findsOneWidget);
      expect(find.text('Amine Kacem'), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Approve').first);
      await tester.pump();

      expect(
        MockData.pendingInterns.any((u) => u.email == internEmail),
        isFalse,
        reason: 'approved intern should leave pendingInterns',
      );
      final approved = MockData.assignedInterns
          .firstWhere((u) => u.email == internEmail);
      expect(
        approved.approved,
        isTrue,
        reason: 'approved flag must flip to true on copyWith',
      );
    },
  );

  testWidgets('Register flow creates a pending intern', (tester) async {
    await _useLargeSurface(tester);
    await tester.pumpWidget(const ProLinkApp());

    await tester.tap(find.text('Register as intern'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Full name'),
      'Test User',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'test.user@univ-constantine2.dz',
    );
    final String fakeSecret = _pw('admin@prolink.dz');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      fakeSecret,
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm password'),
      fakeSecret,
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create account'));
    await tester.pumpAndSettle();

    expect(find.text('Awaiting validation'), findsOneWidget);
    expect(find.text('test.user@univ-constantine2.dz'), findsOneWidget);
  });
}
