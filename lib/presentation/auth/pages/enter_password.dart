import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/presentation/auth/pages/forgot_password.dart';
import 'package:souvenir_shop/presentation/auth/pages/sign_in.dart';

import '../../../common/helper/navigator/app_navigator.dart';

class EnterPasswordPage extends StatefulWidget {
  const EnterPasswordPage({super.key});

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:const BackIconAppbar()
      ),
      body: Padding(
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
      decoration: InputDecoration(
          hintText: 'Enter password',
          hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Login"),
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "Forgor password?",
          style: TextStyle(color: AppColors.textColor)),
      TextSpan(
          recognizer: TapGestureRecognizer()..onTap = () {
            AppNavigator.push(context, ForgotPassWordPage());
          },
          text: "Get Now",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textColor))
    ]));
  }
}
