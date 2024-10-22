import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/auth/models/user_creation_req.dart';
import 'package:souvenir_shop/data/auth/models/user_signin_req.dart';
import 'package:souvenir_shop/data/auth/source/auth_firebase_service.dart';
import 'package:souvenir_shop/domain/auth/repository/auth_repository.dart';
import 'package:souvenir_shop/service_locator.dart';

class AuthRepositoryImp extends AuthRepository{
  @override
  Future<Either> signUp(UserCreationReq user) async {
    return await sl<AuthFirebaseService>().signUp(user);
  }

  @override
  Future<Either> getAges() async {
    return await sl<AuthFirebaseService>().getAges();
  }

  @override
  Future<Either> signIn(UserSignInReq user) async {
    return await sl<AuthFirebaseService>().signIn(user);
  }

}