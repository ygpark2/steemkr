import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:steemkr/src/model/timetable.dart';

class TimetableService {
  final _logger = Logger('TimetableService');

  static final _headers = {'Content-Type': 'application/json'};
  static const _timetableUrl = 'api/data/timetable.json'; // URL to web API
  final Client _http;

  final List<Timetable> posts = [];
  bool loading = true;

  TimetableService(this._http);

  Future<List<Timetable>> getAll() async {
    try {
      final response = await _http.get(_timetableUrl);
      return (_extractData(response) as List)
          .map((value) => Timetable.fromJson(value))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    _logger.severe(e);
    return Exception('Server error; cause: $e');
  }
}
