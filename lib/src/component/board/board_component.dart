import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:steemkr/route_paths.dart';
import 'package:steemkr/routes.dart';
import 'package:steemkr/src/component/post/list/posts_component.dart';
import 'package:steemkr/src/component/post/new/new_component.dart';
import 'package:steemkr/src/service/firebase_service.dart';

@Component(
  selector: 'board',
  templateUrl: 'board_component.html',
  styleUrls: [
    'board_component.css',
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
class BoardComponent implements OnInit {
  final FirebaseService service;

  BoardComponent(this.service);

  @override
  ngOnInit() {
    service.init();
  }
}
