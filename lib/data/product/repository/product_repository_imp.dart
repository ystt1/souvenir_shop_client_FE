import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/product/model/product.dart';
import 'package:souvenir_shop/data/product/source/product_firebase_service.dart';
import 'package:souvenir_shop/domain/product/repository/product_repository.dart';

import '../../../domain/product/entity/product.dart';
import '../../../service_locator.dart';

class ProductRepositoryImp extends ProductRepository {
  @override
  Future<Either<String, List<ProductEntity>>> getTopSellingProducts() async {
    var dataReturn = await sl<ProductFirebaseService>().getTopSellingProducts();
    return dataReturn.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> getNewInProducts() async {
    var dataReturn = await sl<ProductFirebaseService>().getNewInProducts();
    return dataReturn.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
