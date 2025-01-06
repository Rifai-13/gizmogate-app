import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../models/review.dart';

enum TransaksiFilter { semuaPesanan, dalamPengiriman, pesananSelesai }

class TransaksiController extends GetxController {
  var selectedFilter = TransaksiFilter.semuaPesanan.obs;
  var products = <Product>[].obs;
  var reviews = <Review>[].obs;

  void addProduct(Product product) {
    products.add(product);
  }

  void updateFilter(TransaksiFilter filter) {
    selectedFilter.value = filter;
  }

  List<Product> get filteredProducts {
    if (selectedFilter.value == TransaksiFilter.semuaPesanan) {
      return products;
    } else if (selectedFilter.value == TransaksiFilter.dalamPengiriman) {
      return products.where((p) => p.status == "dalamPengiriman").toList();
    } else if (selectedFilter.value == TransaksiFilter.pesananSelesai) {
      return products.where((p) => p.status == "pesananSelesai").toList();
    } else {
      return [];
    }
  }

  void cancelOrder(Product product) {
    int index = products.indexWhere((p) => p.name == product.name);
    if (index != -1) {
      products[index].updateStatus("pesananDibatalkan");
      products.refresh();
      products[index] = products[index];
    }
  }

  void addReview(Review review) {
    reviews.add(review);
  }

  void updateReview(String productName, String comment, double rating) {
    int index = reviews.indexWhere((r) => r.productName == productName);
    if (index != -1) {
      reviews[index].updateReview(comment, rating);
      reviews.refresh();
    }
  }

  List<Review> getReviewsForProduct(String productName) {
    return reviews.where((r) => r.productName == productName).toList();
  }

  void markAsCompleted(Product product) {
    int index = products.indexWhere((p) => p.name == product.name);
    if (index != -1) {
      products[index].updateStatus("pesananSelesai");
      products[index] = products[index]; // Memaksa pembaruan UI
    }
  }
}
