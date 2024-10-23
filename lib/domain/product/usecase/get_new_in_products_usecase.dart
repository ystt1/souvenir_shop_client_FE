import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/product/repository/product_repository.dart';

import '../../../service_locator.dart';

class GetNewInProductUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call({params}) async {
   return await sl<ProductRepository>().getNewInProducts();
  }

}