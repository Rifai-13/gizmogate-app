// AlamatSayaView
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gizmogate/app/modules/alamat/views/alamat_view.dart';
import '../controllers/alamat_saya_controller.dart';

class AlamatSayaView extends StatelessWidget {
  final AlamatSayaController controller = Get.find(); // Mengakses controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alamat Saya', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
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
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke AlamatView untuk menambah alamat baru
                  Get.to(() => AlamatView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Tambah Alamat'),
              ),
              SizedBox(height: 20),
              Obx(() {
                if (controller.alamatList.isEmpty) {
                  return Center(
                    child: Text(
                      'Alamat belum disimpan',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.alamatList.length,
                    itemBuilder: (context, index) {
                      var alamat = controller.alamatList[index];
                      return Card(
                        color: Colors.grey[800],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            // Navigasi ke AlamatView untuk melihat/edit alamat
                            Get.to(() => AlamatView(alamat: alamat, index: index));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: Colors.blue, size: 24),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Alamat ${index + 1}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.yellow),
                                      onPressed: () {
                                        // Arahkan ke halaman edit dengan membawa data alamat yang akan diedit
                                        Get.to(() => AlamatView(alamat: alamat, index: index));
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text('Nama Lengkap: ${alamat['namaLengkap']}', style: TextStyle(color: Colors.white70)),
                                Text('No Telpon: ${alamat['noTelpon']}', style: TextStyle(color: Colors.white70)),
                                Text('Provinsi: ${alamat['provinsi']}', style: TextStyle(color: Colors.white70)),
                                Text('Kota: ${alamat['kota']}', style: TextStyle(color: Colors.white70)),
                                Text('Kecamatan: ${alamat['kecamatan']}', style: TextStyle(color: Colors.white70)),
                                Text('Kode Pos: ${alamat['kodePos']}', style: TextStyle(color: Colors.white70)),
                                Text('Jalan: ${alamat['jalan']}', style: TextStyle(color: Colors.white70)),
                                SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.deleteAlamat(index); // Hapus alamat jika diperlukan
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
                    },
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
