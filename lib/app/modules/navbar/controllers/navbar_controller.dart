import 'package:get/get.dart';

class NavbarController extends GetxController {
  final currentIndex = 0.obs; // Menyimpan indeks navbar aktif

  // void changeIndex(int index) {
  //   currentIndex.value = index;
  // }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
