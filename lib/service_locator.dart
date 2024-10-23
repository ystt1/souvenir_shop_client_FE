import 'package:get_it/get_it.dart';
import 'package:souvenir_shop/data/auth/repository/auth_repository_imp.dart';
import 'package:souvenir_shop/data/auth/source/auth_firebase_service.dart';
import 'package:souvenir_shop/data/category/repository/category_repository_imp.dart';
import 'package:souvenir_shop/data/category/source/category_firebase_service.dart';
import 'package:souvenir_shop/data/product/repository/product_repository_imp.dart';
import 'package:souvenir_shop/data/product/source/product_firebase_service.dart';
import 'package:souvenir_shop/domain/auth/repository/auth_repository.dart';
import 'package:souvenir_shop/domain/auth/usecase/get_current_user_usecase.dart';
import 'package:souvenir_shop/domain/auth/usecase/is_logged_usecase.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_in_usecase.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_up_usecase.dart';
import 'package:souvenir_shop/domain/category/repository/category_repository.dart';
import 'package:souvenir_shop/domain/category/usecase/get_category_usecase.dart';
import 'package:souvenir_shop/domain/product/repository/product_repository.dart';
import 'package:souvenir_shop/domain/product/usecase/get_new_in_products_usecase.dart';
import 'package:souvenir_shop/domain/product/usecase/get_top_selling_product_usecase.dart';



final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //service

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaserServiceImp());

  sl.registerSingleton<CategoryFireBaseService>(CategoryFireBaseServiceImp());

  sl.registerSingleton<ProductFirebaseService>(ProductFirebaseServiceImp());

  //repo
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp());

  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImp());

  sl.registerSingleton<ProductRepository>(ProductRepositoryImp());
  //usecase

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());

  sl.registerSingleton<SignInUseCase>(SignInUseCase());

  sl.registerSingleton<IsLoggedUseCase>(IsLoggedUseCase());

  sl.registerSingleton<GetCurrentUserUseCase>(GetCurrentUserUseCase());

  sl.registerSingleton<GetCategoryUseCase>(GetCategoryUseCase());

  sl.registerSingleton<GetTopSellingProductUseCase>(GetTopSellingProductUseCase());

  sl.registerSingleton<GetNewInProductUseCase>(GetNewInProductUseCase());

}
