class Review {
  String productName;
  String comment;
  double rating;

  Review({
    required this.productName,
    required this.comment,
    required this.rating,
  });

  void updateReview(String newComment, double newRating) {
    comment = newComment;
    rating = newRating;
  }
}
