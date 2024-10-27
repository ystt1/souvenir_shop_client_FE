import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/auth/entity/user_entity.dart';
import 'package:souvenir_shop/presentation/home/bloc/user_info_display_cubit.dart';
import 'package:souvenir_shop/presentation/home/bloc/user_info_display_state.dart';

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
      child: BlocBuilder<UserInfoDisplayCubit, UserInfoState>(
        builder: (BuildContext context, UserInfoState state) {
          if (state is LoadingUserState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoadingSuccessUserState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _welcomeText(context, state.user),
                _iconCart(context),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _welcomeText(BuildContext context, UserEntity user) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(color: CupertinoColors.white),
            children: [
          const TextSpan(text: "Hello,"),
          TextSpan(
              text: user.name, style: const TextStyle(fontWeight: FontWeight.bold))
        ]));
  }

  Widget _iconCart(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
      ),
      child: const Icon(
        CupertinoIcons.cart,
        color: CupertinoColors.white,
      ),
    );
  }
}
