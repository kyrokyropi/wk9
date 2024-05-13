import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';
import 'package:wk9/models/name_model.dart';

class MyAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;

  MyAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;

  void fetchAuthentication() {
    uStream = authService.getUser();
    notifyListeners();
  }

  Future<void> signUp(FullName fullname, String email, String password) async {
    try {
      await authService.signUp(fullname.toJson(fullname), email, password);
    } catch (e) {
      // Optionally handle any exceptions specific to sign-up
      rethrow;  // Rethrow to handle further up the call stack if necessary
    }
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await authService.signIn(email, password);
    } catch (e) {
      // Log the error or handle it as needed
      print("Sign-in failed: ${e.toString()}");
      throw Exception('Login failed due to incorrect credentials.');
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      await authService.signOut();
    } catch (e) {
      // Handle sign out errors here
      print("Sign-out error: ${e.toString()}");
      rethrow;
    }
    notifyListeners();
  }
}