import 'package:cloud_firestore/cloud_firestore.dart';

class ProductEntity {
  final String productId;
  final String categoryId;
  final String image;
  final String title;
  final String description;
  final String original;
  final String material;
  final String discount;
  final String weight;
  final List<String> tags;
  final num price;
  final num saledNumber;
  final num quantity;
  final Timestamp createdDate;

  const ProductEntity({
    required this.productId,
    required this.categoryId,
    required this.image,
    required this.title,
    required this.description,
    required this.original,
    required this.material,
    required this.discount,
    required this.weight,
    required this.tags,
    required this.price,
    required this.saledNumber,
    required this.quantity,
    required this.createdDate,
  });
}