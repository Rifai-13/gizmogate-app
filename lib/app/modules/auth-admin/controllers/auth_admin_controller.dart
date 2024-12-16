import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var isLoggedIn = false.obs; // Status login pengguna

  AuthController() {
    print("AuthController initialized"); // Debug log
  }

  // Login
  Future<void> login(String email, String password) async {
    try {
      // Sign in dengan Firebase
      await auth.signInWithEmailAndPassword(email: email, password: password);

      // Update status login
      isLoggedIn.value = true;

      // Tampilkan snackbar sukses
      Get.snackbar(
        'Success',
        'Login successful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );

      // Navigasi ke halaman admin profile view
      Get.offAllNamed(
          '/admin-profile'); // Pastikan ini sesuai dengan route di app_pages.dart
    } on FirebaseAuthException catch (e) {
      // Handle error FirebaseAuth
      switch (e.code) {
        case 'user-not-found':
          _showErrorSnackbar('No user found with this email.');
          break;
        case 'wrong-password':
          _showErrorSnackbar('The password you entered is incorrect.');
          break;
        default:
          _showErrorSnackbar(e.message ?? 'An unknown error occurred.');
      }
    }
  }

  // Fungsi untuk logout
  Future<void> logout() async {
    try {
      await auth.signOut();
      isLoggedIn.value = false; // Reset status login

      // Navigasi ke halaman login
      Get.offAllNamed('/auth'); // Ganti dengan nama route yang sesuai
    } catch (e) {
      // Menangani error logout
      Get.snackbar(
        'Error',
        'Failed to logout. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  // Helper untuk menampilkan error snackbar
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
}
