library test.src.test_all;

import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'model/test_all.dart' as model_all;

/// Utility for manually running all tests.
main() {
  defineReflectiveSuite(() {
    model_all.main();
  });
}
