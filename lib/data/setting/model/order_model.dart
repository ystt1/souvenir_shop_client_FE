import 'package:souvenir_shop/domain/setting/entity/order_entity.dart';

import 'dart:convert';

import 'order_item_model.dart';

class OrderModel {
  String id;
  String orderDate;
  int status;
  double total;
  List<OrderItemModel> orderItems;

  OrderModel({
    required this.id,
    required this.orderDate,
    required this.status,
    required this.total,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderDate: json['orderDate'],
      status: json['status'],
      total: json['total'].toDouble(),
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderDate': orderDate,
      'status': status,
      'total': total,
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItem {
  String id;
  String orderId;
  String productId;
  int quantity;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
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

extension OrderModelToEntity on OrderModel {
  OrderEntity toEntity() {
    return OrderEntity(
        id: id,
        orderDate: orderDate,
        status: status,
        total: total,
        orderItems: orderItems.map((e) => e.toEntity()).toList());
  }
}
