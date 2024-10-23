import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/product/repository/product_repository.dart';

import '../../../service_locator.dart';

class GetTopSellingProductUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    var data = await sl<ProductRepository>().getTopSellingProducts();
    data.fold((error){}, (data){

    });
    return data;
  }
}
