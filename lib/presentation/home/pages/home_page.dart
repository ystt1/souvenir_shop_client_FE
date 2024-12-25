import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/presentation/home/widgets/categories.dart';
import 'package:souvenir_shop/presentation/home/widgets/header.dart';
import 'package:souvenir_shop/presentation/home/widgets/new_in_products.dart';
import 'package:souvenir_shop/presentation/home/widgets/search_field.dart';
import 'package:souvenir_shop/presentation/home/widgets/top_selling_products.dart';

import '../../../common/bloc/category/category_display_cubit.dart';
import '../../../common/bloc/product/product_display_cubit.dart';
import '../../../domain/product/usecase/get_top_selling_product_usecase.dart';
import '../../../service_locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryDisplayCubit()..getCategories(),
        ),
        BlocProvider(
          create: (context) =>
              ProductDisplayCubit(useCase: sl<GetTopSellingProductUseCase>())
                ..getProducts(),
        )
      ],
      child: const Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: 15,
            ),
            SearchField(),
            SizedBox(
              height: 15,
            ),
            Categories(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    TopSellingProducts(),
                    SizedBox(
                      height: 15,
                    ),
                    NewInProducts(),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
