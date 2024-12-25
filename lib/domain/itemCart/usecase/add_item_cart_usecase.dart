import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';

import 'package:souvenir_shop/domain/itemCart/repository/item_cart_repository.dart';

import '../../../data/item_cart/model/item_cart_add_req.dart';
import '../../../service_locator.dart';

class AddItemCartUseCase implements UseCase<Either,ItemCartAddReq> {
  @override
  Future<Either> call({ItemCartAddReq? params}) async {
    return await sl<ItemCartRepository>().addItemToCart(params!);
  }

}