// register_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isLoading = false.obs;
  var obscurePassword = true.obs; // This variable controls password visibility

  // Fungsi untuk registrasi
  Future<void> signUp() async {
    isLoading.value = true; // Mengatur status loading ke true

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Simpan data pengguna di Firestore
      await _saveUserData(userCredential.user!.uid,
          usernameController.text.trim(), emailController.text.trim());

      if (userCredential.user != null) {
        Get.snackbar("Success", "Account created successfully");
        Get.offAllNamed('/login'); // Navigasi ke halaman login
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message = "An error occurred: ${e.message}";
      }
      Get.snackbar("Registration Failed", message,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Mengatur status loading ke false
    }
  }

  // Fungsi terpisah untuk menyimpan data pengguna
  Future<void> _saveUserData(String uid, String username, String email) async {
    await _firestore.collection('users').doc(uid).set({
      'username': username,
      'email': email,
    });
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
