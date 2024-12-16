import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:gizmogate/firebase_options.dart';
import 'app/modules/auth-admin/controllers/auth_admin_controller.dart';
import 'app/modules/shope/controllers/shope_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi AuthController
  Get.put(AuthController());

  // Inisialisasi ShopeController
  Get.put(
      ShopeController()); // Tambahkan ini untuk menginisialisasi ShopeController

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
