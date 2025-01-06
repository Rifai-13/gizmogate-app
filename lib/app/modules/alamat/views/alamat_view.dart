import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/alamat_controller.dart';

class AlamatView extends StatelessWidget {
  final AlamatController controller = Get.find();
  final Map<String, String>? alamat;
  final int? index;

  AlamatView({this.alamat, this.index});

  @override
  Widget build(BuildContext context) {
    // Jika index tidak null, kita akan mengisi form dengan alamat yang ada
    if (index != null && alamat != null) {
      controller.namaLengkap.value = alamat!['namaLengkap'] ?? '';
      controller.noTelpon.value = alamat!['noTelpon'] ?? '';
      controller.provinsi.value = alamat!['provinsi'] ?? '';
      controller.kota.value = alamat!['kota'] ?? '';
      controller.kecamatan.value = alamat!['kecamatan'] ?? '';
      controller.kodePos.value = alamat!['kodePos'] ?? '';
      controller.jalan.value = alamat!['jalan'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Alamat', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildForm(),
              SizedBox(height: 20),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildTextField('Nama Lengkap', controller.namaLengkap),
        _buildTextField('No Telpon', controller.noTelpon),
        _buildTextField('Provinsi', controller.provinsi),
        _buildTextField('Kota', controller.kota),
        _buildTextField('Kecamatan', controller.kecamatan),
        _buildTextField('Kode Pos', controller.kodePos),
        _buildTextField('Jalan', controller.jalan),
      ],
    );
  }

  Widget _buildTextField(String label, RxString controllerValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(() {
        return TextField(
          onChanged: (value) {
            if (controller.isEditable.value) {
              controllerValue.value = value;
            }
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey[300]),
            hintText: 'Masukkan $label',
            hintStyle: TextStyle(color: Colors.grey[600]),
            filled: true,
            fillColor: Colors.grey[800],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
          ),
          enabled: controller.isEditable.value,
        );
      }),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Panggil fungsi saveAlamat di controller untuk menangani logika simpan atau update
            controller.saveAlamat(index);
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          icon: Icon(Icons.save, color: Colors.white),
          label: Text('Simpan', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
