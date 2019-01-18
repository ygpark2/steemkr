import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:steemkr/route_paths.dart';
import 'package:steemkr/routes.dart';

@Component(
  selector: 'header',
  templateUrl: 'header_component.html',
  styleUrls: [
    'header_component.css',
    'package:angular_components/app_layout/layout.scss.css',
  ],
  directives: [
    routerDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialButtonComponent,
    MaterialListComponent,
    MaterialListItemComponent,
    MaterialPersistentDrawerDirective,
  ],
  exports: [RoutePaths],
)
class HeaderComponent {}
