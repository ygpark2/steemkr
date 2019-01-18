library yogamindful.src.model.timetable;

class Timetable {
  final int id;
  String title;
  String content;
  String teacher;
  Schedule schedule;

  Timetable(this.id, this.title, this.content, this.teacher, this.schedule);

  factory Timetable.fromJson(Map<String, dynamic> timetable) => Timetable(
      _toInt(timetable['id']),
      timetable['title'],
      timetable['content'],
      timetable['teacher'],
      Schedule.fromJson(timetable['schedule']));

  Map toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'teacher': teacher,
        'schedule': schedule.toJson()
      };
}

int _toInt(id) => id is int ? id : int.parse(id);

class Schedule {
  List<TimeSchedule> Mon;
  List<TimeSchedule> Tue;
  List<TimeSchedule> Wed;
  List<TimeSchedule> Thu;
  List<TimeSchedule> Fri;
  List<TimeSchedule> Sat;
  List<TimeSchedule> Sun;

  Schedule(
      this.Mon, this.Tue, this.Wed, this.Thu, this.Fri, this.Sat, this.Sun);

  factory Schedule.fromJson(Map<String, dynamic> schedule) => Schedule(
      (schedule['Mon'] as List)
          .map((jsonData) => TimeSchedule.fromJson(jsonData))
          .toList(),
      (schedule['Tue'] as List)
          .map((jsonData) => TimeSchedule.fromJson(jsonData))
          .toList(),
      (schedule['Wed'] as List)
          .map((jsonData) => TimeSchedule.fromJson(jsonData))
          .toList(),
      (schedule['Thu'] as List)
          .map((jsonData) => TimeSchedule.fromJson(jsonData))
          .toList(),
      (schedule['Fri'] as List)
          .map((jsonData) => TimeSchedule.fromJson(jsonData))
          .toList(),
      (schedule['Sat'] as List)
          .map((jsonData) => TimeSchedule.fromJson(jsonData))
          .toList(),
      (schedule['Sun'] as List)
          .map((jsonData) => TimeSchedule.fromJson(jsonData))
          .toList());

  Map toJson() => {
        'Mon': Mon.map((ts) => ts.toJson()),
        'Tue': Tue.map((ts) => ts.toJson()),
        'Wed': Wed.map((ts) => ts.toJson()),
        'Thu': Thu.map((ts) => ts.toJson()),
        'Fri': Fri.map((ts) => ts.toJson()),
        'Sat': Sat.map((ts) => ts.toJson()),
        'Sun': Sun.map((ts) => ts.toJson()),
      };
}

class TimeSchedule {
  String startTime;
  String endTime;

  TimeSchedule(this.startTime, this.endTime);

  factory TimeSchedule.fromJson(Map<String, dynamic> timeSchedule) =>
      TimeSchedule(timeSchedule['startTime'], timeSchedule['endTime']);

  Map toJson() => {'startTime': startTime, 'endTime': endTime};
}
