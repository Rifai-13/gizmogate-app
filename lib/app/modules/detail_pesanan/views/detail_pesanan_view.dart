import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../transaksi/controllers/transaksi_controller.dart';
import '../../transaksi/models/product.dart';
import '../controllers/detail_pesanan_controller.dart';

class DetailPesananView extends GetView<DetailPesananController> {
  const DetailPesananView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data produk yang dikirimkan melalui Get.arguments
    final item = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Pesanan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme:
            const IconThemeData(color: Colors.white), // Menjadikan arrow putih
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item['image'], // Menggunakan gambar produk yang dipilih
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Nama produk
              Text(
                item['name'], // Menggunakan nama produk yang dipilih
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Deskripsi singkat produk
              Text(
                item['desc'], // Menggunakan deskripsi produk yang dipilih
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              // Harga produk
              Row(
                children: [
                  Text(
                    'Rp ${item['price']}', // Menggunakan harga produk yang dipilih
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  // Kategori produk
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item[
                          'category'], // Menggunakan kategori produk yang dipilih
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Tombol Add to Cart dan Shop Now
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Action untuk Add to Cart
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Menambahkan produk ke transaksi
                        final product = Product(
                          name: item['name'],
                          description: item['desc'],
                          price: item['price'],
                          image: item['image'],
                          category: item['category'],
                          status: "dalamPengiriman", // Status pesanan awal
                        );
                        
                        // Menambahkan produk ke dalam transaksi melalui controller
                        Get.find<TransaksiController>().addProduct(product);
                        
                        // Navigasi ke halaman Transaksi
                        Get.toNamed(Routes.TRANSAKSI, arguments: item);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Shop Now',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
