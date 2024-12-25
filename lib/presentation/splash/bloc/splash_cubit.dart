import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/auth/usecase/is_logged_usecase.dart';
import 'package:souvenir_shop/presentation/splash/bloc/splash_state.dart';

import '../../../service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashDisplay());

  Future<void> appStarted() async {
    await Future.delayed(const Duration(seconds: 0));
    // var isLogged = await sl<IsLoggedUseCase>().call();
    // if (isLogged) {
    //   emit(Authenticated());
    // } else {
    //   emit(UnAuthenticated());
    // }
  }
}
