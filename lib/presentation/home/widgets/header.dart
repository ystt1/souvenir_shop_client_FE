import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/core/user_storage.dart';
import 'package:souvenir_shop/domain/auth/entity/user_entity.dart';
import 'package:souvenir_shop/presentation/cart/page/cart_page.dart';
import 'package:souvenir_shop/presentation/home/bloc/user_info_display_cubit.dart';
import 'package:souvenir_shop/presentation/home/bloc/user_info_display_state.dart';
import 'package:souvenir_shop/presentation/setting/page/orders_page.dart';
import 'package:souvenir_shop/presentation/setting/page/setting_page.dart';

import '../../../common/app_colors.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _welcomeText(
              context,
            ),
            _iconCart(context),
          ],
        ));
  }

  Widget _welcomeText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, SettingPage());
      },
      child: RichText(
          text: TextSpan(
              style: const TextStyle(color: CupertinoColors.white),
              children: [
            const TextSpan(text: "Hello, "),
            TextSpan(
                text: UserStorage.getUserName(),
                style: const TextStyle(fontWeight: FontWeight.bold))
          ])),
    );
  }

  Widget _iconCart(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, CartPage());
      },
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: const Icon(
          CupertinoIcons.cart,
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}
