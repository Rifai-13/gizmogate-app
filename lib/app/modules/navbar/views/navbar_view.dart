import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gizmogate/app/modules/admin-profile/views/admin_profile_view.dart';
import 'package:gizmogate/app/modules/shope/views/shope_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../transaksi/views/transaksi_view.dart';
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
            icon: Icon(Icons.shopping_cart),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
        currentIndex: controller.currentIndex.value,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          controller.currentIndex.value = index; // Update currentIndex

          // Pop all previous pages and push the new page with smooth transition
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                _createRoute(HomeView()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                _createRoute(ShopeView()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                _createRoute(TransaksiView()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                _createRoute(ProfileView()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                _createRoute(AdminView()),
              );
              break;
          }
        },
      );
    });
  }

  // Function to create smooth transitions using FadeTransition with a specified duration
  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(
          milliseconds: 700), // Set the transition duration to 300ms
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Fade transition for smooth fade-in and fade-out effect
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
