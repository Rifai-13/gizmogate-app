import 'package:get/get.dart';

class OrderController extends GetxController {
  // Status pesanan sebagai observable
  var orderStatus = "".obs;

  // Fungsi untuk memperbarui status pesanan
  void updateOrderStatus(String status) {
    orderStatus.value = status;
  }
}
