import 'package:get/get.dart';

import '../controllers/consign_controller.dart';

class ConsignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsignController>(
      () => ConsignController(),
    );
  }
}
