import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import 'package:souvenir_shop/presentation/product_detail/page/product_detail.dart';

import '../app_colors.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>AppNavigator.push(context,ProductDetailPage(product: product)),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                            product.image),
                        fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Text(
                    "-${product.discount}",
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColors.secondBackground,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product.title), Text("${product.price}\$")]),
            ),
          )
        ],
      ),
    );
  }
}
