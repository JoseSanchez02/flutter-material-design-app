import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_material_app/screens/create_edit_screen.dart';

void main() {
  group('Form Validation Tests', () {
    testWidgets('Form validation - title field is required',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CreateEditScreen(),
        ),
      );

      // Find the save button
      final saveButton = find.widgetWithText(TextButton, 'Save');
      expect(saveButton, findsOneWidget);

      // Try to submit without filling the form
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Verify error message appears
      expect(find.text('Please enter a title'), findsOneWidget);
    });

    testWidgets('Form validation - title must be at least 3 characters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CreateEditScreen(),
        ),
      );

      // Enter a title that's too short
      final titleField = find.widgetWithText(TextFormField, 'Title');
      await tester.enterText(titleField, 'AB');

      // Try to submit
      final saveButton = find.widgetWithText(TextButton, 'Save');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Verify error message
      expect(find.text('Title must be at least 3 characters'), findsOneWidget);
    });

    testWidgets('Form validation - description field is required',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CreateEditScreen(),
        ),
      );

      // Enter only title
      final titleField = find.widgetWithText(TextFormField, 'Title');
      await tester.enterText(titleField, 'Test Title');

      // Try to submit without description
      final saveButton = find.widgetWithText(TextButton, 'Save');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Verify error message
      expect(find.text('Please enter a description'), findsOneWidget);
    });

    testWidgets('Form validation - description must be at least 10 characters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CreateEditScreen(),
        ),
      );

      // Enter title
      final titleField = find.widgetWithText(TextFormField, 'Title');
      await tester.enterText(titleField, 'Test Title');

      // Enter description that's too short
      final descField = find.widgetWithText(TextFormField, 'Description');
      await tester.enterText(descField, 'Short');

      // Try to submit
      final saveButton = find.widgetWithText(TextButton, 'Save');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Verify error message
      expect(
        find.text('Description must be at least 10 characters'),
        findsOneWidget,
      );
    });

    testWidgets('Form shows correct title for create mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CreateEditScreen(),
        ),
      );

      expect(find.text('Create Item'), findsOneWidget);
      expect(find.text('Edit Item'), findsNothing);
    });

    testWidgets('Image selection button is present',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CreateEditScreen(),
        ),
      );

      // Verify image selection button exists
      expect(find.widgetWithText(OutlinedButton, 'Add Image'), findsOneWidget);
    });

    testWidgets('Help text is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CreateEditScreen(),
        ),
      );

      // Verify help text exists
      expect(
        find.textContaining('Fill in all required fields'),
        findsOneWidget,
      );
    });

    testWidgets('All form fields have proper icons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CreateEditScreen(),
        ),
      );

      // Verify icons are present
      expect(find.byIcon(Icons.title), findsOneWidget);
      expect(find.byIcon(Icons.description), findsOneWidget);
      expect(find.byIcon(Icons.add_photo_alternate), findsOneWidget);
    });
  });
}
