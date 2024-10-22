import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/button/button_state.dart';
import 'package:souvenir_shop/common/bloc/button/button_state_cubit.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/common/widget/reactive_button.dart';
import 'package:souvenir_shop/data/auth/models/user_signin_req.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_in_usecase.dart';
import 'package:souvenir_shop/presentation/auth/pages/forgot_password.dart';

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
        child: BlocListener<ButtonStateCubit,ButtonState>(
          listener: (BuildContext context, state) {
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is ButtonSuccessState) {
              var snackBar = SnackBar(
                content: Text("sign-in-success"),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
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
    return Text(
      "Password",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
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
                .read<ButtonStateCubit>()
                .execute(params: widget.user, usecase: SignInUseCase());
          },
          title: 'Login',
        );
      },
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "Forgor password?",
          style: TextStyle(color: AppColors.textColor)),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, ForgotPassWordPage());
            },
          text: "Get Now",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textColor))
    ]));
  }
}
