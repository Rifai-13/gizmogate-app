import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaksi_controller.dart';

class OrderStatus extends StatelessWidget {
  final Product product;
  final TransaksiController controller;

  OrderStatus({required this.product, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (product.status == "pesananSelesai")
            Text(
              "Pesanan telah diselesaikan",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          if (product.status == "pesananDibatalkan")
            Text(
              "Pesanan telah dibatalkan",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          if (product.status == "dalamPengiriman") ...[
            ElevatedButton(
              onPressed: () {
                controller.markAsCompleted(product);
              },
              child: Text("Selesaikan"),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                controller.cancelOrder(product);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text("Batalkan"),
            ),
          ],
        ],
      );
    });
  }
}
