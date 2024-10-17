import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/theme.dart';
import 'package:souvenir_shop/presentation/splash/bloc/splash_cubit.dart';
import 'package:souvenir_shop/presentation/splash/pages/splash.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashCubit()..appStarted() ,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        home: const SplashPage()
      ),
    );
  }
}


