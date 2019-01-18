import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/content/deferred_content.dart';
import 'package:angular_components/laminate/overlay/zindexer.dart';
import 'package:angular_router/angular_router.dart';
import 'package:steemkr/route_paths.dart';
import 'package:steemkr/routes.dart';
import 'package:steemkr/src/component/layout/footer/footer_component.dart';
import 'package:steemkr/src/component/layout/header/header_component.dart';
import 'package:steemkr/src/service/firebase_service.dart';

@Component(
  selector: 'layout',
  templateUrl: 'layout_component.html',
  styleUrls: [
    'layout_component.css',
  ],
  directives: [
    coreDirectives,
    routerDirectives,
    DeferredContentDirective,
    NgIf,
    HeaderComponent,
    FooterComponent,
  ],
  providers: [popupBindings, ClassProvider(ZIndexer)],
  exports: [RoutePaths, Routes],
)
class LayoutComponent {
  final FirebaseService service;
  LayoutComponent(this.service);
}
