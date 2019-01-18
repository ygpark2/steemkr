import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:logging/logging.dart';

import 'routes.dart';
import 'src/component/layout/layout_component.dart';
import 'src/service/firebase_service.dart';
import 'src/service/steem_api_service.dart';
import 'src/service/timetable_service.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [
    coreDirectives,
    routerDirectives,
    LayoutComponent,
  ],
  providers: const [
    ClassProvider(SteemApiService),
    ClassProvider(FirebaseService),
    ClassProvider(TimetableService)
  ],
  exports: [RoutePaths, Routes],
)
class AppComponent {
  final SteemApiService _steemApiService;

  final _logger = Logger('AppComponent');

  AppComponent(this._steemApiService) {
    _logger.info("--------------------- ng init start ~~~~~~~~~~~~~~~~~~~~~");
    _steemApiService.call(
        "condenser_api.get_accounts",
        [
          ["steemit"]
        ],
        steemApiSuccessCallback,
        steemApiFailureCallback);
  }

  @override
  ngOnInit() => _ngInit();

  Future<void> _ngInit() async {
    _logger.info("--------------------- ng init start ~~~~~~~~~~~~~~~~~~~~~");
    _steemApiService.call(
        "condenser_api.get_accounts",
        [
          ["steemit"]
        ],
        (successRsp) => {},
        steemApiFailureCallback);
  }

  steemApiSuccessCallback(result) {
    print("return => " + result);
  }

  steemApiFailureCallback(result) {
    print("return => " + result);
  }
}
