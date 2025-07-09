class Product {
  final String imageURL;
  final String title;
  final String priceRange;
  final String moq;
  final double rating;

  Product({
    required this.imageURL,
    required this.title,
    required this.priceRange,
    required this.moq,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imageURL: json['imageURL'] ?? '',
      title: json['title'] ?? '',
      priceRange: json['priceRange'] ?? '',
      moq: json['moq'] ?? '',
      rating: json['rating'] ?? '',
    );
  }
}
