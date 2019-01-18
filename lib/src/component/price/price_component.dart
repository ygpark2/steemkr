import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:steemkr/src/model/post.dart';
import 'package:steemkr/src/service/firebase_service.dart';

@Component(
  selector: 'price',
  styleUrls: [
    'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
    'price_component.css'
  ],
  templateUrl: 'price_component.html',
  directives: [
    MaterialButtonComponent,
    NgFor,
    NgIf,
  ],
)
class PriceComponent implements OnInit {
  final FirebaseService service;
  List<Post> posts = [];

  PriceComponent(this.service);

  @override
  ngOnInit() {
    posts = service.posts;
  }
}
