import 'package:flutter/material.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import '../../../domain/itemCart/entity/item_cart_entity.dart';

class ItemPurchaseCard extends StatelessWidget {
  final double price;
  final ProductEntity product;
  final CartItemEntity cartItem;

  const ItemPurchaseCard({
    super.key,
    required this.price,
    required this.product,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4.0),
            Text(
              "Quantity: ${cartItem.quantity}",
              style: TextStyle(color: Colors.grey[700]),
            ),
            Row(
              children: [
                Text(
                  "\$${(product.basePrice * cartItem.quantity).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8.0),
                // Current Price
                Text(
                  "\$${(price * cartItem.quantity).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
