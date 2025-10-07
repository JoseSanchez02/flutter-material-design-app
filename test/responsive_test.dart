import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_material_app/utils/responsive_utils.dart';

void main() {
  group('Responsive Layout Tests', () {
    testWidgets('ResponsiveBuilder shows mobile layout on small screens',
        (WidgetTester tester) async {
      // Set up a small screen size (phone)
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResponsiveBuilder(
              mobile: (context) => const Text('Mobile Layout'),
              tablet: (context) => const Text('Tablet Layout'),
              desktop: (context) => const Text('Desktop Layout'),
            ),
          ),
        ),
      );

      // Verify mobile layout is displayed
      expect(find.text('Mobile Layout'), findsOneWidget);
      expect(find.text('Tablet Layout'), findsNothing);
      expect(find.text('Desktop Layout'), findsNothing);

      // Reset to default
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('ResponsiveBuilder shows tablet layout on medium screens',
        (WidgetTester tester) async {
      // Set up a tablet screen size
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResponsiveBuilder(
              mobile: (context) => const Text('Mobile Layout'),
              tablet: (context) => const Text('Tablet Layout'),
              desktop: (context) => const Text('Desktop Layout'),
            ),
          ),
        ),
      );

      // Verify tablet layout is displayed
      expect(find.text('Tablet Layout'), findsOneWidget);
      expect(find.text('Mobile Layout'), findsNothing);
      expect(find.text('Desktop Layout'), findsNothing);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('ResponsiveBuilder shows desktop layout on large screens',
        (WidgetTester tester) async {
      // Set up a desktop screen size
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResponsiveBuilder(
              mobile: (context) => const Text('Mobile Layout'),
              tablet: (context) => const Text('Tablet Layout'),
              desktop: (context) => const Text('Desktop Layout'),
            ),
          ),
        ),
      );

      // Verify desktop layout is displayed
      expect(find.text('Desktop Layout'), findsOneWidget);
      expect(find.text('Mobile Layout'), findsNothing);
      expect(find.text('Tablet Layout'), findsNothing);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('Grid columns adjust based on screen size',
        (WidgetTester tester) async {
      // Test mobile portrait (should be 2 columns)
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final columns = ResponsiveUtils.getGridColumns(context);
                return Text('Columns: $columns');
              },
            ),
          ),
        ),
      );

      expect(find.text('Columns: 2'), findsOneWidget);

      // Test tablet landscape (should be 4 columns)
      tester.view.physicalSize = const Size(1200, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final columns = ResponsiveUtils.getGridColumns(context);
                return Text('Columns: $columns');
              },
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Columns: 4'), findsOneWidget);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    test('Device type detection works correctly', () {
      // Mobile
      expect(
        ResponsiveUtils.getDeviceTypeFromWidth(400),
        DeviceType.mobile,
      );

      // Tablet
      expect(
        ResponsiveUtils.getDeviceTypeFromWidth(700),
        DeviceType.tablet,
      );

      // Desktop
      expect(
        ResponsiveUtils.getDeviceTypeFromWidth(1200),
        DeviceType.desktop,
      );
    });

    test('Breakpoints are correctly defined', () {
      expect(ResponsiveUtils.mobileBreakpoint, 600.0);
      expect(ResponsiveUtils.tabletBreakpoint, 840.0);
    });
  });
}
