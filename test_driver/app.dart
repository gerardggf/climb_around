import 'package:flutter_driver/driver_extension.dart';
import 'package:climb_around/main.dart' as app;

//To run integration tests: "flutter drive --target=test_driver/app.dart"
void main() {
  enableFlutterDriverExtension();
  app.main();
}
