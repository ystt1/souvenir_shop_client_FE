
import 'package:souvenir_shop/common/bloc/auth/user_entity.dart';

abstract class AuthState{}

class AuthSuccess extends AuthState{
  final AuthEntity user;

  AuthSuccess({required this.user});
}

class AuthLoading extends AuthState{}

class AuthFailure extends AuthState{
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}