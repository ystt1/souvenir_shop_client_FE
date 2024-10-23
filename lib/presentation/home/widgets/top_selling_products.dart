
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import 'package:souvenir_shop/presentation/home/bloc/top_selling_product_display_cubit.dart';
import 'package:souvenir_shop/presentation/home/bloc/top_selling_product_display_state.dart';

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
      create: (context) => TopSellingProductDisplayCubit()..getTopSelling(),
      child: BlocBuilder<TopSellingProductDisplayCubit,
          TopSellingProductDisplayState>(
        builder: (context, state) {
          if (state is LoadingTopSellingProductDisplayState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadingSuccessTopSellingProductDisplayState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [_textTopSelling(), _producs(context,state.topSelling)],
            );
          }
          return Placeholder();
        },
      ),
    );
  }

  Widget _textTopSelling() {
    return Text(
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
            return SizedBox(width: 10);
          },
          itemCount: 5),
    );
  }

  Widget _card(ProductEntity product) {
    return SizedBox(
      width: 175,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
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
