import 'package:souvenir_shop/domain/category/entity/category_entity.dart';

class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<dynamic> products;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'imageUrl': this.imageUrl,
      'products': [],
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      products: map['products'] ?? [],
    );
  }


}

extension CategoryXModel on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
        id: id,
        name: name,
        description: description,
        imageUrl: imageUrl,
        products: products);
  }
}
