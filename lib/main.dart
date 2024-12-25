import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/theme.dart';
import 'package:souvenir_shop/firebase_options.dart';
import 'package:souvenir_shop/presentation/auth/pages/sign_in.dart';
import 'package:souvenir_shop/presentation/auth/pages/sign_up.dart';
import 'package:souvenir_shop/presentation/home/pages/home_page.dart';

import 'package:souvenir_shop/presentation/splash/bloc/splash_cubit.dart';
import 'package:souvenir_shop/presentation/splash/pages/splash.dart';
import 'package:souvenir_shop/service_locator.dart';

import 'common/bloc/auth/auth_state.dart';
import 'common/bloc/auth/auth_state_cubit.dart';
import 'core/user_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await UserStorage.init();
  final authCubit = AuthStateCubit();
  await authCubit.checkLoginStatus();
  runApp(
    BlocProvider(
      create: (context) => authCubit,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SplashCubit()..appStarted()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: appTheme,
          home: BlocBuilder<AuthStateCubit, AuthState>(
              builder: (BuildContext context, AuthState state) {
            if (state is AuthSuccess) {
              return HomePage();
            }
            return SignInPage();
          }),
        ));
  }
}
