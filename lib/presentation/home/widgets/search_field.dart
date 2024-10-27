import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/presentation/search/page/search_page.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        AppNavigator.push(context, SearchPage());
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
  }
}
