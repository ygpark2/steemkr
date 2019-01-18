import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'src/component/about/about_component.template.dart' as about_template;
import 'src/component/contact/contact_component.template.dart'
    as contact_template;
import 'src/component/home/home_component.template.dart' as home_template;
import 'src/component/price/price_component.template.dart' as pricing_template;
import 'src/component/timetable/timetable_component.template.dart'
    as timetable_template;

export 'package:steemkr/route_paths.dart';

class Routes {
  static final home = RouteDefinition(
    routePath: RoutePaths.home,
    component: home_template.HomeComponentNgFactory,
  );

  static final timetable = RouteDefinition(
    routePath: RoutePaths.timetable,
    component: timetable_template.TimetableComponentNgFactory,
  );

  static final pricing = RouteDefinition(
    routePath: RoutePaths.pricing,
    component: pricing_template.PriceComponentNgFactory,
  );

  static final about = RouteDefinition(
    routePath: RoutePaths.about,
    component: about_template.AboutComponentNgFactory,
  );

  static final contact = RouteDefinition(
    routePath: RoutePaths.contact,
    component: contact_template.ContactComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    home,
    timetable,
    pricing,
    about,
    contact,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.home.toUrl(),
    ),
  ];
}
