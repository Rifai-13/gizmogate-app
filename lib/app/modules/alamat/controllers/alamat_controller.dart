import 'package:get/get.dart';

class AlamatController extends GetxController {
  RxString namaLengkap = ''.obs;
  RxString noTelpon = ''.obs;
  RxString provinsi = ''.obs;
  RxString kota = ''.obs;
  RxString kecamatan = ''.obs;
  RxString kodePos = ''.obs;
  RxString jalan = ''.obs;
  RxBool isEditable = true.obs;

  // Fungsi untuk menyimpan atau mengupdate alamat
  void saveAlamat(int? index) {
    final alamatBaru = {
      'namaLengkap': namaLengkap.value,
      'noTelpon': noTelpon.value,
      'provinsi': provinsi.value,
      'kota': kota.value,
      'kecamatan': kecamatan.value,
      'kodePos': kodePos.value,
      'jalan': jalan.value,
    };

    if (index != null) {
      // Update alamat jika sudah ada index
      updateAlamat(index, alamatBaru);
    } else {
      // Simpan alamat baru
      addAlamat(alamatBaru);
    }
  }

  // Fungsi untuk menambah alamat baru
  void addAlamat(Map<String, String> alamat) {
    // Tambah alamat baru ke daftar
    print("Alamat baru ditambah: $alamat");
  }

  // Fungsi untuk mengupdate alamat yang sudah ada
  void updateAlamat(int index, Map<String, String> alamat) {
    // Update alamat berdasarkan index
    print("Alamat diupdate pada index $index: $alamat");
  }
}
