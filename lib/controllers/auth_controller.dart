import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final FirebaseAuth _authService = FirebaseAuth.instance;
  late final Rx<User?> _user;
  final Rx<bool> _isLoading = false.obs;

  bool get isLoggedIn => _user.value != null;
  User? get user => _user.value;

  Rx<bool> get isLoading => _isLoading;
  String? get userName => user?.displayName;
  String? get photoUrl => user?.photoURL;

  @override
  void onReady() {
    super.onReady();

    _user = _authService.currentUser.obs;

    _user.bindStream(_authService.userChanges());
    ever(_user, _initialScreen);
  }

  void _initialScreen(User? user) {
    if (user != null) {
      Get.offAllNamed('/');
    } else {
      Get.offAllNamed('/login');
    }
  }

  /// sign-in user using its [email] and [password]
  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    await _authService
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (userCredential) {
        _showToast(
          'Success',
          'Welcome ${userCredential.user?.displayName}, To our world!',
          false,
        );
      },
    ).onError<FirebaseAuthException>(
      (error, stackTrace) {
        const String title = 'Login Failed!';
        switch (error.code) {
          case 'invalid-email':
            _showToast(
              title,
              'Invalid email or wrong password!',
            );

            break;
          case 'user-disabled':
            _showToast(
              title,
              'User disabled, communicate with the support',
            );

            break;
          case 'user-not-found':
            _showToast(
              title,
              'Invalid email or wrong password!',
            );

            break;
          case 'wrong-password':
            _showToast(
              title,
              'Invalid email or wrong password!',
            );

            break;
          default:
            _showToast(
              title,
              'Something went wrong!',
            );

            print(error);

            break;
        }
      },
    ).whenComplete(() {
      print('completed');
      isLoading.value = false;
    });
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    await _authService
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (userCredentials) {
        userCredentials.user?.updateDisplayName(username);
        _showToast('Success', 'Account created successfully', false);
      },
    ).onError<FirebaseAuthException>(
      (error, stackTrace) {
        const String title = 'Failed to create account';
        switch (error.code) {
          case 'email-already-in-use':
            _showToast(title, 'Email already in use');
            break;
          case 'invalid-email':
            _showToast(title, 'Invalid email');
            break;
          case 'operation-not-allowed':
            _showToast(
              title,
              'Account creation not allowed. Please contact the administrator',
            );
            break;
          case 'weak-password':
            _showToast(
              'Weak password',
              'Password should be at least 6 characters long.',
            );

            break;
        }
      },
    ).whenComplete(() => isLoading.value = false);
  }

  /// show Get snackbar with [message] and [title]
  void _showToast(String title, String message, [bool isError = true]) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 4),
    );
  }

  /// sign-out user
  Future<void> signOut() => _authService.signOut();
}
