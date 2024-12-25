import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souvenir_shop/common/constant.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';

class ProductModel {
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

  const ProductModel({
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



  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'stockQuantity': this.stockQuantity,
      'soldQuantity': this.soldQuantity,
      'basePrice': this.basePrice,
      'discountPrice': this.discountPrice,
      'imageUrl': this.imageUrl,
      'createdDate': this.createdDate,
      'categoryId': this.categoryId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    String processedImageUrl = map['imageUrl'] as String;
    if (!processedImageUrl.startsWith('http://') && !processedImageUrl.startsWith('https://')) {
      processedImageUrl = '$AppImage/$processedImageUrl';
    }
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      stockQuantity: map['stockQuantity'] as int,
      soldQuantity: map['soldQuantity'] as int,
      basePrice: map['basePrice'] as double,
      discountPrice: map['discountPrice'] as double,
      imageUrl: processedImageUrl,
      createdDate: map['createdDate'] as String,
      categoryId: map['categoryId'] as String,
    );
  }
}

extension ProductXModel on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
        id: id,
        name: name,
        description: description,
        stockQuantity: stockQuantity,
        soldQuantity: soldQuantity,
        basePrice: basePrice,
        discountPrice: discountPrice,
        imageUrl: imageUrl,
        createdDate: createdDate,
        categoryId: categoryId);
  }
}
