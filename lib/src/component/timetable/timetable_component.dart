import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:logging/logging.dart';
import 'package:steemkr/src/model/timetable.dart';
import 'package:steemkr/src/service/timetable_service.dart';

@Component(
    selector: 'timetable',
    styleUrls: [
      'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
      'timetable_component.css'
    ],
    templateUrl: 'timetable_component.html',
    pipes: [commonPipes],
    directives: [
      MaterialButtonComponent,
      NgStyle,
      NgFor,
      NgIf,
    ])
class TimetableComponent implements OnInit {
  final TimetableService _timetableService;

  final _logger = Logger('TimetableComponent');

  String errorMessage;

  List<String> weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<String> thBgColors = <String>['#ffe2ec', '#ffedcd', '#cadca0'];

  List<int> hours = new List<int>.generate(24, (i) => i + 1);

  List<Timetable> timeTables = [];

  DateTime today = new DateTime.now();

  DateTime getDate(int idx) =>
      today.subtract(Duration(days: today.weekday - idx));

  TimetableComponent(this._timetableService);

  Map<String, String> setThBgStyles(int idx) {
    int codeIdx = idx % 3;
    return <String, String>{'background-color': thBgColors[codeIdx]};
  }

  @override
  ngOnInit() => _getTimetable();

  Future<void> _getTimetable() async {
    _logger.info("=========== get time table ===============");
    try {
      timeTables = await _timetableService.getAll();
      _logger.info("============= timetable ====================");
      timeTables.forEach((tt) => _logger.info(tt.toJson()));
      _logger.info("------------- timetable --------------------");
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  bool ngIfTest(timeTables) {
    _logger.info("-------------------------");
    _logger.info(timeTables?.first);

    return true;
  }

  List<TimeSchedule> getMaxDayOfWeek(Schedule schedule) {
    List<List<TimeSchedule>> timeScheduleList = [
      schedule.Mon,
      schedule.Tue,
      schedule.Wed,
      schedule.Thu,
      schedule.Fri,
      schedule.Sat,
      schedule.Sun
    ];

    return timeScheduleList
        .reduce((curr, next) => curr.length > next.length ? curr : next);
  }
}
