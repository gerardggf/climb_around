import 'package:flutter_test/flutter_test.dart';
import 'package:climb_around/app/climb_around_app.dart';

// We should create all the tests and use lcov for code coverage

//flutter test --coverage
//genhtml coverage/lcov.info -o coverage/html
//open coverage/html/index.html

// Use riverpod_test for provider testing and mocktail for mocking classes

//TODO: WIP widget testing

void main() {
  testWidgets('Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ClimbAroundApp(),
    );
  });

  //.....
}
