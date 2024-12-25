import 'package:souvenir_shop/domain/product/entity/product.dart';

class CartItemEntity {
  String id;
  String cartId;
  String productId;
  int quantity;
  ProductEntity product;

  CartItemEntity({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.product,
  });

}
