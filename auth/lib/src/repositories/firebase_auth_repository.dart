import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_repository.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ??
            GoogleSignIn(
              scopes: [
                'email',
                // 'https://www.googleapis.com/auth/contacts.readonly',
              ],
            );

  Future<User> signInAnonymously() async {
    // Sign in to Firebase Anonymously.
    await _firebaseAuth.signInAnonymously();
    // Return current user
    return _firebaseAuth.currentUser;
  }

  Future<User> signInWithGoogle() async {
    // Trigger the Google Authentication flow.
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    // Obtain the auth details from the request.
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential.
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in to Firebase with the Google [UserCredential].
    await _firebaseAuth.signInWithCredential(credential);
    // Return current user
    return _firebaseAuth.currentUser;
  }

  Future<void> signInWithCredentials(String email, String password) async {
    await _firebaseAuth.setPersistence(Persistence.LOCAL);
    _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      if (_googleSignIn.clientId != null) _googleSignIn.signOut(),
    ]);
  }

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> updateProfile({
    String displayName,
    String photoURL,
    String email,
    String password,
    PhoneAuthCredential phoneCredential,
  }) async {
    //
    if (displayName != null || photoURL != null) {
      _firebaseAuth.currentUser.updateProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
    }

    //
    if (email != null) {
      _firebaseAuth.currentUser.updateEmail(email);
    }

    //
    if (password != null) {
      _firebaseAuth.currentUser.updatePassword(password);
    }

    //
    if (phoneCredential != null) {
      _firebaseAuth.currentUser.updatePhoneNumber(phoneCredential);
    }
  }
}
