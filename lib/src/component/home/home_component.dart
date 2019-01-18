import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:steemkr/route_paths.dart';
import 'package:steemkr/routes.dart';
import 'package:steemkr/src/service/firebase_service.dart';

@Component(
  selector: 'home',
  styleUrls: [
    'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
    'home_component.css'
  ],
  templateUrl: 'home_component.html',
  directives: [
    coreDirectives,
    routerDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialListComponent,
    MaterialListItemComponent,
    MaterialButtonComponent,
    MaterialIconComponent,
    MaterialChipComponent,
    MaterialChipsComponent,
    NgIf,
  ],
  exports: [RoutePaths, Routes],
)
class HomeComponent {
  final FirebaseService service;

  HomeComponent(this.service);
}
