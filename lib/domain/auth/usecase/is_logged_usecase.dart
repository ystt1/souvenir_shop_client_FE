import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/auth/repository/auth_repository.dart';

import '../../../service_locator.dart';

class IsLoggedUseCase implements UseCase<bool,dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLogged();
  }
}