import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/itemCart/entity/purchase_get_entity.dart';
import 'package:souvenir_shop/domain/itemCart/repository/item_cart_repository.dart';

import '../../../service_locator.dart';

class PlaceOrderUseCase implements UseCase<Either, PurchaseGetEntity> {
  @override
  Future<Either> call({PurchaseGetEntity? params}) async {
    return await sl<ItemCartRepository>().placeOrder(params!);
  }
}
