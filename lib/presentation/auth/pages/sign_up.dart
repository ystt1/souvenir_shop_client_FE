import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/data/auth/models/user_creation_req.dart';
import 'package:souvenir_shop/presentation/auth/pages/gender_and_age_selection.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _rePasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconAppbar(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
        child: SingleChildScrollView(
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
      controller: _emailController,
      decoration: InputDecoration(
          hintText: 'Email address', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _nameField(BuildContext context) {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
          hintText: 'Name', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
          hintText: 'Password', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _rePasswordField(BuildContext context) {
    return TextField(
      controller: _rePasswordController,
      decoration: InputDecoration(
          hintText: 'Re-password', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AppNavigator.push(
            context,
            GenderAndAgeSelection(
              userCreationReq: UserCreationReq(
                  _nameController.text,
                  _emailController.text,
                  _emailController.text,
                  _rePasswordController.text,
                "acas",1
              ),
            ));
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
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pop(context);
            },
          text: "Log In",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textColor))
    ]));
  }
}
