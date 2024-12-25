import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/bloc/button/button_state.dart';
import 'package:souvenir_shop/common/bloc/button/button_state_cubit.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/domain/itemCart/entity/item_cart_entity.dart';
import 'package:souvenir_shop/domain/itemCart/entity/purchase_get_entity.dart';
import 'package:souvenir_shop/domain/itemCart/usecase/place_order_usecase.dart';
import 'package:souvenir_shop/presentation/cart/bloc/purchase_cart_cubit.dart';
import 'package:souvenir_shop/presentation/cart/bloc/purchase_cart_state.dart';
import 'package:souvenir_shop/presentation/cart/widget/item_purchase_card.dart';
import 'package:souvenir_shop/presentation/home/pages/home_page.dart';

import '../../../common/helper/change_time.dart';

class PurchasePage extends StatelessWidget {
  final List<CartItemEntity> carts;

  const PurchasePage({
    super.key,
    required this.carts,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Summary"),
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) =>
                PurchaseCartCubit()..onGet(carts.map((e) => e.id).toList()),
          ),
          BlocProvider(create: (BuildContext context) => ButtonStateCubit())
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (BuildContext context, state) {
            if (state is ButtonLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                child: CircularProgressIndicator(),
              )));
            }
            if (state is ButtonFailureState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                child: Text(state.errorMessage),
              )));
            }
            if (state is ButtonSuccessState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                child: Text("place order success"),
              )));
              AppNavigator.pushReplacement(context, HomePage());
            }
          },
          child: Column(
            children: [
              _listProduct(),
              Builder(builder: (context) {
                return BlocBuilder<PurchaseCartCubit, PurchaseCartState>(
                  builder: (BuildContext context, PurchaseCartState state) {
                    if (state is PurchaseCartLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is PurchaseCartFailure) {
                      return Center(
                        child: Text(state.errorMsg),
                      );
                    }
                    if (state is PurchaseCartSuccess) {
                      return _conclusion(state.purchaseGetEntity);
                    }
                    return const Center(
                      child: Text('Some thing went wrong'),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _listProduct() {
    return Expanded(
      child: ListView.builder(
        itemCount: carts.length,
        itemBuilder: (context, index) {
          final cartItem = carts[index];
          final product = cartItem.product;
          final price = product.discountPrice > 0
              ? product.discountPrice
              : product.basePrice;

          return ItemPurchaseCard(
              cartItem: cartItem, product: product, price: price);
        },
      ),
    );
  }

  Widget _conclusion(PurchaseGetEntity purchase) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _totalPrice(purchase.total),
          const SizedBox(height: 8.0),
          _time(purchase.time),
          const SizedBox(height: 16.0),
          _placeOrderBtn(purchase)
        ],
      ),
    );
  }

  Widget _totalPrice(double total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Total Price:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "\$${total.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _time(String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Thời gian đặt hàng:",
          style: TextStyle(fontSize: 14),
        ),
        Text(
          formatDateTime(time),
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _placeOrderBtn(PurchaseGetEntity purchase) {
    return Builder(builder: (context) {
      return ElevatedButton(
        onPressed: () {
          context
              .read<ButtonStateCubit>()
              .execute(usecase: PlaceOrderUseCase(), params: purchase);
        },
        child: const Text("Place Order"),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
      );
    });
  }
}
