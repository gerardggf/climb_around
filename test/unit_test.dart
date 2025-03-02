import 'package:climb_around/app/core/utils/extensions/date_extension.dart';
import 'package:test/test.dart';

//TODO: WIP unit testing
void main() {
  group(
    'Date functions',
    () {
      test('Test date fotmatting', () async {
        final result = DateTime(1999, 9, 13).toDDMMYYYY();
        expect(result, '13/09/1999');
      });

      test('Test time fotmatting', () async {
        final result = DateTime(1999, 9, 13, 22, 1).toHHmm();
        expect(result, '22:01');
      });
    },
  );
}
