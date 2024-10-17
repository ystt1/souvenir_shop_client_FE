import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/presentation/auth/pages/enter_password.dart';

class ForgotPassWordPage extends StatefulWidget {
  const ForgotPassWordPage({super.key});

  @override
  State<ForgotPassWordPage> createState() => _ForgotPassWordPageState();
}

class _ForgotPassWordPageState extends State<ForgotPassWordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _forgotPassword(context),
            _emailField(context),
            _buttonForgotPassword(context)
          ],
        ),
      ),
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Text(
      "Forgot Password",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Enter email', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _buttonForgotPassword(BuildContext context) {
    return ElevatedButton(
      onPressed: () {

      },
      child: Text("Continue"),
    );
  }


}
