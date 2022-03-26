import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SocioutFirebaseUser {
  SocioutFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

SocioutFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SocioutFirebaseUser> socioutFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<SocioutFirebaseUser>(
        (user) => currentUser = SocioutFirebaseUser(user));
