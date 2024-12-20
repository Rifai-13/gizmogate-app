import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../alamatSaya/views/alamat_saya_view.dart';

class AlamatController extends GetxController {
  final box = GetStorage();

  var namaLengkap = ''.obs;
  var noTelpon = ''.obs;
  var provinsi = ''.obs;
  var kota = ''.obs;
  var kecamatan = ''.obs;
  var kodePos = ''.obs;
  var jalan = ''.obs;

  var isEditable = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize GetStorage and load stored data
    GetStorage.init().then((_) {
      namaLengkap.value = box.read('namaLengkap') ?? '';
      noTelpon.value = box.read('noTelpon') ?? '';
      provinsi.value = box.read('provinsi') ?? '';
      kota.value = box.read('kota') ?? '';
      kecamatan.value = box.read('kecamatan') ?? '';
      kodePos.value = box.read('kodePos') ?? '';
      jalan.value = box.read('jalan') ?? '';
    });
  }

  void saveAlamat() {
    if (namaLengkap.value.isEmpty ||
        noTelpon.value.isEmpty ||
        provinsi.value.isEmpty ||
        kota.value.isEmpty ||
        kecamatan.value.isEmpty ||
        kodePos.value.isEmpty ||
        jalan.value.isEmpty) {
      Get.snackbar('Error', 'Semua kolom harus diisi',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Save address data to GetStorage
    box.write('namaLengkap', namaLengkap.value);
    box.write('noTelpon', noTelpon.value);
    box.write('provinsi', provinsi.value);
    box.write('kota', kota.value);
    box.write('kecamatan', kecamatan.value);
    box.write('kodePos', kodePos.value);
    box.write('jalan', jalan.value);

    // Log data to check if it's saved correctly
    print(
        'Alamat saved: ${namaLengkap.value}, ${noTelpon.value}, ${provinsi.value}');

    Get.snackbar('Success', 'Alamat berhasil disimpan',
        backgroundColor: Colors.green, colorText: Colors.white);

    // Navigate to AlamatSayaView
    Get.offAll(() => AlamatSayaView());
  }

  void clearFields() {
    namaLengkap.value = '';
    noTelpon.value = '';
    provinsi.value = '';
    kota.value = '';
    kecamatan.value = '';
    kodePos.value = '';
    jalan.value = '';
  }

  void deleteAlamat() {
    box.remove('namaLengkap');
    box.remove('noTelpon');
    box.remove('provinsi');
    box.remove('kota');
    box.remove('kecamatan');
    box.remove('kodePos');
    box.remove('jalan');

    clearFields();
    isEditable.value = true;

    Get.snackbar('Success', 'Alamat berhasil dihapus',
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void editAlamat() {
    isEditable.value = true;
  }
}
