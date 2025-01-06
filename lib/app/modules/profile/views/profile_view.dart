import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gizmogate/app/modules/alamatSaya/views/alamat_saya_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../alamat/views/alamat_view.dart';
import '../../navbar/views/navbar_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  // Fetch the current user's email from Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Get the logged-in user's email
    String email = _auth.currentUser?.email ?? 'Email@gmail.com';

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showImageOptions(context),
                      child: Obx(() {
                        return CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: controller.profileImage.value != null
                              ? FileImage(controller.profileImage.value!)
                              : null,
                          child: controller.profileImage.value == null
                              ? Icon(Icons.person, size: 40, color: Colors.grey)
                              : null,
                        );
                      }),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Obx(() => Text(
                                  controller.username.value.isNotEmpty
                                      ? controller.username.value
                                      : 'User Name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                            IconButton(
                              icon: Icon(Icons.edit,
                                  color: Colors.white, size: 16),
                              onPressed: () => _editUsername(context),
                            ),
                          ],
                        ),
                        // Display email dynamically from Firebase user
                        Text(
                          email,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Saldo: Rp1.000.000.000',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'DAFTAR TRANSAKSI',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text('Alamat', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: () {
                    // Navigate to AlamatView when "Alamat" is tapped
                    Get.to(() => AlamatSayaView());
                  },
                ),
                ListTile(
                  title: Text('Dalam Pengiriman',
                      style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
                ListTile(
                  title:
                      Text('Pembelian', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'LAINNYA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title:
                      Text('Wishlist', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
                SizedBox(height: 20),
                // Replaced 'New Upload' section with Gizmogate logo text
                Center(
                  child: Text(
                    'Gizmogate',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavbarView(),
    );
  }

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.white),
                title: Text('Ambil dari Kamera',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.white),
                title: Text('Pilih dari Galeri',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              if (controller.profileImage.value != null)
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title:
                      Text('Hapus Gambar', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    controller.deleteImage();
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _editUsername(BuildContext context) {
    TextEditingController usernameEditingController = TextEditingController();
    usernameEditingController.text = controller.username.value;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Edit Username', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: usernameEditingController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter new username',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String newUsername = usernameEditingController.text.trim();
                if (newUsername.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Username tidak boleh kosong',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }
                controller.updateUsername(newUsername);
                Get.snackbar(
                  'Success',
                  'Username berhasil diperbarui',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
                Navigator.pop(context);
              },
              child: Text('Save', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
