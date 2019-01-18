import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:steemkr/src/model/post.dart';
import 'package:steemkr/src/service/firebase_service.dart';

@Component(
  selector: 'name',
  styleUrls: [
    'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
    'name_component.css'
  ],
  templateUrl: 'name_component.html',
  directives: [
    MaterialButtonComponent,
    NgFor,
    NgIf,
  ],
)
class NameComponent implements OnInit {
  final FirebaseService service;
  List<Post> posts = [];

  NameComponent(this.service);

  @override
  ngOnInit() {
    posts = service.posts;
  }
}
