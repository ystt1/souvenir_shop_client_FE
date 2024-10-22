import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/data/auth/models/user_signin_req.dart';
import 'package:souvenir_shop/domain/auth/repository/auth_repository.dart';

import '../../../service_locator.dart';

class SignInUseCase implements UseCase<Either,UserSignInReq>{
  @override
  Future<Either> call({UserSignInReq ? params})  async{
    return await sl<AuthRepository>().signIn(params!);

  }

}