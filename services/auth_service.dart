import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppUser? currentUser;

  User? get firebaseUser => _auth.currentUser;

  AuthService() {
    _auth.authStateChanges().listen((u) {
      if (u != null) {
        // load user profile from Firestore
        FirestoreService().getUser(u.uid).then((map) {
          if (map != null) {
            currentUser = AppUser.fromMap(map);
            notifyListeners();
          }
        }).catchError((_) {});
      } else {
        currentUser = null;
        notifyListeners();
      }
    });
  }

  Future<UserCredential> signUpWithEmail(String name, String email, String password, String role, String bloodGroup) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = cred.user!;
    // create user in Firestore
    final appUser = AppUser(
      uid: user.uid,
      name: name,
      email: email,
      role: role,
      bloodGroup: bloodGroup,
      available: role == 'donor',
    );
    await FirestoreService().createUser(appUser);
    currentUser = appUser;
    notifyListeners();
    return cred;
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return cred;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    currentUser = null;
    notifyListeners();
  }
}
