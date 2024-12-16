import 'package:get/get.dart';
import '../controllers/auth_admin_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    print("AuthBinding initialized"); // Debug log
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
