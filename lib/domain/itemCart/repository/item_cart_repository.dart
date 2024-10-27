import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/itemCart/model/item_cart_add_req.dart';

abstract class ItemCartRepository{
  Future<Either> addItemToCart(ItemCartAddReq item);
}