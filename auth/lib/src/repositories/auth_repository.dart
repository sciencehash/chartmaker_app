import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepository {
  AuthRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin});

  Future<User> signInAnonymously();

  Future<User> signInWithGoogle();

  Future<void> signInWithCredentials(String email, String password);

  Future<void> signUp({String email, String password});

  Future<void> signOut();

  bool isSignedIn();

  User getUser();

  Future<void> updateProfile({
    String displayName,
    String email,
    String password,
    String photoURL,
    PhoneAuthCredential phoneCredential,
  });
}
