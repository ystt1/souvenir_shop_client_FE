import 'package:dartz/dartz.dart';

abstract class ProductRepository{
  Future<Either> getTopSellingProducts();
  Future<Either> getNewInProducts();
}