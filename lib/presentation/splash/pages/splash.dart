import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:souvenir_shop/core/configs/assets/app_vectors.dart';
import 'package:souvenir_shop/presentation/auth/pages/sign_in.dart';
import 'package:souvenir_shop/presentation/splash/bloc/splash_cubit.dart';
import 'package:souvenir_shop/presentation/splash/bloc/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit,SplashState>(
      listener: (BuildContext context, state) {
        if (state is UnAuthenticated) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  SignInPage()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Center(
          child: SvgPicture.asset(
            AppVector.logo,
            width: 500,
          ),
        ),
      ),
    );
  }
}
