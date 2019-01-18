import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:firebase/firebase.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:service_worker/window.dart' as sw;
import 'package:steemkr/app_component.template.dart' as ng;
import 'package:steemkr/src/component/utils/angular_google_maps/angular_google_maps.dart';

import 'main.template.dart' as self;

@GenerateInjector([
  routerProvidersHash, // You can use routerProviders in production
  ClassProvider(Client, useClass: BrowserClient),
])
final InjectorFactory injector = self.injector$Injector;

void main() async {
  initializeApp(
      apiKey: "AIzaSyBOShlCgUeqTL99n32bjWdNlkH1RPk9Xx4",
      authDomain: "your-next-startup.firebaseapp.com",
      databaseURL: "https://your-next-startup.firebaseio.com",
      projectId: "your-next-startup",
      storageBucket: "your-next-startup.appspot.com",
      messagingSenderId: "52475561792");

  if (sw.isSupported) {
    sw.register('sw.dart.js');
  } else {
    print('ServiceWorkers are not supported.');
  }

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  await loadGoogleMaps("AIzaSyD4oLA0MnEVI81A1igJ50STlccOQW-5yg0");
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
