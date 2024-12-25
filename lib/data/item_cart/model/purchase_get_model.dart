import 'package:souvenir_shop/domain/itemCart/entity/purchase_get_entity.dart';

class PurchaseGetModel {
  final double total;
  final String sendToPlaceOrderString;
  final String time;

  PurchaseGetModel(
      {required this.total,
      required this.sendToPlaceOrderString,
      required this.time});
}

extension PurchaseGetModelToEntity on PurchaseGetModel {
  PurchaseGetEntity toEntity() {
    return PurchaseGetEntity(
        total: total,
        sendToPlaceOrderString: sendToPlaceOrderString,
        time: time);
  }
}
