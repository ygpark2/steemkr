import 'dart:convert';
import 'dart:io';

@Timeout(const Duration(seconds: 45))
import 'package:analyzer/dart/analysis/declared_variables.dart';
import 'package:analyzer/src/generated/constant.dart';
import 'package:analyzer/src/generated/testing/test_type_provider.dart';
import 'package:steemkr/src/model/blog/content.dart';
import 'package:steemkr/src/model/serializers.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../utils/test_support.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ContentTest);
  });
}

@reflectiveTest
class ContentTest extends EngineTestCase {
  void setUp() {
    print("--------------- setUp -------------------");
  }

  void tearDown() {
    print("--------------- tearDown -------------------");
  }

  void test_getContent() async {
    Directory current = Directory.current;

    print(current.path);

    var file = new File("./test/data/blog/get_content.json");

    var jsonString = await file.readAsString(encoding: utf8);

    var decodedData = json.decode(jsonString);

    var content = serializers.deserializeWith(Content.serializer, decodedData);

    print(content);

    print(content.active_votes[13].weight);
    print(content.active_votes[13].rshares);
  }

  void test_getAccount2() {
    TestTypeProvider typeProvider = new TestTypeProvider();
    String variableName = "var";
    DeclaredVariables variables =
        new DeclaredVariables.fromMap({variableName: 'false'});
    DartObject object = variables.getBool(typeProvider, variableName);
    expect(object, isNotNull);
    expect(object.toBoolValue(), false);
  }
}
