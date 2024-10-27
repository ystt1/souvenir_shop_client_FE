import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/product/repository/product_repository.dart';

import '../../../service_locator.dart';

class GetProductsByCategoryIdUseCase implements UseCase<Either,String> {
  @override
  Future<Either> call({String? params}) {
    return sl<ProductRepository>().getProductsByCategoryId(params!);
  }

}