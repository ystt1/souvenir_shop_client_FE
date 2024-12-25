import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/item_cart/model/cart_item_model.dart';
import 'package:souvenir_shop/data/item_cart/model/item_orders_add_req.dart';
import 'package:souvenir_shop/data/item_cart/model/purchase_get_model.dart';
import 'package:souvenir_shop/data/item_cart/source/item_cart_dotnet_service.dart';
import 'package:souvenir_shop/domain/itemCart/entity/purchase_get_entity.dart';

import 'package:souvenir_shop/domain/itemCart/repository/item_cart_repository.dart';

import '../../../service_locator.dart';
import '../model/item_cart_add_req.dart';

class ItemCartRepositoryImp extends ItemCartRepository {
  @override
  Future<Either> addItemToCart(ItemCartAddReq item) async {
    return await sl<ItemCartDotNetService>().addToCart(item);
  }

  @override
  Future<Either> getListItemOnCart() async {
    try {
      final returnedData = await sl<ItemCartDotNetService>().getItemCart();
      return returnedData.fold(
        (error) => Left(error),
        (data) {
          final cartItems =
              (data as List<CartItemModel>).map((e) => e.toEntity()).toList();
          return Right(cartItems);
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> orderItem(List<ItemOrdersAddReq> items) {
    // TODO: implement orderItem
    throw UnimplementedError();
  }

  @override
  Future<Either> purchase(List<String> ids) async {
    try {
      final returnedData = await sl<ItemCartDotNetService>().purchase(ids);
      return returnedData.fold(
        (error) => Left(error),
        (data) {
          return Right((data as PurchaseGetModel).toEntity());
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> placeOrder(PurchaseGetEntity purchase) async {
    return await sl<ItemCartDotNetService>().placeOrder(purchase);
  }
}
