import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/data/item_cart/model/item_orders_add_req.dart';

import '../../../service_locator.dart';
import '../repository/item_cart_repository.dart';

class OrderItemUseCase implements UseCase<Either,List<ItemOrdersAddReq>> {
  @override
  Future<Either> call({List<ItemOrdersAddReq>? params}) async {
    return await sl<ItemCartRepository>().orderItem(params!);
  }

}