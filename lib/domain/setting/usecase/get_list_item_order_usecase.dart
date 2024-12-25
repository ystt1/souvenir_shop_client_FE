import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../repository/setting_repository.dart';

class GetListItemOrderUseCase implements UseCase<Either,String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SettingRepository>().getListItemOrder(params!);
  }

}