import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/auth/auth_state.dart';
import 'package:souvenir_shop/common/bloc/auth/auth_state_cubit.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _signInText(context),
                _emailField(context),
                _userNamePasswordField(context),
                _nameField(context),
                _passwordField(context),
                _buttonLogin(context),
                _createAccount(context)
              ],
            ),
          ),
        ),

    );
  }

  Widget _signInText(BuildContext context) {
    return const Text(
      "Create Account",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
          hintText: 'Email address', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _nameField(BuildContext context) {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
          hintText: 'Name', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(
          hintText: 'Password', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _userNamePasswordField(BuildContext context) {
    return TextField(
      controller: _rePasswordController,
      decoration: const InputDecoration(
          hintText: 'UserName', hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AppNavigator.push(
            context,
            GenderAndAgeSelection(
              userCreationReq: UserCreationReq(
                  email: _emailController.text,
                  userName: _rePasswordController.text,
                  password: _passwordController.text,
                  fullName: _nameController.text,
                  phoneNumber: '000000000',
                  address: '',
                  avatarUrl: 'null',
                  gender: true),
            ));
      },
      child: const Text("Continue"),
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: "Already have account? ",
          style: TextStyle(color: AppColors.textColor)),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pop(context);
            },
          text: "Log In",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textColor))
    ]));
  }
}
