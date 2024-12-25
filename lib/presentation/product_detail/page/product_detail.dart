import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/button/button_state_cubit.dart';
import 'package:souvenir_shop/common/helper/change_time.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import 'package:souvenir_shop/presentation/product_detail/bloc/product_amount_cubit.dart';
import 'package:souvenir_shop/presentation/product_detail/widgets/button_add_to_cart.dart';

import '../../../common/bloc/button/button_state.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductAmountCubit()),
        BlocProvider(create: (_) => ButtonStateCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const BackIconAppbar(),
          actions: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                final snackBarMessage = isFavorite
                    ? 'Added to Favorites!'
                    : 'Removed from Favorites!';
                _showSnackBar(context, snackBarMessage);
              },
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            return BlocListener<ButtonStateCubit, ButtonState>(
              listener: (context, state) {
                if (state is ButtonFailureState) {
                  _showSnackBar(context, state.errorMessage);
                } else if (state is ButtonSuccessState) {
                  _showSnackBar(context, "Add to cart success");
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _productImage(),
                      const SizedBox(height: 16),
                      _productTitleAndPrice(),
                      const SizedBox(height: 16),
                      Text(
                        widget.product.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoSection('Stock:', '${widget.product.stockQuantity}'),
                      _buildInfoSection('Sold:', '${widget.product.soldQuantity}'),
                      _buildInfoSection('Created Date:', formatDateTime(widget.product.createdDate)),
                      const SizedBox(height: 24),
                      _amountProduct(context),
                      const SizedBox(height: 16),
                      Builder(builder: (context) {
                        return ButtonAddToCart(product: widget.product);
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _productImage() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          widget.product.imageUrl,
          height: 300,
          width: 300,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const SizedBox(
              height: 300,
              width: 300,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              height: 300,
              width: 300,
              child: Center(
                child: Icon(Icons.error),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _productTitleAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${widget.product.discountPrice}\$",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              "Original: ${widget.product.basePrice}\$",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoSection(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountProduct(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Amount',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ProductAmountCubit>().decrease();
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              BlocBuilder<ProductAmountCubit, int>(
                builder: (context, state) {
                  return Text(
                    state.toString(),
                    style: const TextStyle(fontSize: 16),
                  );
                },
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  context.read<ProductAmountCubit>().increase();
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
