import 'order_item_entity.dart';

class OrderEntity {
  String id;
  String orderDate;
  int status;
  double total;
  List<OrderItemEntity> orderItems;

  OrderEntity({
    required this.id,
    required this.orderDate,
    required this.status,
    required this.total,
    required this.orderItems,
  }); // Tổng quantity từ orderItems



}
