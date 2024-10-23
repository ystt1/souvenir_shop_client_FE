import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          fillColor: AppColors.secondBackground,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          prefixIcon: Icon(Icons.search,color: CupertinoColors.white,),
          hintText: "Search",
          hintStyle: TextStyle(color: CupertinoColors.white),),
    );
  }
}
