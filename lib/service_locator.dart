import 'package:get_it/get_it.dart';
import 'package:souvenir_shop/data/auth/repository/auth_repository_imp.dart';
import 'package:souvenir_shop/data/auth/source/auth_dot_net_service.dart';
import 'package:souvenir_shop/data/auth/source/auth_firebase_service.dart';
import 'package:souvenir_shop/data/category/repository/category_repository_imp.dart';
import 'package:souvenir_shop/data/category/source/category_dot_net_service.dart';
import 'package:souvenir_shop/data/category/source/category_firebase_service.dart';
import 'package:souvenir_shop/data/item_cart/source/item_cart_dotnet_service.dart';
import 'package:souvenir_shop/data/product/repository/product_repository_imp.dart';
import 'package:souvenir_shop/data/product/source/product_firebase_service.dart';
import 'package:souvenir_shop/data/setting/repository/setting_repository_imp.dart';
import 'package:souvenir_shop/data/setting/source/setting_dotnet_service.dart';
import 'package:souvenir_shop/domain/auth/repository/auth_repository.dart';
import 'package:souvenir_shop/domain/auth/usecase/get_current_user_usecase.dart';
import 'package:souvenir_shop/domain/auth/usecase/is_logged_usecase.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_in_usecase.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_up_usecase.dart';
import 'package:souvenir_shop/domain/category/repository/category_repository.dart';
import 'package:souvenir_shop/domain/category/usecase/get_category_usecase.dart';
import 'package:souvenir_shop/domain/itemCart/repository/item_cart_repository.dart';
import 'package:souvenir_shop/domain/itemCart/usecase/get_list_item_cart_usecase.dart';
import 'package:souvenir_shop/domain/itemCart/usecase/place_order_usecase.dart';
import 'package:souvenir_shop/domain/itemCart/usecase/purchase_cart_usecase.dart';
import 'package:souvenir_shop/domain/product/repository/product_repository.dart';
import 'package:souvenir_shop/domain/product/usecase/add_favorite_product_usecase.dart';
import 'package:souvenir_shop/domain/product/usecase/get_new_in_products_usecase.dart';
import 'package:souvenir_shop/domain/product/usecase/get_product_by_id_usecase.dart';
import 'package:souvenir_shop/domain/product/usecase/get_products_by_category_id_usecase.dart';
import 'package:souvenir_shop/domain/product/usecase/get_products_by_title_usecase.dart';
import 'package:souvenir_shop/domain/product/usecase/get_top_selling_product_usecase.dart';
import 'package:souvenir_shop/domain/setting/repository/setting_repository.dart';
import 'package:souvenir_shop/domain/setting/usecase/get_list_favorite_product_usecase.dart';
import 'package:souvenir_shop/domain/setting/usecase/get_list_item_order_usecase.dart';
import 'package:souvenir_shop/domain/setting/usecase/get_list_order_usecase.dart';

import 'data/item_cart/repository/item_cart_repository_imp.dart';
import 'data/item_cart/source/item_cart_firebase_service.dart';
import 'data/product/source/product_dot_net_service.dart';



final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //service

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaserServiceImp());

  sl.registerSingleton<CategoryFireBaseService>(CategoryFireBaseServiceImp());

  sl.registerSingleton<ProductFirebaseService>(ProductFirebaseServiceImp());

  sl.registerSingleton<ItemCartFirebaseService>(ItemCartFirebaseServiceImp());

  sl.registerSingleton<AuthDotNetService>(AuthDotNetServiceImp());
  sl.registerSingleton<CategoryDotNetService>(CategoryDotNetServiceImp());
  sl.registerSingleton<ProductDotNetService>(ProductDotNetServiceImp());
  sl.registerSingleton<ItemCartDotNetService>(ItemCartDotNetServiceImp());
  sl.registerSingleton<SettingDotNetService>(SettingDotNetServiceImp());

  //repo
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp());

  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImp());

  sl.registerSingleton<ProductRepository>(ProductRepositoryImp());

  sl.registerSingleton<ItemCartRepository>(ItemCartRepositoryImp());

  sl.registerSingleton<SettingRepository>(SettingRepositoryImp());
  //usecase

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());

  sl.registerSingleton<SignInUseCase>(SignInUseCase());

  sl.registerSingleton<IsLoggedUseCase>(IsLoggedUseCase());

  sl.registerSingleton<GetCurrentUserUseCase>(GetCurrentUserUseCase());

  sl.registerSingleton<GetCategoryUseCase>(GetCategoryUseCase());

  sl.registerSingleton<GetTopSellingProductUseCase>(GetTopSellingProductUseCase());

  sl.registerSingleton<GetNewInProductUseCase>(GetNewInProductUseCase());

  sl.registerSingleton<GetProductsByCategoryIdUseCase>(GetProductsByCategoryIdUseCase());

  sl.registerSingleton<GetProductsByTitleUseCase>(GetProductsByTitleUseCase());

  sl.registerSingleton<AddFavoriteProductUseCase>(AddFavoriteProductUseCase());

  sl.registerSingleton<GetListItemCartUseCase>(GetListItemCartUseCase());

  sl.registerSingleton<GetListFavoriteProductUseCase>(GetListFavoriteProductUseCase());

  sl.registerSingleton<GetListOrderUseCase>(GetListOrderUseCase());

  sl.registerSingleton<GetListItemOrderUseCase>(GetListItemOrderUseCase());

  sl.registerSingleton<PurchaseCartUseCase>(PurchaseCartUseCase());

  sl.registerSingleton<PlaceOrderUseCase>(PlaceOrderUseCase());

  sl.registerSingleton<GetProductsByIdUseCase>(GetProductsByIdUseCase());
}
