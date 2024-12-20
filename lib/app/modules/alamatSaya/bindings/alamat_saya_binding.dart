import 'package:get/get.dart';
import '../controllers/alamat_saya_controller.dart';

class AlamatSayaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlamatSayaController>(() => AlamatSayaController());
  }
}
