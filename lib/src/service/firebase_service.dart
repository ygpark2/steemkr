import 'dart:html';

import 'package:firebase/firebase.dart' as fb;
import 'package:steemkr/src/model/post.dart';

class FirebaseService {
  final fb.Auth auth;
  final fb.DatabaseReference databaseRef;
  final fb.StorageReference storageRef;
  final List<Post> posts = [];
  fb.User user;
  bool loading = true;

  FirebaseService()
      : auth = fb.auth(),
        databaseRef = fb.database().ref("startup-names"),
        storageRef = fb.storage().ref("startup-names");

  init() {
    databaseRef.onChildAdded.listen((e) {
      // Snapshot of the data.
      fb.DataSnapshot data = e.snapshot;

      // Value of data from snapshot.
      var val = data.val();
      // Creates a new Note item. It is possible to retrieve a key from data.
      var item = new Post(val[jsonTagFirst], val[jsonTagSecond],
          val[jsonTagDescription], val[jsonTagImgUrl], data.key);
      posts.insert(0, item);
    });

    // Setups listening on the child_removed event on the database ref.
    databaseRef.onChildRemoved.listen((e) {
      fb.DataSnapshot data = e.snapshot;
      var val = data.val();

      // Removes also the image from storage.
      var imageUrl = val[jsonTagImgUrl];
      if (imageUrl != null) {
        removeItemImage(imageUrl);
      }
      posts.removeWhere((n) => n.key == data.key);
    });

    // Sets loading to true when path changes
    databaseRef.onValue.listen((e) {
      loading = false;
    });

    // Sets user when auth state changes
    auth.onIdTokenChanged.listen((e) {
      user = e;
    });
  }

  // Pushes a new item as a Map to database.
  postItem(Post item) async {
    try {
      await databaseRef.push(Post.toMap(item)).future;
    } catch (e) {
      print("Error in writing to database: $e");
    }
  }

  // Removes item with a key from database.
  removeItem(String key) async {
    try {
      await databaseRef.child(key).remove();
    } catch (e) {
      print("Error in deleting $key: $e");
    }
  }

  // Puts image into a storage.
  postItemImage(File file) async {
    try {
      var task = storageRef.child(file.name).put(file);
      task.onStateChanged
          .listen((_) => loading = true, onDone: () => loading = false);

      var snapshot = await task.future;
      return snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error in uploading to storage: $e");
    }
  }

  // Removes image with an imageUrl from the storage.
  removeItemImage(String imageUrl) async {
    try {
      var imageRef = fb.storage().refFromURL(imageUrl);
      await imageRef.delete();
    } catch (e) {
      print("Error in deleting $imageUrl: $e");
    }
  }

  // Signs in with the Google auth provider.
  signInWithGoogle() async {
    var provider = new fb.GoogleAuthProvider();
    try {
      await auth.signInWithPopup(provider);
    } catch (e) {
      print("Error in sign in with Google: $e");
    }
  }

  signOut() async {
    await auth.signOut();
  }
}
