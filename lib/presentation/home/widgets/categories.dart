import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/bloc/category/category_display_cubit.dart';
import 'package:souvenir_shop/common/bloc/category/category_display_state.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/domain/category/entity/category_entity.dart';
import 'package:souvenir_shop/presentation/all_category/page/all_category_page.dart';
import 'package:souvenir_shop/presentation/category_product/page/category_product.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryDisplayCubit()..getCategories(),
      child: BlocBuilder<CategoryDisplayCubit, CategoryDisplayState>(
        builder: (context, state) {
          if (state is CategoryDisplayLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CategoryDisplaySuccessState) {
            return Column(
              children: [
                _categoryText(context),
                _listCategories(context, state.listCate)
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _categoryText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            AppNavigator.push(context, const AllCategoryPage());
          },
          child: const Text("See All"),
        )
      ],
    );
  }

  Widget _listCategories(BuildContext context, List<CategoryEntity> listCate) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: ()=>AppNavigator.push(context,CategoryProductPage(category: listCate[index])),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CupertinoColors.white,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(listCate[index].image))),
                  ),
                  Text(listCate[index].title)
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              ),
          itemCount: 5),
    );
  }
}
