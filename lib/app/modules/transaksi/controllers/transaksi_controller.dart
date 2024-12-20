import 'package:get/get.dart';

// Model Produk
class Product {
  final String name;
  final String description;
  final double price;
  String status; // Change this to a non-final field
  final String image;
  final String category;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.status,
    required this.image,
    required this.category,
  });

  // Optional: Add a setter method for updating status
  void updateStatus(String newStatus) {
    status = newStatus;
  }
}

// Model Review
class Review {
  String productName;
  String comment;
  double rating;

  Review({
    required this.productName,
    required this.comment,
    required this.rating,
  });

  // Method to update the review comment and rating
  void updateReview(String newComment, double newRating) {
    comment = newComment;
    rating = newRating;
  }
}

enum TransaksiFilter { semuaPesanan, dalamPengiriman, pesananSelesai }

class TransaksiController extends GetxController {
  var selectedFilter = TransaksiFilter.semuaPesanan.obs;

  // Daftar produk yang ada
  var products = <Product>[
    // Product(
    //   name: "Produk 1 - Pengiriman",
    //   description: "Deskripsi Produk 1",
    //   price: 100.0,
    //   status: "dalamPengiriman",
    // ),
    // Product(
    //   name: "Produk 2 - Selesai",
    //   description: "Deskripsi Produk 2",
    //   price: 200.0,
    //   status: "pesananSelesai",
    // ),
    // Product(
    //   name: "Produk 3 - Pengiriman",
    //   description: "Deskripsi Produk 3",
    //   price: 150.0,
    //   status: "dalamPengiriman",
    // ),
  ].obs;

  // Daftar ulasan
  var reviews = <Review>[].obs;

  // Daftar transaksi (produk yang dibeli)
  var transactionList = <Product>[].obs;

  // Fungsi untuk menambah produk baru
  void addProduct(Product product) {
    products.add(product);
  }

  // Fungsi untuk memperbarui filter
  void updateFilter(TransaksiFilter filter) {
    selectedFilter.value = filter;
  }

  // Fungsi untuk mendapatkan produk berdasarkan filter
  List<Product> get filteredProducts {
    if (selectedFilter.value == TransaksiFilter.semuaPesanan) {
      return products;
    } else if (selectedFilter.value == TransaksiFilter.dalamPengiriman) {
      return products
          .where((product) => product.status == "dalamPengiriman")
          .toList();
    } else if (selectedFilter.value == TransaksiFilter.pesananSelesai) {
      return products
          .where((product) => product.status == "pesananSelesai")
          .toList();
    } else {
      return [];
    }
  }

  void cancelOrder(Product product) {
  var productIndex = products.indexWhere((prod) => prod.name == product.name);

  if (productIndex != -1) {
    // Mengubah status produk menjadi "dalamPengiriman" atau status awal
    products[productIndex].updateStatus("dalamPengiriman");

    // Memperbarui nilai produk dalam RxList
    products.refresh();

    // Menghapus produk dari daftar transaksi jika diperlukan
    transactionList.removeWhere((item) => item.name == product.name);
  }
}


  // Fungsi untuk menambahkan ulasan
  void addReview(Review review) {
    reviews.add(review);
  }

  // Fungsi untuk memperbarui ulasan
  void updateReview(String productName, String newComment, double newRating) {
    // Mencari review berdasarkan productName
    var review = reviews.firstWhere(
      (review) => review.productName == productName,
      orElse: () => Review(productName: productName, comment: '', rating: 0.0),
    );

    // Memperbarui ulasan yang ditemukan
    review.updateReview(newComment, newRating);
  }

  // Fungsi untuk menghapus ulasan
  void deleteReview(String productName) {
    reviews.removeWhere((review) => review.productName == productName);
  }

  // Fungsi untuk mendapatkan ulasan berdasarkan produk
  List<Review> getReviewsForProduct(String productName) {
    return reviews
        .where((review) => review.productName == productName)
        .toList();
  }

  // Fungsi untuk menambahkan produk ke dalam daftar transaksi
  void addToTransaction(Product product) {
    if (!transactionList.contains(product)) {
      transactionList.add(product);
    }
  }

  // Fungsi untuk menandai produk sebagai selesai
  void markAsCompleted(Product product) {
    var productIndex = products.indexWhere((prod) => prod.name == product.name);

    if (productIndex != -1) {
      // Mengubah status produk menjadi "pesananSelesai"
      products[productIndex]
          .updateStatus("pesananSelesai"); // Use the setter method

      // Memperbarui nilai produk dalam RxList
      products.refresh();
    }
  }
}
