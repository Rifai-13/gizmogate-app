import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileImage = Rx<File?>(null);
  var email = ''.obs; // Untuk menyimpan email
  var username = ''.obs; // Untuk menyimpan username

  // Fungsi untuk mengupdate email dari login
  void setEmail(String userEmail) {
    email.value = userEmail;
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  void deleteImage() {
    profileImage.value = null;
  }

  void updateUsername(String newUsername) {
    username.value = newUsername;
  }
void updateEmail(String newEmail) {
  email.value = newEmail;
}
}
