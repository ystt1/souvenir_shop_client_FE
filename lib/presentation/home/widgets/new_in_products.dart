import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_cubit.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_state.dart';
import 'package:souvenir_shop/common/widget/product_card.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import 'package:souvenir_shop/domain/product/usecase/get_new_in_products_usecase.dart';
import 'package:souvenir_shop/domain/product/usecase/get_top_selling_product_usecase.dart';


import '../../../service_locator.dart';

class NewInProducts extends StatefulWidget {
  const NewInProducts({super.key});

  @override
  State<NewInProducts> createState() => _NewInProductsState();
}

class _NewInProductsState extends State<NewInProducts> {
  @override
  Widget build(BuildContext context) {
    return
      Builder(
        builder: (context) {
          return BlocBuilder<ProductDisplayCubit, ProductDisplayState>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductLoadingSuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [_textNewIn(),SizedBox(height: 15,), _products(context, state.products)],
                );
              }
              return const Placeholder();
            },

              );
        }
      );
  }

  Widget _textNewIn() {
    return const Text(
      "New",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _products(BuildContext context, List<ProductEntity> products) {
    List<ProductEntity> newInProduct=products;
    newInProduct.sort((a, b) {

      DateTime dateA = DateTime.parse(a.createdDate);
      DateTime dateB = DateTime.parse(b.createdDate);
      return dateB.compareTo(dateA);
    });
    return SizedBox(
      height: 300,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return _card(newInProduct[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
          itemCount: 5),
    );
  }

  Widget _card(ProductEntity product) {
    return SizedBox(
      width: 175,
      child: ProductCard(product: product)
    );
  }
}
