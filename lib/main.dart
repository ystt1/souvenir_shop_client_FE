import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/theme.dart';
import 'package:souvenir_shop/firebase_options.dart';


import 'package:souvenir_shop/presentation/splash/bloc/splash_cubit.dart';
import 'package:souvenir_shop/presentation/splash/pages/splash.dart';
import 'package:souvenir_shop/service_locator.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
await initializeDependencies();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>SplashCubit()..appStarted()),

      ],

        child: MaterialApp(
          title: 'Flutter Demo',
          theme: appTheme,
          home: const SplashPage()
        ),
    );
  }
}


