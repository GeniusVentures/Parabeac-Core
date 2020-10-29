import 'package:parabeac_core/generation/generators/pb_flutter_writer.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('Flutter writer test', () {
    var writer;
    var testingPath =
        '/Volumes/Storage/Projects/Parabeac-Core/test/lib/output_services/test_file.dart';
    setUp(() {
      writer = PBFlutterWriter();
    });

    test('', () async {
      writer.write('Code to be written!', testingPath);

      expect(await File(testingPath).exists(), true);

      // To delete the testing file once the test is done
      await File(testingPath).delete();
    });
  });
}