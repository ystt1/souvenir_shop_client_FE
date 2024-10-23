
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import 'package:souvenir_shop/presentation/home/bloc/new_in_product_display_cubit.dart';
import 'package:souvenir_shop/presentation/home/bloc/new_in_product_state.dart';
import 'package:souvenir_shop/presentation/home/bloc/top_selling_product_display_state.dart';

import '../../../common/app_colors.dart';

class NewInProducts extends StatefulWidget {
  const NewInProducts({super.key});

  @override
  State<NewInProducts> createState() => _NewInProductsState();
}

class _NewInProductsState extends State<NewInProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewInProductDisplayCubit()..getNewIn(),
      child: BlocBuilder<NewInProductDisplayCubit,
          NewInProductDisplayState>(
        builder: (context, state) {
          if (state is LoadingNewInProductDisplayState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadingSuccessNewInProductDisplayState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [_textNewIn(), _products(context,state.newIn)],
            );
          }
          return const Placeholder();
        },
      ),
    );
  }

  Widget _textNewIn() {
    return const Text(
      "New",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _products(BuildContext context,List<ProductEntity> products) {
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
