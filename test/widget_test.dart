import 'package:flutter_test/flutter_test.dart';
import 'package:climb_around/app/climb_around_app.dart';

// We should create all the tests and use lcov for code coverage

//flutter test --coverage
//genhtml coverage/lcov.info -o coverage/html
//open coverage/html/index.html

//TODO: WIP widget testing

void main() {
  testWidgets('Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ClimbAroundApp(),
    );
  });
}
