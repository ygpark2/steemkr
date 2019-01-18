import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:steemkr/src/model/post.dart';
import 'package:steemkr/src/service/firebase_service.dart';

@Component(
  selector: 'about',
  styleUrls: [
    'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
    'about_component.css'
  ],
  templateUrl: 'about_component.html',
  directives: [
    MaterialButtonComponent,
    MaterialIconComponent,
    NgFor,
    NgIf,
  ],
)
class AboutComponent implements OnInit {
  final FirebaseService service;
  List<Post> posts = [];

  AboutComponent(this.service);

  @override
  ngOnInit() {
    posts = service.posts;
  }
}
