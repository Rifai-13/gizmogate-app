import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Import kIsWeb
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // Import NumberFormat
import '../../navbar/views/navbar_view.dart';
import '../controllers/consign_controller.dart';

class ConsignView extends StatelessWidget {
  final ConsignController consignController = Get.put(ConsignController());

  // Helper function to format numbers to Indonesian currency (Rp)
  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consign',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Tombol untuk menambah produk baru
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController nameController =
                              TextEditingController();
                          TextEditingController priceController =
                              TextEditingController();
                          TextEditingController descriptionController =
                              TextEditingController();
                          TextEditingController stockController =
                              TextEditingController();

                          return AlertDialog(
                            title: const Text('Tambah Produk',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                        labelText: 'Nama Produk',
                                        border: OutlineInputBorder())),
                                const SizedBox(height: 10),
                                TextField(
                                    controller: priceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Harga Produk',
                                        border: OutlineInputBorder())),
                                const SizedBox(height: 10),
                                TextField(
                                    controller: descriptionController,
                                    decoration: const InputDecoration(
                                        labelText: 'Deskripsi Produk',
                                        border: OutlineInputBorder())),
                                const SizedBox(height: 10),
                                TextField(
                                    controller: stockController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Stok Produk',
                                        border: OutlineInputBorder())),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (nameController.text.isNotEmpty &&
                                      priceController.text.isNotEmpty &&
                                      descriptionController.text.isNotEmpty &&
                                      stockController.text.isNotEmpty) {
                                    consignController.addProduct(
                                      Product(
                                        name: nameController.text,
                                        price:
                                            double.parse(priceController.text),
                                        description: descriptionController.text,
                                        stock: int.parse(stockController.text),
                                        imagePath: null,
                                      ),
                                    );
                                    Get.back();
                                  } else {
                                    Get.snackbar('Error',
                                        'Harap lengkapi semua keterangan produk',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white);
                                  }
                                },
                                child: const Text('Tambah',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Tambah Produk',
                        style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 20),
                  // Daftar produk
                  Expanded(
                    child: Obx(() {
                      return ListView.builder(
                        itemCount: consignController.products.length,
                        itemBuilder: (context, index) {
                          var product = consignController.products[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: product.imagePath != null
                                  ? kIsWeb
                                      ? Image.network(
                                          product.imagePath!,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(product.imagePath!),
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                  : const Icon(Icons.image, size: 50),
                              title: Text(product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  '${formatCurrency(product.price)}\nStok: ${product.stock}\n${product.description}',
                                  style: const TextStyle(height: 1.5)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.camera_alt,
                                        color: Colors.grey),
                                    onPressed: () {
                                      consignController.pickImage(index);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () {
                                      TextEditingController nameController =
                                          TextEditingController(
                                              text: product.name);
                                      TextEditingController priceController =
                                          TextEditingController(
                                              text: product.price.toString());
                                      TextEditingController
                                          descriptionController =
                                          TextEditingController(
                                              text: product.description);
                                      TextEditingController stockController =
                                          TextEditingController(
                                              text: product.stock.toString());

                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Edit Produk',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                    controller: nameController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Nama Produk',
                                                            border:
                                                                OutlineInputBorder())),
                                                const SizedBox(height: 10),
                                                TextField(
                                                    controller: priceController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Harga Produk',
                                                            border:
                                                                OutlineInputBorder())),
                                                const SizedBox(height: 10),
                                                TextField(
                                                    controller:
                                                        descriptionController,
                                                    decoration: const InputDecoration(
                                                        labelText:
                                                            'Deskripsi Produk',
                                                        border:
                                                            OutlineInputBorder())),
                                                const SizedBox(height: 10),
                                                TextField(
                                                    controller: stockController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Stok Produk',
                                                            border:
                                                                OutlineInputBorder())),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  consignController
                                                      .updateProduct(
                                                    index,
                                                    Product(
                                                      name: nameController.text,
                                                      price: double.parse(
                                                          priceController.text),
                                                      description:
                                                          descriptionController
                                                              .text,
                                                      stock: int.parse(
                                                          stockController.text),
                                                      imagePath:
                                                          product.imagePath,
                                                    ),
                                                  );
                                                  Get.back();
                                                },
                                                child: const Text('Simpan',
                                                    style: TextStyle(
                                                        color: Colors.blue)),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      consignController.removeProduct(product);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavbarView(),
    );
  }
}
