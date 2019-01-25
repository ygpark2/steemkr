import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'account.dart' as account_test;

/**
 * Utility for manually running all tests.
 */
main() {
  defineReflectiveSuite(() {
    account_test.main();
  }, name: 'account');
}
