import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/button/button_state_cubit.dart';
import 'package:souvenir_shop/common/widget/reactive_button.dart';

import 'package:souvenir_shop/domain/itemCart/usecase/add_item_cart_usecase.dart';
import 'package:souvenir_shop/domain/product/entity/product.dart';
import 'package:souvenir_shop/presentation/product_detail/bloc/product_amount_cubit.dart';

import '../../../data/item_cart/model/item_cart_add_req.dart';
import '../../../service_locator.dart';

class ButtonAddToCart extends StatelessWidget {
  final ProductEntity product;

  const ButtonAddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ReactiveButton(
      widget: Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<ProductAmountCubit, int>(builder: (builder, state) {
              return Text((state * product.discountPrice).toStringAsFixed(2));
            }),
            const Text("add to cart")
          ],
        );
      }),
      onPressed: () {
        context.read<ButtonStateCubit>().execute(
            usecase: AddItemCartUseCase(),
            params: ItemCartAddReq(
                productId: product.id,
                quantity: context.read<ProductAmountCubit>().state));
      },
    );
  }
}
