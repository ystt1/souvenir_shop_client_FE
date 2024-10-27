import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_cubit.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_state.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/common/widget/product_card.dart';
import 'package:souvenir_shop/common/widget/product_gridview.dart';
import 'package:souvenir_shop/domain/category/entity/category_entity.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import 'package:souvenir_shop/domain/product/usecase/get_products_by_category_id_usecase.dart';
import 'package:souvenir_shop/service_locator.dart';

class CategoryProductPage extends StatelessWidget {
  final CategoryEntity category;

  const CategoryProductPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDisplayCubit(useCase: sl<GetProductsByCategoryIdUseCase>())
            ..getProducts(params: category.categoryId),
      child: Scaffold(
          appBar: AppBar(
            leading: const BackIconAppbar(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: BlocBuilder<ProductDisplayCubit, ProductDisplayState>(
              builder: (context, state) {
                if (state is ProductLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProductLoadingSuccessState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textAbove(context, state.products.length),
                      const SizedBox(height: 20),
                      _products(context, state.products)
                    ],
                  );
                }
                return Container();
              },
            ),
          )),
    );
  }

  Widget _textAbove(BuildContext context, int amount) {
    return Text("Products ($amount)");
  }

  Widget _products(BuildContext context, List<ProductEntity> products) {
    return Expanded(
      child: ProductGridview(products: products),
    );
  }
}
