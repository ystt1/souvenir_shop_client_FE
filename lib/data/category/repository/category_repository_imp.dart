import 'package:dartz/dartz.dart';

import 'package:souvenir_shop/data/category/models/category.dart';
import 'package:souvenir_shop/data/category/source/category_dot_net_service.dart';

import 'package:souvenir_shop/domain/category/repository/category_repository.dart';
import 'package:souvenir_shop/service_locator.dart';

class CategoryRepositoryImp extends CategoryRepository {
  @override
  Future<Either> getCategories() async {
    try {
      var categories = await sl<CategoryDotNetService>().getCategories();
      return categories.fold((error) {
        return Left(error);
      }, (data) {
        return Right(
            (data as List<CategoryModel>).map((e) => e.toEntity()).toList());
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
