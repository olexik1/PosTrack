import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mail_tracking_service/services/auth_repository.dart';
import 'dart:async';

class AppAuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  User? _user;
  bool _isLoading = false;
  late final StreamSubscription<User?> _userSubscription;

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;

  AppAuthProvider(this._authRepository) {
    _user = _authRepository.currentUser;

    _userSubscription = _authRepository.userChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authRepository.signUp(email: email, password: password, name: name);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authRepository.signIn(email: email, password: password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authRepository.changePassword(currentPassword: currentPassword,
          newPassword: newPassword);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  Future<void> updatePhoto({String? photoUrl}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authRepository.updatePhoto(photoUrl: photoUrl);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateName({required String name}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authRepository.updateName(name: name);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendPasswordReset({required String email}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authRepository.sendPasswordReset(email: email);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}