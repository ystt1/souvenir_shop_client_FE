import 'package:souvenir_shop/domain/itemCart/entity/item_cart_entity.dart';

abstract class GetItemCartState{}

class GetItemCartInitial extends GetItemCartState{}

class GetItemCartLoading extends GetItemCartState{}

class GetItemCartSuccess extends GetItemCartState{
  final List<CartItemEntity> carts;

  GetItemCartSuccess({required this.carts});
}

class GetItemCartFailure extends GetItemCartState{
  final String errorMsg;

  GetItemCartFailure({required this.errorMsg});
}