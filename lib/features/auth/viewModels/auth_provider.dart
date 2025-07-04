
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  bool get isLoggedIn => _user != null;

  bool loading = false;

  AuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) async {
      if(_user == null && firebaseUser != null){
        loading = true;
      }

      _user = firebaseUser;

      notifyListeners();
    });
  }

  void finishLoading() {
    loading = false;
    notifyListeners();
  }

  void startLoading() {
    loading = true;
    notifyListeners();
  }
}