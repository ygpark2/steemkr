import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:steemkr/src/model/post.dart';
import 'package:steemkr/src/service/firebase_service.dart';

@Component(selector: 'new-post', templateUrl: 'new_component.html', styleUrls: [
  'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
  'new_component.css'
], directives: const [
  coreDirectives,
  formDirectives,
  materialInputDirectives,
  MaterialButtonComponent,
  MaterialIconComponent,
  MaterialInputComponent,
  NgIf,
  NgModel,
])
class PostNewComponent {
  final FirebaseService service;
  Post post = new Post();
  bool fileDisabled = false;

  @ViewChild("submit")
  ElementRef submitButton;

  PostNewComponent(this.service);

  uploadImage(e) async {
    fileDisabled = true;
    var file = (e.target as FileUploadInputElement).files[0];
    var image = await service.postItemImage(file);

    post.imageUrl = image.toString();
  }

  removeImage() {
    service.removeItemImage(post.imageUrl);

    post.imageUrl = null;
    fileDisabled = false;
  }

  submitForm() {
    service.postItem(post);

    submitButton.nativeElement.blur();
    post = new Post();
    fileDisabled = false;
  }
}
