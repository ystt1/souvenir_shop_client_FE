
import 'package:flutter/material.dart';
import 'package:souvenir_shop/presentation/home/widgets/categories.dart';
import 'package:souvenir_shop/presentation/home/widgets/header.dart';
import 'package:souvenir_shop/presentation/home/widgets/new_in_products.dart';
import 'package:souvenir_shop/presentation/home/widgets/search_field.dart';
import 'package:souvenir_shop/presentation/home/widgets/top_selling_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            SearchField(),
            Categories(),
            TopSellingProducts(),
            NewInProducts(),
          ],
        ),
      ),
    ));
  }
}
