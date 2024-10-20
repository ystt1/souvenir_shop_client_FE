import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/data/auth/models/user_creation_req.dart';
import 'package:souvenir_shop/domain/auth/repository/auth_repository.dart';

import '../../../service_locator.dart';

class SignUpUseCase implements UseCase<Either,UserCreationReq>{
  @override
  Future<Either> call({UserCreationReq ? params})  async{
    return await sl<AuthRepository>().signUp(params!);
  }
}