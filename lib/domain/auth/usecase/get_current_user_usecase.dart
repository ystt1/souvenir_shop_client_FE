import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/auth/repository/auth_repository.dart';

import '../../../service_locator.dart';

class GetCurrentUserUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call({params}) {
   return sl<AuthRepository>().getCurrentUser();
  }

}