import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/itemCart/repository/item_cart_repository.dart';

import '../../../service_locator.dart';

class PurchaseCartUseCase implements UseCase<Either, List<String>> {
  @override
  Future<Either> call({List<String>? params}) async {
    return await sl<ItemCartRepository>().purchase(params!);
  }
}
