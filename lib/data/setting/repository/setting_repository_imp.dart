import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/setting/model/order_model.dart';
import 'package:souvenir_shop/data/setting/source/setting_dotnet_service.dart';
import 'package:souvenir_shop/domain/setting/repository/setting_repository.dart';

import '../../../service_locator.dart';

class SettingRepositoryImp extends SettingRepository {
  @override
  Future<Either> getListFavorite() {
    // TODO: implement getListFavorite
    throw UnimplementedError();
  }

  @override
  Future<Either> getListItemOrder(String idOrder) {
    // TODO: implement getListItemOrder
    throw UnimplementedError();
  }

  @override
  Future<Either> getListOrder() async {
    try {
      final returnedData = await sl<SettingDotNetService>().getOrders();
      return returnedData.fold(
            (error) => Left(error),
            (data) {
          final orders =
          (data as List<OrderModel>).map((e) => e.toEntity()).toList();
          return Right(orders);
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
