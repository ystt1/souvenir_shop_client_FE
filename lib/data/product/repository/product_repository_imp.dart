import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/product/model/product.dart';
import 'package:souvenir_shop/data/product/source/product_dot_net_service.dart';
import 'package:souvenir_shop/data/product/source/product_firebase_service.dart';
import 'package:souvenir_shop/domain/product/repository/product_repository.dart';

import '../../../domain/product/entity/product.dart';
import '../../../service_locator.dart';

class ProductRepositoryImp extends ProductRepository {
  @override
  Future<Either<String, List<ProductEntity>>> getTopSellingProducts() async {
    try {
      var categories = await sl<ProductDotNetService>().getAllProduct();

      return categories.fold((error) {
        return Left(error);
      }, (data) {
        return Right(
            (data as List<ProductModel>).map((e) => e.toEntity()).toList());
      });
    } catch (e) {
      return Left(e.toString());
    }
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

  @override
  Future<Either> getProductsByCategoryId(String categoryId) async {
    try {
      var categories = await sl<ProductDotNetService>().getAllProduct();

      return categories.fold((error) {
        return Left(error);
      }, (data) {
        var filteredProducts = (data as List<ProductModel>)
            .where((product) => product.categoryId == categoryId)
            .map((product) => product.toEntity())
            .toList();


        if (filteredProducts.isEmpty) {
          return Left("No products found for this category.");
        }

        return Right(filteredProducts);
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getProductsByTitle(String title) async {
    try {
      var categories = await sl<ProductDotNetService>().getAllProduct();

      return categories.fold((error) {
        return Left(error);
      }, (data) {
        var filteredProducts = (data as List<ProductModel>)
            .where((product) => product.name.toLowerCase().contains(title.toLowerCase()))
            .map((product) => product.toEntity())
            .toList();


        if (filteredProducts.isEmpty) {
          return Left("No products found for this category.");
        }

        return Right(filteredProducts);
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> addFavorite(String idProduct) {
    // TODO: implement addFavorite
    throw UnimplementedError();
  }

  @override
  Future<Either> getProductsById(String id) async {
    try {
      var categories = await sl<ProductDotNetService>().getProductById(id);

      return categories.fold((error) {
        return Left(error);
      }, (data) {
        return Right((data as ProductModel).toEntity());
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
