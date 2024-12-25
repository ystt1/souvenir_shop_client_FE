class OrderItemEntity {
  String id;
  String orderId;
  String productId;
  int quantity;

  OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
  });


}