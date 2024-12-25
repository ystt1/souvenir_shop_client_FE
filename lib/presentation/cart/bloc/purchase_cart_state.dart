import 'package:souvenir_shop/domain/itemCart/entity/purchase_get_entity.dart';

abstract class PurchaseCartState{}

class PurchaseCartInitial extends PurchaseCartState{}

class PurchaseCartLoading extends PurchaseCartState{}

class PurchaseCartSuccess extends PurchaseCartState{
  final PurchaseGetEntity purchaseGetEntity;
  PurchaseCartSuccess({required this.purchaseGetEntity});
}

class PurchaseCartFailure extends PurchaseCartState{
  final String errorMsg;

  PurchaseCartFailure({required this.errorMsg});

}
