import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/presentation/auth/pages/enter_password.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconAppbar(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _signInText(context),
            _nameField(context),
            _emailField(context),
            _passwordField(context),
            _rePasswordField(context),
            _buttonLogin(context),
            _createAccount(context)
          ],
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return Text(
      "Create Account",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Email address', hintStyle: TextStyle(color: Colors.white)),
    );
  }
  Widget _nameField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Name', hintStyle: TextStyle(color: Colors.white)),
    );
  }
  Widget _passwordField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Password', hintStyle: TextStyle(color: Colors.white)),
    );
  }
  Widget _rePasswordField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Re-password', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AppNavigator.push(context, EnterPasswordPage());
      },
      child: Text("Continue"),
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: "Already have account? ",
              style: TextStyle(color: AppColors.textColor)),
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap=(){
                  Navigator.pop(context);
              },
              text: "Log In", style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.textColor))
        ]));
  }
}
