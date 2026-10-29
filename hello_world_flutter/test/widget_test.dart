import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world_flutter/main.dart';

void main() {
  testWidgets('affiche le texte Hello World', (WidgetTester tester) async {
    await tester.pumpWidget(const HelloWorldApp());

    expect(find.text('Hello World'), findsOneWidget);
    expect(find.text('Mon premier projet Flutter'), findsOneWidget);
  });
}
