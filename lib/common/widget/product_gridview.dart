import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/widget/product_card.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';

class ProductGridview extends StatelessWidget {
  final List<ProductEntity> products;
  const ProductGridview({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 10,
            childAspectRatio: 0.57
        ),
        itemBuilder: (context, index) {
          return Container(
              child:  ProductCard(product: products[index])
          );
        });
  }
}
