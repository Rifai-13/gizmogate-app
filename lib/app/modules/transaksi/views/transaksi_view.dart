import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gizmogate/app/modules/transaksi/controllers/transaksi_controller.dart';

import '../../navbar/views/navbar_view.dart';

class TransaksiView extends GetView<TransaksiController> {
  TransaksiView({super.key});
  @override
  Widget build(BuildContext context) {
    final TransaksiController controller = Get.put(TransaksiController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi"),
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
          // Membungkus Row dengan SingleChildScrollView agar bisa digulir secara horizontal
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildFilterButton(controller, TransaksiFilter.semuaPesanan, "Semua Pesanan"),
                buildFilterButton(controller, TransaksiFilter.dalamPengiriman, "Dalam Pengiriman"),
                buildFilterButton(controller, TransaksiFilter.pesananSelesai, "Pesanan Selesai"),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.handshake, size: 100, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Belum Ada Transaksi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Belum Ada Transaksi pada filter yang diterapkan",
                    style: TextStyle(color: Colors.grey),
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

  Widget buildFilterButton(
      TransaksiController controller, TransaksiFilter filter, String title) {
    return Obx(() {
      bool isSelected = controller.selectedFilter.value == filter;
      return GestureDetector(
        onTap: () => controller.updateFilter(filter),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }
}
