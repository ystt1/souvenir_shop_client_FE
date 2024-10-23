import 'package:dartz/dartz.dart';

import 'package:souvenir_shop/data/category/models/category.dart';
import 'package:souvenir_shop/data/category/source/category_firebase_service.dart';
import 'package:souvenir_shop/domain/category/repository/category_repository.dart';
import 'package:souvenir_shop/service_locator.dart';

class CategoryRepositoryImp extends CategoryRepository {
  @override
  Future<Either> getCategories() async {
    var categories = await sl<CategoryFireBaseService>().getCategories();

    return categories.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => CategoryModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
