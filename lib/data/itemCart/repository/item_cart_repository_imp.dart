import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/itemCart/model/item_cart_add_req.dart';
import 'package:souvenir_shop/data/itemCart/source/item_cart_firebase_service.dart';
import 'package:souvenir_shop/domain/itemCart/repository/item_cart_repository.dart';

import '../../../service_locator.dart';

class ItemCartRepositoryImp extends ItemCartRepository{
  @override
  Future<Either> addItemToCart(ItemCartAddReq item) async {
    return await sl<ItemCartFirebaseService>().addItemToCart(item);
  }
}