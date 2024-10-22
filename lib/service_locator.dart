import 'package:get_it/get_it.dart';
import 'package:souvenir_shop/data/auth/repository/auth_repository_imp.dart';
import 'package:souvenir_shop/data/auth/source/auth_firebase_service.dart';
import 'package:souvenir_shop/domain/auth/repository/auth_repository.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_in_usecase.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_up_usecase.dart';



final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //service

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaserServiceImp());

  //repo
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp());
  //usecase

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());

  sl.registerSingleton<SignInUseCase>(SignInUseCase());

}
