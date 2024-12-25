import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../repository/setting_repository.dart';

class GetListOrderUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SettingRepository>().getListOrder();
  }

}