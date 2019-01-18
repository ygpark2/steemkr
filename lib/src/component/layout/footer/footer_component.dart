import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'footer',
  templateUrl: 'footer_component.html',
  styleUrls: [
    'footer_component.css',
  ],
  directives: [
    formDirectives,
    materialInputDirectives,
    MaterialButtonComponent,
    MaterialListComponent,
    MaterialListItemComponent,
  ],
)
class FooterComponent {}
