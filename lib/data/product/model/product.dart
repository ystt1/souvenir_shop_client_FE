import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';

class ProductModel {
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

  const ProductModel({
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

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'categoryId': this.categoryId,
      'image': this.image,
      'title': this.title,
      'description': this.description,
      'original': this.original,
      'material': this.material,
      'discount': this.discount,
      'weight': this.weight,
      'tags': this.tags,
      'price': this.price,
      'saledNumber': this.saledNumber,
      'quantity': this.quantity,
      'createdDate': this.createdDate,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] as String,
      categoryId: map['categoryId'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      original: map['original'] as String,
      material: map['material'] as String,
      discount: map['discount'] as String,
      weight: map['weight'] as String,
      tags: List<String>.from(map['tags'] ?? []),
      price: map['price'] as num,
      saledNumber: map['saledNumber'] as num,
      quantity: map['quantity'] as num,
      createdDate: map['createdDate'] as Timestamp,
    );
  }
}

extension ProductXModel on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
        productId: productId,
        categoryId: categoryId,
        image: image,
        title: title,
        description: description,
        original: original,
        material: material,
        discount: discount,
        weight: weight,
        tags: tags,
        price: price,
        saledNumber: saledNumber,
        quantity: quantity,
        createdDate: createdDate);
  }
}
