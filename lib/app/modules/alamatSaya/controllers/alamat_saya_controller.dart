import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AlamatSayaController extends GetxController {
  var box = GetStorage();

  RxString namaLengkap = ''.obs;
  RxString noTelpon = ''.obs;
  RxString provinsi = ''.obs;
  RxString kota = ''.obs;
  RxString kecamatan = ''.obs;
  RxString kodePos = ''.obs;
  RxString jalan = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Membaca data dari GetStorage
    if (box.read('namaLengkap') != null) {
      namaLengkap.value = box.read('namaLengkap');
      noTelpon.value = box.read('noTelpon');
      provinsi.value = box.read('provinsi');
      kota.value = box.read('kota');
      kecamatan.value = box.read('kecamatan');
      kodePos.value = box.read('kodePos');
      jalan.value = box.read('jalan');
    }
  }

  // Fungsi untuk menghapus alamat
  void deleteAlamat() {
    box.remove('namaLengkap');
    box.remove('noTelpon');
    box.remove('provinsi');
    box.remove('kota');
    box.remove('kecamatan');
    box.remove('kodePos');
    box.remove('jalan');
    namaLengkap.value = '';
    noTelpon.value = '';
    provinsi.value = '';
    kota.value = '';
    kecamatan.value = '';
    kodePos.value = '';
    jalan.value = '';
  }
}
