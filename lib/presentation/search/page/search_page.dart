import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_cubit.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_state.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/common/widget/product_gridview.dart';
import 'package:souvenir_shop/domain/product/usecase/get_products_by_title_usecase.dart';
import 'package:souvenir_shop/service_locator.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDisplayCubit(useCase: sl<GetProductsByTitleUseCase>()),
      child: Scaffold(
        appBar: AppBar(
            leading: const BackIconAppbar(),
            title: Builder(builder: (context) {
              return TextField(
                onChanged: (value) {
                  if (value.isEmpty) {
                    context.read<ProductDisplayCubit>().getInitial();
                  } else {
                    context
                        .read<ProductDisplayCubit>()
                        .getProducts(params: value);
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  fillColor: AppColors.secondBackground,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: CupertinoColors.white,
                  ),
                  hintText: "Search",
                  hintStyle: const TextStyle(color: CupertinoColors.white),
                ),
              );
            })),
        body: BlocBuilder<ProductDisplayCubit, ProductDisplayState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductLoadingSuccessState) {
              if(state.products.isEmpty)
                return Text("NotFound Products");
              return ProductGridview(products: state.products);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
