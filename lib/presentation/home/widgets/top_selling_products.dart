
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_cubit.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_state.dart';
import 'package:souvenir_shop/common/widget/product_card.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import 'package:souvenir_shop/domain/product/usecase/get_top_selling_product_usecase.dart';

import 'package:souvenir_shop/service_locator.dart';

import '../../../common/app_colors.dart';

class TopSellingProducts extends StatefulWidget {
  const TopSellingProducts({super.key});

  @override
  State<TopSellingProducts> createState() => _TopSellingProductsState();
}

class _TopSellingProductsState extends State<TopSellingProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDisplayCubit(useCase: sl<GetTopSellingProductUseCase>())..getProducts(),
      child: BlocBuilder<ProductDisplayCubit,
          ProductDisplayState>(
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
              children: [_textTopSelling(), _producs(context,state.products)],
            );
          }
          return const Placeholder();
        },
      ),
    );
  }

  Widget _textTopSelling() {
    return const Text(
      "Top Selling",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _producs(BuildContext context,List<ProductEntity> products) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _card(products[index]);
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
      child: ProductCard(product: product),
    );
  }
}
