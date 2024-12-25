import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/category/category_display_cubit.dart';
import 'package:souvenir_shop/common/bloc/category/category_display_state.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';

import '../../../common/helper/navigator/app_navigator.dart';
import '../../category_product/page/category_product.dart';

class AllCategoryPage extends StatelessWidget {
  const AllCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryDisplayCubit()..getCategories(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackIconAppbar(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              _textAboveCate(context),
              const SizedBox(height: 20),
              _categories(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textAboveCate(BuildContext context) {
    return const Text(
      "List Category",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Widget _categories(BuildContext context) {
    return BlocBuilder<CategoryDisplayCubit, CategoryDisplayState>(
      builder: (context, state) {
        if (state is CategoryDisplayLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CategoryDisplaySuccessState) {
          return Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AppNavigator.push(context,
                          CategoryProductPage(category: state.listCate[index]));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      height: 100,
                      decoration: const BoxDecoration(
                          color: AppColors.secondBackground,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      NetworkImage(state.listCate[index].imageUrl),
                                  fit: BoxFit.fill),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(state.listCate[index].name),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: state.listCate.length),
          );
        }
        return Container();
      },
    );
  }
}
