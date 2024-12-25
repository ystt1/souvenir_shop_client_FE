import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/auth/models/user.dart';
import 'package:souvenir_shop/data/auth/models/user_creation_req.dart';
import 'package:souvenir_shop/data/auth/models/user_signin_req.dart';
import 'package:souvenir_shop/data/auth/source/auth_dot_net_service.dart';
import 'package:souvenir_shop/data/auth/source/auth_firebase_service.dart';
import 'package:souvenir_shop/domain/auth/repository/auth_repository.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_in_usecase.dart';
import 'package:souvenir_shop/service_locator.dart';

class AuthRepositoryImp extends AuthRepository {
  @override
  Future<Either> signUp(UserCreationReq user) async {
    return await sl<AuthDotNetService>().register(user);
  }

  @override
  Future<Either> getAges() async {
    return Left("acb");
  }

  @override
  Future<Either> signIn(UserSignInReq user) async {
    return await sl<AuthDotNetService>().login(user);
  }

  @override
  Future<bool> isLogged() async {
    return true;
    // return await sl<AuthFirebaseService>().isLogged();
  }

  @override
  Future<Either> getCurrentUser() async {

    return Left("acb");
      // var user = await sl<AuthFirebaseService>().getCurrentUser();
      // return user.fold((error) {
      //   return Left(error);
      // }, (data) {
      //   return Right(UserModel.fromMap(data).toEntity());
      // });


  }
}
