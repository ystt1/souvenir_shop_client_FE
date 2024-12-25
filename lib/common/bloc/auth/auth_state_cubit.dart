import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/bloc/auth/user_entity.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/user_storage.dart';

import 'auth_state.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AuthLoading());

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    print("cubit:" +params.toString() +params.runtimeType.toString());
    try {
      Either returnedData = await usecase.call(params: params);
      returnedData.fold((error) {
        emit(AuthFailure(errorMessage: error));
      }, (data) async {
        await UserStorage.setEmail(data.email);
        await UserStorage.setUserName(data.userName);
        await UserStorage.setToken(data.token);
        await UserStorage.setIsLogged(true);
        emit(AuthSuccess(user: data));
      });
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = UserStorage.getIsLogged() ?? false;

    if (isLoggedIn) {
      emit(AuthSuccess(
          user: AuthEntity(
              email: UserStorage.getEmail()!,
              userName: UserStorage.getUserName()!,
              token: UserStorage.getToken()!)));
    } else {
      emit(AuthLoading());
    }
  }

  Future<void> logOut() async {
    UserStorage.setIsLogged(false);
    emit(AuthLoading());
  }
}
