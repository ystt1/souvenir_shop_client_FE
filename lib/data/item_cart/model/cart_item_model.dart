import 'package:souvenir_shop/domain/itemCart/entity/item_cart_entity.dart';

import '../../product/model/product.dart';

class CartItemModel {
  String id;
  String cartId;
  String productId;
  int quantity;
  ProductModel product;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      cartId: map['cartId'],
      productId: map['productId'],
      quantity: map['quantity'],
      product: ProductModel.fromMap(map['product']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cartId': cartId,
      'productId': productId,
      'quantity': quantity,
      'product': product.toMap(),
    };
  }
}

extension CartItemModelToEntity on CartItemModel {
  CartItemEntity toEntity() {
    return CartItemEntity(
        id: id,
        cartId: cartId,
        productId: productId,
        quantity: quantity,
        product: product.toEntity());
  }
}
