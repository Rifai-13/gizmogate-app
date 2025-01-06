class Product {
  final String name;
  final String description;
  final double price;
  String status;
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
  
  
  void updateStatus(String newStatus) {
    status = newStatus;
  }
}
