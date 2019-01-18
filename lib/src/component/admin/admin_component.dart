import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:steemkr/route_paths.dart';
import 'package:steemkr/routes.dart';
import 'package:steemkr/src/component/post/list/posts_component.dart';
import 'package:steemkr/src/component/post/new/new_component.dart';
import 'package:steemkr/src/service/firebase_service.dart';

@Component(
  selector: 'admin',
  templateUrl: 'admin_component.html',
  styleUrls: [
    'admin_component.css',
  ],
  directives: [
    coreDirectives,
    routerDirectives,
    MaterialButtonComponent,
    MaterialInputComponent,
    NgIf,
    PostNewComponent,
    PostListComponent,
  ],
  exports: [RoutePaths, Routes],
)
class AdminComponent implements OnInit {
  final FirebaseService service;
  AdminComponent(this.service);

  @override
  ngOnInit() {
    service.init();
  }
}
