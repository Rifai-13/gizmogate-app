import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gizmogate/app/modules/shope/views/shope_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../transaksi/views/transaksi_view.dart';
import '../../consign/views/consign_view.dart'; // Import view untuk Consign
import '../controllers/navbar_controller.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavbarController controller = Get.put(NavbarController());

    return Obx(() {
      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shope',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Consign', // Tambahkan item baru untuk Consign
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: controller.currentIndex.value,
        selectedItemColor: Colors.black,
        unselectedItemColor:
            Colors.grey, // Menggunakan currentIndex dari controller
        onTap: (index) {
          controller.currentIndex.value = index; // Update currentIndex
          switch (index) {
            case 0:
              Get.off(() => HomeView());
              break;
            case 1:
              Get.off(() => ShopeView());
              break;
            case 2:
              Get.off(() => ConsignView()); // Tambahkan navigasi ke ConsignView
              break;
            case 3:
              Get.off(() => TransaksiView());
              break;
            case 4:
              Get.off(() => ProfileView());
              break;
          }
        },
      );
    });
  }
}
