import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gizmogate/app/modules/alamat/controllers/alamat_controller.dart';
import 'package:gizmogate/app/modules/alamatSaya/controllers/alamat_saya_controller.dart';
import 'package:gizmogate/app/modules/transaksi/controllers/transaksi_controller.dart';
import 'package:gizmogate/firebase_options.dart';
import 'app/modules/auth-admin/controllers/auth_admin_controller.dart';
import 'app/modules/shope/controllers/shope_controller.dart';
import 'app/modules/transaksi/controllers/order_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());
  Get.put(ShopeController());
  Get.put(TransaksiController());
  Get.put(AlamatController());
  Get.put(AlamatSayaController());
  Get.put(OrderController());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
