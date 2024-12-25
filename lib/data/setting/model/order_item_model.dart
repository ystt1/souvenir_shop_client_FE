import '../../../domain/setting/entity/order_item_entity.dart';

class OrderItemModel {
  String id;
  String orderId;
  String productId;
  int quantity;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      orderId: json['orderId'],
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}

extension OrderItemModelToEntity on OrderItemModel {
  OrderItemEntity toEntity() {
    return OrderItemEntity(id: id, orderId: orderId, productId: productId, quantity: quantity);
  }
}