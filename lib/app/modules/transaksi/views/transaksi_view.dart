import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gizmogate/app/modules/transaksi/controllers/transaksi_controller.dart';
import '../../navbar/views/navbar_view.dart';
import '../controllers/order_controller.dart';

class TransaksiView extends GetView<TransaksiController> {
  TransaksiView({super.key});

  @override
  Widget build(BuildContext context) {
    final TransaksiController controller = Get.put(TransaksiController());
    final OrderController orderController = Get.find<OrderController>();

    // Mengupdate status untuk pesanan
    orderController.updateOrderStatus("dalamPengiriman");

    final item = Get.arguments;

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
                            if (product.status == "pesananSelesai")
                              ElevatedButton(
                                onPressed: () {
                                  showReviewDialog(context, product);
                                },
                                child: Text("Berikan Ulasan"),
                              ),
                            if (product.status != "pesananSelesai")
                              ElevatedButton(
                                onPressed: () {
                                  controller.markAsCompleted(product);
                                  orderController
                                      .updateOrderStatus("pesananSelesai");
                                  // Menampilkan pesan pesanan selesai
                                  Get.snackbar('Pesanan Selesai',
                                      'Pesanan telah selesai, berikan ulasan!');
                                },
                                child: Text("Selesaikan"),
                              ),
                            SizedBox(width: 8), // Jarak antara tombol
                            if (product.status != "pesananDibatalkan")
                              ElevatedButton(
                                onPressed: () {
                                  controller.cancelOrder(product);
                                  orderController
                                      .updateOrderStatus("pesananDibatalkan");
                                  // Menampilkan pesan pesanan dibatalkan
                                  Get.snackbar('Pesanan Dibatalkan',
                                      'Pesanan telah dibatalkan.');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .red, // Warna merah untuk tombol "Batalkan"
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
                Get.snackbar('Ulasan Dikirim',
                    'Terima kasih telah memberikan ulasan!');
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
      TransaksiController controller, TransaksiFilter filter, String title) {
    return Obx(() {
      bool isSelected = controller.selectedFilter.value == filter;
      return GestureDetector(
        onTap: () => controller.updateFilter(filter),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(colors: [Colors.black, Colors.black])
                : null,
            color: isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isSelected ? Colors.black : Colors.grey),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5)
                  ]
                : [],
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );
    });
  }
}
