import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/button/button_state_cubit.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import 'package:souvenir_shop/presentation/product_detail/bloc/product_amount_cubit.dart';
import 'package:souvenir_shop/presentation/product_detail/widgets/button_add_to_cart.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (BuildContext context) => ProductAmountCubit()),
        BlocProvider(create: (BuildContext context) => ButtonStateCubit(),)
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const BackIconAppbar(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productImage(),
                _productTitleAndPrice(context),

                const SizedBox(height: 16),

                // Mô tả
                const Text(
                  'Traditional pattern ceramic vase from Bat Trang village',
                ),

                const SizedBox(height: 24),

                // Thông tin chi tiết
                _buildInfoSection('Chất liệu:', 'Ceramic'),
                _buildInfoSection('Xuất xứ:', 'Vietnam'),
                _buildInfoSection('Cân nặng:', '800g'),
                _buildInfoSection('Số lượng còn:', '250'),
                _buildInfoSection('Đã bán:', '122'),

                const SizedBox(height: 24),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTag('ceramic'),
                    _buildTag('bat trang'),
                    _buildTag('handcraft'),
                  ],
                ),
                _amountProduct(context),
                ButtonAddToCart(product: widget.product),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productImage() {
    return Image.network(
      widget.product.image,
      height: 300,
      width: 300,
      fit: BoxFit.fill,
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
    );
  }

  Widget _productTitleAndPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.product.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Stack(
          children: [
            Center(
              child: Text(
                "${widget.product.price}\$",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: Text(
                "-${widget.product.discount}",
                style: const TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Text(
        '#$tag',
        style: TextStyle(
          color: Colors.blue.shade700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _amountProduct(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              'Amount',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            flex: 1,
            child: Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ProductAmountCubit>().decrease();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.primary),
                        child: const Icon(Icons.minimize),
                      ),
                    ),
                    BlocBuilder<ProductAmountCubit, int>(
                      builder: (context, state) {
                        return Text(state.toString());
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<ProductAmountCubit>().increase();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.primary),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
