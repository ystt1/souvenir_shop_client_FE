import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/domain/itemCart/entity/item_cart_entity.dart';
import 'package:souvenir_shop/presentation/cart/bloc/get_item_cart_cubit.dart';
import 'package:souvenir_shop/presentation/cart/bloc/get_item_cart_state.dart';
import 'package:souvenir_shop/presentation/cart/page/purchase_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItemEntity> selectedItems = []; // Danh sách các sản phẩm được chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconAppbar(),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          var cubit = GetItemCartCubit();
          cubit.onGet();
          return cubit;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(child: _products(context)),
              const SizedBox(height: 10),
              _totalPrice(),
              const SizedBox(height: 10),
              _totalOriginalPrice(), // Displaying total original price with strike-through
              const SizedBox(height: 10),
              _buttonCheckOut(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _products(BuildContext context) {
    return BlocBuilder<GetItemCartCubit, GetItemCartState>(builder: (BuildContext context, state) {
      if (state is GetItemCartLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is GetItemCartFailure) {
        return Center(child: Text(state.errorMsg));
      }
      if (state is GetItemCartSuccess) {
        final cartItems = state.carts;
        if (cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty.'));
        }
        return ListView.separated(
          itemBuilder: (context, int index) {
            final cartItem = cartItems[index];
            return _cartItemTile(cartItem);
          },
          separatorBuilder: (context, int index) => const Divider(color: Colors.grey),
          itemCount: cartItems.length,
        );
      }
      return const Placeholder();
    });
  }

  Widget _cartItemTile(CartItemEntity cartItem) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: Image.network(
        cartItem.product.imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
      title: Text(
        cartItem.product.name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quantity: ${cartItem.quantity}',
            style: const TextStyle(color: Colors.grey),
          ),
          Row(
            children: [

              Text(
                '\$${cartItem.product.basePrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                  decoration: TextDecoration.lineThrough, // Strike-through
                ),
              ),
              const SizedBox(width: 8.0),
              // Current Discounted Price
              Text(
                '\$${cartItem.product.discountPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Checkbox(
        value: selectedItems.contains(cartItem),
        onChanged: (value) {
          setState(() {
            if (value == true) {
              selectedItems.add(cartItem);
            } else {
              selectedItems.remove(cartItem);
            }
          });
        },
      ),
    );
  }

  Widget _totalPrice() {
    final totalPrice = selectedItems.fold<double>(
      0.0,
          (sum, item) => sum + (item.product.discountPrice * item.quantity),
    );
    return _labelAndMoney('Total:', '\$${totalPrice.toStringAsFixed(2)}');
  }

  Widget _totalOriginalPrice() {
    final totalOriginalPrice = selectedItems.fold<double>(
      0.0,
          (sum, item) => sum + (item.product.basePrice * item.quantity),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Original Total:',
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          '\$${totalOriginalPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[500],
            decoration: TextDecoration.lineThrough, // Strike-through effect
          ),
        ),
      ],
    );
  }

  Widget _labelAndMoney(String label, String money) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          money,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buttonCheckOut() {
    return ElevatedButton(
      onPressed: selectedItems.isNotEmpty
          ? () {
        AppNavigator.push(context, PurchasePage(carts: selectedItems));
      }
          : null,
      child: const Text('Check Out'),
    );
  }
}
