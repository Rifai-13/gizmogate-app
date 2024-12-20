import 'package:get/get.dart';

import '../controllers/alamat_controller.dart';

class AlamatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlamatController>(
      () => AlamatController(),
    );
  }
}
