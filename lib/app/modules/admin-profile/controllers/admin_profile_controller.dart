import 'package:get/get.dart';

class AdminController extends GetxController {
  var userName = 'Admin'.obs;

  void updateUserName(String name) {
    userName.value = name;
  }
}
