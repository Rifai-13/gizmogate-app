import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Product {
  String name;
  double price;
  String description;
  int stock;
  String? imagePath;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
    this.imagePath,
  });
}

class ConsignController extends GetxController {
  // Menggunakan RxList agar bisa dipantau dengan Obx
  var products = <Product>[].obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  // Fungsi untuk memuat data awal
  void fetchInitialData() {
    products.assignAll([
      Product(
          name: 'Produk A',
          price: 100.0,
          description: 'Deskripsi A',
          stock: 10,
          imagePath: null),
      Product(
          name: 'Produk B',
          price: 200.0,
          description: 'Deskripsi B',
          stock: 20,
          imagePath: null),
    ]);
  }

  // Fungsi untuk memformat angka stok
  String formatStock(int stock) {
    final formatter = NumberFormat.decimalPattern(); // Format ribuan
    return formatter.format(stock);
  }

  // Fungsi untuk memilih gambar produk
  Future<void> pickImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      products[index].imagePath = image.path; // Update imagePath produk
      products.refresh(); // Segarkan produk untuk memperbarui UI
    }
  }

  // Fungsi untuk menambah produk
  void addProduct(Product product) {
    products.add(product);
  }

  // Fungsi untuk menghapus produk
  void removeProduct(Product product) {
    products.remove(product);
  }

  // Fungsi untuk memperbarui produk
  void updateProduct(int index, Product updatedProduct) {
    products[index] = updatedProduct;
    products.refresh(); // Segarkan produk untuk memperbarui UI
  }
}
