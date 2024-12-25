import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/item_cart/model/item_orders_add_req.dart';
import 'package:souvenir_shop/domain/itemCart/entity/purchase_get_entity.dart';

import '../../../data/item_cart/model/item_cart_add_req.dart';


abstract class ItemCartRepository{
  Future<Either> addItemToCart(ItemCartAddReq item);
  Future<Either> getListItemOnCart();
  Future<Either> purchase(List<String> ids);
  Future<Either> orderItem(List<ItemOrdersAddReq> items);
  Future<Either> placeOrder(PurchaseGetEntity purchase);
}