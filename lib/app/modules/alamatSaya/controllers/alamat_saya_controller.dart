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

  // Ubah alamatList menjadi RxList<Map<String, String>> untuk mengelola alamat lebih detail
  RxList<Map<String, String>> alamatList = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAlamatList();
  }

  // Fungsi untuk menyimpan alamat
  void saveAlamat(Map<String, String> alamat) {
    alamatList.add(alamat);
    box.write('alamatList', alamatList.toList());
  }

  // Fungsi untuk menghapus alamat
  void deleteAlamat(int index) {
    alamatList.removeAt(index); // Menghapus alamat berdasarkan index
    box.write('alamatList', alamatList.toList());
  }

  // Fungsi untuk memuat alamat dari GetStorage
  void loadAlamatList() {
    var savedAlamatList = box.read('alamatList');
    if (savedAlamatList != null) {
      alamatList.assignAll(List<Map<String, String>>.from(savedAlamatList));
    }
  }

  // Fungsi untuk memperbarui alamat berdasarkan index
  void updateAlamat(int index, Map<String, String> updatedAlamat) {
    alamatList[index] = updatedAlamat;
    box.write('alamatList', alamatList.toList());
  }
}
