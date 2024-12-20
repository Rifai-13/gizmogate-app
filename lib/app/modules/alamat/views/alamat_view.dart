import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/alamat_controller.dart';

class AlamatView extends StatelessWidget {
  final AlamatController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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
              _buildHeader(),
              SizedBox(height: 20),
              _buildForm(),
              SizedBox(height: 20),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // Header dengan ikon dan deskripsi
  Widget _buildHeader() {
    return Card(
      color: Colors.grey[800],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.home, size: 40, color: Colors.blue),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isi dan Simpan Alamat Anda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pastikan data yang Anda masukkan lengkap dan benar.',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Form input
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

  // Input field dengan gaya modern
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

  // Tombol aksi dengan gaya modern
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          onPressed: () => controller.saveAlamat(),
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
        ElevatedButton.icon(
          onPressed: () => controller.editAlamat(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          icon: Icon(Icons.edit, color: Colors.white),
          label: Text('Edit', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton.icon(
          onPressed: () => controller.deleteAlamat(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          icon: Icon(Icons.delete, color: Colors.white),
          label: Text('Hapus', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
