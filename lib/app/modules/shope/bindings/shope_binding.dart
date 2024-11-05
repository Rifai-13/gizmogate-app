import 'package:get/get.dart';

import '../controllers/shope_controller.dart';

class ShopeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopeController>(
      () => ShopeController(),
    );
  }
}
