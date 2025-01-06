import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gizmogate/app/modules/transaksi/controllers/transaksi_controller.dart';
import '../../navbar/views/navbar_view.dart';
import '../models/product.dart';
import '../models/review.dart';

class TransaksiView extends GetView<TransaksiController> {
  TransaksiView({super.key});

  @override
  Widget build(BuildContext context) {
    final TransaksiController controller = Get.put(TransaksiController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi", style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildFilterButton(
                    controller, TransaksiFilter.semuaPesanan, "Semua Pesanan"),
                buildFilterButton(controller, TransaksiFilter.dalamPengiriman,
                    "Dalam Pengiriman"),
                buildFilterButton(controller, TransaksiFilter.pesananSelesai,
                    "Pesanan Selesai"),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (controller.filteredProducts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: 100, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        "Belum Ada Transaksi",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      Text(
                        "Belum Ada Transaksi pada filter yang diterapkan",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(product.name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.description),
                            if (product.status == "pesananSelesai")
                              Obx(() {
                                final reviews = controller
                                    .getReviewsForProduct(product.name);
                                if (reviews.isNotEmpty) {
                                  final review = reviews.first;
                                  return Text(
                                    "Rating: ${review.rating} | Comment: ${review.comment}",
                                    style: TextStyle(color: Colors.grey),
                                  );
                                } else {
                                  return Text(
                                    "Belum ada ulasan.",
                                    style: TextStyle(color: Colors.grey),
                                  );
                                }
                              }),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (product.status == "dalamPengiriman")
                              ElevatedButton(
                                onPressed: () {
                                  controller.markAsCompleted(product);
                                  Get.snackbar('Pesanan Selesai',
                                      'Pesanan telah selesai, berikan ulasan!');
                                },
                                child: Text("Selesaikan"),
                              ),
                            if (product.status == "pesananSelesai")
                              ElevatedButton(
                                onPressed: () {
                                  showReviewDialog(context, product);
                                },
                                child: Text("Berikan Ulasan"),
                              ),
                            if (product.status == "dalamPengiriman")
                              SizedBox(width: 8),
                            if (product.status == "dalamPengiriman")
                              ElevatedButton(
                                onPressed: () {
                                  controller.cancelOrder(product);
                                  Get.snackbar('Pesanan Dibatalkan',
                                      'Pesanan telah dibatalkan.');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: Text("Batalkan"),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: const NavbarView(),
    );
  }

  void showReviewDialog(BuildContext context, Product product) {
    var existingReview =
        controller.getReviewsForProduct(product.name).isNotEmpty
            ? controller.getReviewsForProduct(product.name).first
            : null;

    TextEditingController commentController = TextEditingController(
      text: existingReview?.comment ?? '',
    );
    double rating = existingReview?.rating ?? 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Berikan Ulasan untuk ${product.name}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: commentController,
                decoration: InputDecoration(labelText: "Komentar"),
              ),
              Slider(
                value: rating,
                min: 0,
                max: 5,
                divisions: 5,
                label: rating.toString(),
                onChanged: (value) {
                  rating = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (existingReview == null) {
                  controller.addReview(
                    Review(
                        productName: product.name,
                        comment: commentController.text,
                        rating: rating),
                  );
                } else {
                  controller.updateReview(
                    product.name,
                    commentController.text,
                    rating,
                  );
                }
                Navigator.of(context).pop();
                // Menampilkan pesan bahwa ulasan telah dikirim
                Get.snackbar(
                    'Ulasan Dikirim', 'Terima kasih telah memberikan ulasan!');
              },
              child: Text(
                  existingReview == null ? "Kirim Ulasan" : "Perbarui Ulasan"),
            ),
          ],
        );
      },
    );
  }

  Widget buildFilterButton(
      TransaksiController controller, TransaksiFilter filter, String label) {
    return GestureDetector(
      onTap: () => controller.updateFilter(filter),
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: controller.selectedFilter.value == filter
                ? Colors.black
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
                color: controller.selectedFilter.value == filter
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}
