import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/setting/repository/setting_repository.dart';

import '../../../service_locator.dart';

class GetListFavoriteProductUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SettingRepository>().getListFavorite();
  }

}