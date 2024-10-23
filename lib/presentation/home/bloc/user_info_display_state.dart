import 'package:souvenir_shop/domain/auth/entity/user_entity.dart';

abstract class UserInfoState{}

class LoadingUserState extends UserInfoState{}

class LoadingSuccessUserState extends UserInfoState{
  final UserEntity user;

  LoadingSuccessUserState({required this.user});

}

class LoadingFailureUserState extends UserInfoState{}