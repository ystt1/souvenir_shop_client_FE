import 'package:souvenir_shop/domain/category/entity/category_entity.dart';

class CategoryModel {
  final String categoryId;
  final String title;
  final String image;

  const CategoryModel({
    required this.categoryId,
    required this.title,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': this.categoryId,
      'title': this.title,
      'image': this.image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
    );
  }
}

extension CategoryXModel on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(categoryId: categoryId, title: title, image: image);
  }
}
