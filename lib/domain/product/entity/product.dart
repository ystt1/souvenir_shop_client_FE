

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final int stockQuantity;
  final int soldQuantity;
  final double basePrice;
  final double discountPrice;
  final String imageUrl;
  final String createdDate;
  final String categoryId;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.stockQuantity,
    required this.soldQuantity,
    required this.basePrice,
    required this.discountPrice,
    required this.imageUrl,
    required this.createdDate,
    required this.categoryId,
  });
}