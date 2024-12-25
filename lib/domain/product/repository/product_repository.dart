import 'package:dartz/dartz.dart';

abstract class ProductRepository{
  Future<Either> getTopSellingProducts();
  Future<Either> getNewInProducts();
  Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
  Future<Either> getProductsById(String id);
  Future<Either> addFavorite(String idProduct);
}