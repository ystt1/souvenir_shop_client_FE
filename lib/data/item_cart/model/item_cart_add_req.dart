class ItemCartAddReq {
  final String productId;
  final int quantity;

  ItemCartAddReq({required this.productId, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'quantity': this.quantity,
    };
  }

  factory ItemCartAddReq.fromMap(Map<String, dynamic> map) {
    return ItemCartAddReq(
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
    );
  }
}

