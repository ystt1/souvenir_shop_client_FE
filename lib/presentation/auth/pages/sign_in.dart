import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/data/auth/models/user_signin_req.dart';
import 'package:souvenir_shop/presentation/auth/pages/enter_password.dart';
import 'package:souvenir_shop/presentation/auth/pages/sign_up.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController _emailController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _signInText(context),
            _emailField(context),
            _buttonLogin(context),
            _createAccount(context)
          ],
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return const Text(
      "Sign In",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
          hintText: 'Enter UserName', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AppNavigator.push(context, EnterPasswordPage(
          user: UserSignInReq(userName: _emailController.text),
        ));
      },
      child: const Text("Continue"),
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: "Don't have account? ",
          style: TextStyle(color: AppColors.textColor)),
      TextSpan(
        recognizer: TapGestureRecognizer()..onTap=(){
          AppNavigator.push(context, const SignUpPage());
        },
          text: "Create One", style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.textColor))
    ]));
  }
}
