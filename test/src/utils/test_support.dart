import 'package:analyzer/dart/ast/ast.dart' show AstNode, SimpleIdentifier;
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/exception/exception.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/java_engine.dart';
import 'package:analyzer/src/generated/parser.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:plugin/manager.dart';
import 'package:plugin/plugin.dart';
import 'package:test/test.dart';

/**
 * The class `EngineTestCase` defines utility methods for making assertions.
 */
class EngineTestCase {
  /**
   * Flag indicating whether the fasta parser is being used.
   */
  bool get usingFastaParser => Parser.useFasta;

  /**
   * Assert that the given collection has the same number of elements as the number of specified
   * names, and that for each specified name, a corresponding element can be found in the given
   * collection with that name.
   *
   * @param elements the elements
   * @param names the names
   */
  void assertNamedElements(List<Element> elements, List<String> names) {
    for (String elemName in names) {
      bool found = false;
      for (Element elem in elements) {
        if (elem.name == elemName) {
          found = true;
          break;
        }
      }
      if (!found) {
        StringBuffer buffer = new StringBuffer();
        buffer.write("Expected element named: ");
        buffer.write(elemName);
        buffer.write("\n  but found: ");
        for (Element elem in elements) {
          buffer.write(elem.name);
          buffer.write(", ");
        }
        fail(buffer.toString());
      }
    }
    expect(elements, hasLength(names.length));
  }

  /*
  AnalysisContext createAnalysisContext() {
    return AnalysisContextFactory.contextWithCore();
  }
  */

  /**
   * Return the getter in the given type with the given name. Inherited getters are ignored.
   *
   * @param type the type in which the getter is declared
   * @param getterName the name of the getter to be returned
   * @return the property accessor element representing the getter with the given name
   */
  PropertyAccessorElement getGetter(InterfaceType type, String getterName) {
    for (PropertyAccessorElement accessor in type.element.accessors) {
      if (accessor.isGetter && accessor.name == getterName) {
        return accessor;
      }
    }
    fail("Could not find getter named $getterName in ${type.displayName}");
  }

  /**
   * Return the method in the given type with the given name. Inherited methods are ignored.
   *
   * @param type the type in which the method is declared
   * @param methodName the name of the method to be returned
   * @return the method element representing the method with the given name
   */
  MethodElement getMethod(InterfaceType type, String methodName) {
    for (MethodElement method in type.element.methods) {
      if (method.name == methodName) {
        return method;
      }
    }
    fail("Could not find method named $methodName in ${type.displayName}");
  }

  void setUp() {
    List<Plugin> plugins = <Plugin>[];
    plugins.addAll(AnalysisEngine.instance.requiredPlugins);
    new ExtensionManager().processPlugins(plugins);
  }

  void tearDown() {}

  /**
   * Assert that the given object is an instance of the expected class.
   *
   * @param expectedClass the class that the object is expected to be an instance of
   * @param object the object being tested
   * @return the object that was being tested
   * @throws Exception if the object is not an instance of the expected class
   */
  static Object assertInstanceOf(
      Predicate<Object> predicate, Type expectedClass, Object object) {
    if (!predicate(object)) {
      fail(
          "Expected instance of $expectedClass, found ${object == null ? "null" : object.runtimeType}");
    }
    return object;
  }

  /**
   * @return the [AstNode] with requested type at offset of the "prefix".
   */
  static AstNode findNode(
      AstNode root, String code, String prefix, Predicate<AstNode> predicate) {
    int offset = code.indexOf(prefix);
    if (offset == -1) {
      throw new ArgumentError("Not found '$prefix'.");
    }
    AstNode node = new NodeLocator(offset).searchWithin(root);
    return node.getAncestor(predicate);
  }

  /**
   * Find the [SimpleIdentifier] with at offset of the "prefix".
   */
  static SimpleIdentifier findSimpleIdentifier(
      AstNode root, String code, String prefix) {
    int offset = code.indexOf(prefix);
    if (offset == -1) {
      throw new ArgumentError("Not found '$prefix'.");
    }
    return new NodeLocator(offset).searchWithin(root);
  }
}

/**
 * A description of an error that is expected to be reported.
 */
class ExpectedError {
  /**
   * An empty array of error descriptors used when no errors are expected.
   */
  static List<ExpectedError> NO_ERRORS = <ExpectedError>[];

  /**
   * The error code associated with the error.
   */
  final ErrorCode code;

  /**
   * The offset of the beginning of the error's region.
   */
  final int offset;

  /**
   * The offset of the beginning of the error's region.
   */
  final int length;

  /**
   * Initialize a newly created error description.
   */
  ExpectedError(this.code, this.offset, this.length);
}

/**
 * An error listener that collects all of the errors passed to it for later
 * examination.
 */
class GatheringErrorListener implements AnalysisErrorListener {
  /**
   * A flag indicating whether error ranges are to be compared when comparing
   * expected and actual errors.
   */
  final bool checkRanges;

  /**
   * A list containing the errors that were collected.
   */
  List<AnalysisError> _errors = <AnalysisError>[];

  /**
   * A table mapping sources to the line information for the source.
   */
  Map<Source, LineInfo> _lineInfoMap = <Source, LineInfo>{};

  /**
   * Initialize a newly created error listener to collect errors.
   */
  GatheringErrorListener({this.checkRanges = Parser.useFasta});

  /**
   * Return the errors that were collected.
   */
  List<AnalysisError> get errors => _errors;

  /**
   * Return `true` if at least one error has been gathered.
   */
  bool get hasErrors => _errors.length > 0;

  /**
   * Add the given [errors] to this listener.
   */
  void addAll(List<AnalysisError> errors) {
    for (AnalysisError error in errors) {
      onError(error);
    }
  }

  /**
   * Add all of the errors recorded by the given [listener] to this listener.
   */
  void addAll2(RecordingErrorListener listener) {
    addAll(listener.errors);
  }

  /**
   * Assert that the number of errors that have been gathered matches the number
   * of [expectedErrors] and that they have the expected error codes and
   * locations. The order in which the errors were gathered is ignored.
   */
  void assertErrors(List<ExpectedError> expectedErrors) {
    if (_errors.length != expectedErrors.length) {
      _fail(expectedErrors);
    }
    List<ExpectedError> remainingErrors = expectedErrors.toList();
    for (AnalysisError error in _errors) {
      if (!_foundAndRemoved(remainingErrors, error)) {
        _fail(expectedErrors);
      }
    }
  }

  /**
   * Assert that the number of errors that have been gathered matches the number
   * of [expectedErrorCodes] and that they have the expected error codes. The
   * order in which the errors were gathered is ignored.
   */
  void assertErrorsWithCodes(
      [List<ErrorCode> expectedErrorCodes = const <ErrorCode>[]]) {
    StringBuffer buffer = new StringBuffer();
    //
    // Compute the expected number of each type of error.
    //
    Map<ErrorCode, int> expectedCounts = <ErrorCode, int>{};
    for (ErrorCode code in expectedErrorCodes) {
      int count = expectedCounts[code];
      if (count == null) {
        count = 1;
      } else {
        count = count + 1;
      }
      expectedCounts[code] = count;
    }
    //
    // Compute the actual number of each type of error.
    //
    Map<ErrorCode, List<AnalysisError>> errorsByCode =
        <ErrorCode, List<AnalysisError>>{};
    for (AnalysisError error in _errors) {
      errorsByCode
          .putIfAbsent(error.errorCode, () => <AnalysisError>[])
          .add(error);
    }
    //
    // Compare the expected and actual number of each type of error.
    //
    expectedCounts.forEach((ErrorCode code, int expectedCount) {
      int actualCount;
      List<AnalysisError> list = errorsByCode.remove(code);
      if (list == null) {
        actualCount = 0;
      } else {
        actualCount = list.length;
      }
      if (actualCount != expectedCount) {
        if (buffer.length == 0) {
          buffer.write("Expected ");
        } else {
          buffer.write("; ");
        }
        buffer.write(expectedCount);
        buffer.write(" errors of type ");
        buffer.write(code.uniqueName);
        buffer.write(", found ");
        buffer.write(actualCount);
      }
    });
    //
    // Check that there are no more errors in the actual-errors map,
    // otherwise record message.
    //
    errorsByCode.forEach((ErrorCode code, List<AnalysisError> actualErrors) {
      int actualCount = actualErrors.length;
      if (buffer.length == 0) {
        buffer.write("Expected ");
      } else {
        buffer.write("; ");
      }
      buffer.write("0 errors of type ");
      buffer.write(code.uniqueName);
      buffer.write(", found ");
      buffer.write(actualCount);
      buffer.write(" (");
      for (int i = 0; i < actualErrors.length; i++) {
        AnalysisError error = actualErrors[i];
        if (i > 0) {
          buffer.write(", ");
        }
        buffer.write(error.offset);
      }
      buffer.write(")");
    });
    if (buffer.length > 0) {
      fail(buffer.toString());
    }
  }

  /**
   * Assert that the number of errors that have been gathered matches the number
   * of [expectedSeverities] and that there are the same number of errors and
   * warnings as specified by the argument. The order in which the errors were
   * gathered is ignored.
   */
  void assertErrorsWithSeverities(List<ErrorSeverity> expectedSeverities) {
    int expectedErrorCount = 0;
    int expectedWarningCount = 0;
    for (ErrorSeverity severity in expectedSeverities) {
      if (severity == ErrorSeverity.ERROR) {
        expectedErrorCount++;
      } else {
        expectedWarningCount++;
      }
    }
    int actualErrorCount = 0;
    int actualWarningCount = 0;
    for (AnalysisError error in _errors) {
      if (error.errorCode.errorSeverity == ErrorSeverity.ERROR) {
        actualErrorCount++;
      } else {
        actualWarningCount++;
      }
    }
    if (expectedErrorCount != actualErrorCount ||
        expectedWarningCount != actualWarningCount) {
      fail(
          "Expected $expectedErrorCount errors and $expectedWarningCount warnings, found $actualErrorCount errors and $actualWarningCount warnings");
    }
  }

  /**
   * Assert that no errors have been gathered.
   */
  void assertNoErrors() {
    assertErrors(ExpectedError.NO_ERRORS);
  }

  /**
   * Return the line information associated with the given [source], or `null`
   * if no line information has been associated with the source.
   */
  LineInfo getLineInfo(Source source) => _lineInfoMap[source];

  /**
   * Return `true` if an error with the given [errorCode] has been gathered.
   */
  bool hasError(ErrorCode errorCode) {
    for (AnalysisError error in _errors) {
      if (identical(error.errorCode, errorCode)) {
        return true;
      }
    }
    return false;
  }

  @override
  void onError(AnalysisError error) {
    _errors.add(error);
  }

  /**
   * Set the line information associated with the given [source] to the given
   * list of [lineStarts].
   */
  void setLineInfo(Source source, List<int> lineStarts) {
    _lineInfoMap[source] = new LineInfo(lineStarts);
  }

  /**
   * Return `true` if the [actualError] matches the [expectedError].
   */
  bool _equalErrors(ExpectedError expectedError, AnalysisError actualError) {
    if (!identical(expectedError.code, actualError.errorCode)) {
      return false;
    } else if (!checkRanges) {
      return true;
    }
    return expectedError.offset == actualError.offset &&
        expectedError.length == actualError.length;
  }

  /**
   * Assert that the number of errors that have been gathered matches the number
   * of [expectedErrors] and that they have the expected error codes. The order
   * in which the errors were gathered is ignored.
   */
  void _fail(List<ExpectedError> expectedErrors) {
    StringBuffer buffer = new StringBuffer();
    buffer.write("Expected ");
    buffer.write(expectedErrors.length);
    buffer.write(" errors:");
    for (ExpectedError error in expectedErrors) {
      buffer.writeln();
      int offset = error.offset;
      buffer.write('  ${error.code} ($offset..${offset + error.length})');
    }
    buffer.writeln();
    buffer.write("found ");
    buffer.write(_errors.length);
    buffer.write(" errors:");
    for (AnalysisError error in _errors) {
      buffer.writeln();
      int offset = error.offset;
      buffer.write('  ${error.errorCode} '
          '($offset..${offset + error.length}): ${error.message}');
    }
    fail(buffer.toString());
  }

  /**
   * Search through the given list of [errors] for an error that is equal to the
   * [targetError]. If one is found, remove it from the list and return `true`,
   * otherwise return `false` without modifying the list.
   */
  bool _foundAndRemoved(List<ExpectedError> errors, AnalysisError targetError) {
    for (ExpectedError error in errors) {
      if (_equalErrors(error, targetError)) {
        errors.remove(error);
        return true;
      }
    }
    return false;
  }
}

/**
 * Instances of the class [TestLogger] implement a logger that can be used by
 * tests.
 */
class TestLogger implements Logger {
  /**
   * All logged messages.
   */
  List<String> log = [];

  @override
  void logError(String message, [CaughtException exception]) {
    log.add("error: $message");
  }

  @override
  void logInformation(String message, [CaughtException exception]) {
    log.add("info: $message");
  }
}

class TestSource extends Source {
  String _name;
  String _contents;
  int _modificationStamp = 0;
  bool exists2 = true;

  /**
   * A flag indicating whether an exception should be generated when an attempt
   * is made to access the contents of this source.
   */
  bool generateExceptionOnRead = false;

  /**
   * The number of times that the contents of this source have been requested.
   */
  int readCount = 0;

  TestSource([this._name = '/test.dart', this._contents]);

  TimestampedData<String> get contents {
    readCount++;
    if (generateExceptionOnRead) {
      String msg = "I/O Exception while getting the contents of " + _name;
      throw new Exception(msg);
    }
    return new TimestampedData<String>(0, _contents);
  }

  String get encoding => _name;

  String get fullName {
    return _name;
  }

  int get hashCode => 0;

  bool get isInSystemLibrary {
    return false;
  }

  @override
  int get modificationStamp =>
      generateExceptionOnRead ? -1 : _modificationStamp;

  String get shortName {
    return _name;
  }

  Uri get uri => new Uri.file(_name);

  UriKind get uriKind {
    throw new UnsupportedError('uriKind');
  }

  bool operator ==(Object other) {
    if (other is TestSource) {
      return other._name == _name;
    }
    return false;
  }

  bool exists() => exists2;
  void getContentsToReceiver(Source_ContentReceiver receiver) {
    throw new UnsupportedError('getContentsToReceiver');
  }

  Source resolve(String uri) {
    throw new UnsupportedError('resolve');
  }

  void setContents(String value) {
    generateExceptionOnRead = false;
    _modificationStamp = new DateTime.now().millisecondsSinceEpoch;
    _contents = value;
  }

  @override
  String toString() => '$_name';
}

class TestSourceWithUri extends TestSource {
  final Uri uri;

  TestSourceWithUri(String path, this.uri, [String content])
      : super(path, content);

  String get encoding => uri.toString();

  UriKind get uriKind {
    if (uri == null) {
      return UriKind.FILE_URI;
    } else if (uri.scheme == 'dart') {
      return UriKind.DART_URI;
    } else if (uri.scheme == 'package') {
      return UriKind.PACKAGE_URI;
    }
    return UriKind.FILE_URI;
  }

  bool operator ==(Object other) {
    if (other is TestSource) {
      return other.uri == uri;
    }
    return false;
  }
}
