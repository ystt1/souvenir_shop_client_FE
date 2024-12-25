import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/product/repository/product_repository.dart';

import '../../../service_locator.dart';

class AddFavoriteProductUseCase implements UseCase<Either,String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<ProductRepository>().addFavorite(params!);
  }

}