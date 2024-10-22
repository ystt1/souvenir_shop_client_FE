import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/presentation/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState>{
  SplashCubit():super(SplashDisplay());
  Future<void> appStarted() async {
    await Future.delayed(Duration(seconds: 0));
    emit(UnAuthenticated());
  }
}