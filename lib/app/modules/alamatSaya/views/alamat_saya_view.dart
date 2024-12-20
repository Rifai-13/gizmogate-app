import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/alamat_saya_controller.dart';
import '../../alamat/views/alamat_view.dart';

class AlamatSayaView extends StatelessWidget {
  final AlamatSayaController controller = Get.find(); // Mengakses controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alamat Saya', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Menambahkan icon back
          onPressed: () {
            Get.back(); // Fungsi untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol untuk menambah alamat
              ElevatedButton(
                onPressed: () {
                  // Pindah ke halaman AlamatView
                  Get.to(() => AlamatView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Tambah Alamat'),
              ),
              SizedBox(height: 20),
              // Menampilkan alamat jika sudah disimpan
              Obx(() {
                // Jika nama lengkap kosong, tampilkan pesan
                if (controller.namaLengkap.value.isEmpty) {
                  return Center(
                    child: Text(
                      'Alamat belum disimpan',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }

                // Jika ada data, tampilkan dalam Card
                return Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Pindah ke AlamatView untuk mengedit alamat
                      Get.to(() => AlamatView());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Lengkap: ${controller.namaLengkap.value}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'No Telpon: ${controller.noTelpon.value}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Provinsi: ${controller.provinsi.value}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Kota: ${controller.kota.value}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Kecamatan: ${controller.kecamatan.value}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Kode Pos: ${controller.kodePos.value}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Jalan: ${controller.jalan.value}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              // Menghapus alamat
                              controller.deleteAlamat();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Hapus Alamat'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
