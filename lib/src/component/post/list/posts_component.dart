import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:steemkr/src/model/post.dart';
import 'package:steemkr/src/service/firebase_service.dart';

@Component(selector: 'posts', templateUrl: 'posts_component.html', styleUrls: [
  'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
  'posts_component.css'
], directives: const [
  coreDirectives,
  MaterialButtonComponent,
  MaterialIconComponent,
  NgIf,
])
class PostListComponent implements OnInit {
  final FirebaseService service;
  List<Post> posts = [];

  PostListComponent(this.service);

  @override
  ngOnInit() {
    posts = service.posts;
  }
}
