import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/auth/auth_state.dart';
import 'package:souvenir_shop/common/bloc/auth/auth_state_cubit.dart';
import 'package:souvenir_shop/common/bloc/button/button_state.dart';
import 'package:souvenir_shop/common/bloc/button/button_state_cubit.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/common/widget/reactive_button.dart';
import 'package:souvenir_shop/data/auth/models/user_signin_req.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_in_usecase.dart';
import 'package:souvenir_shop/presentation/auth/pages/forgot_password.dart';
import 'package:souvenir_shop/presentation/home/pages/home_page.dart';

import '../../../common/helper/navigator/app_navigator.dart';

class EnterPasswordPage extends StatefulWidget {
  final UserSignInReq user;

  const EnterPasswordPage({super.key, required this.user});

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackIconAppbar()),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<AuthStateCubit, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              var snackBar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              var snackBar = const SnackBar(
                content: Text("sign-in-success"),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              AppNavigator.pushAndremove(context, const HomePage());
            }
            if (state is AuthLoading) {
              var snackBar = const SnackBar(
                content: Center(child: CircularProgressIndicator(),),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _passwordText(context),
                _passwordField(context),
                _buttonLogin(context),
                _forgotPassword(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordText(BuildContext context) {
    return const Text(
      "Password",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(
          hintText: 'Enter password',
          hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return ReactiveButton(
          onPressed: () {
            widget.user.password = _passwordController.text;
            context
                .read<AuthStateCubit>()
                .execute(params: widget.user, usecase: SignInUseCase());
          },
          widget: Text('login'),
        );
      },
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: "Forgor password?",
          style: TextStyle(color: AppColors.textColor)),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, const ForgotPassWordPage());
            },
          text: "Get Now",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textColor))
    ]));
  }
}
