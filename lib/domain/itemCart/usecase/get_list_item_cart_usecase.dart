import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';
import 'package:souvenir_shop/domain/itemCart/repository/item_cart_repository.dart';

import '../../../service_locator.dart';

class GetListItemCartUseCase implements UseCase<Either,dynamic>
{
  @override
  Future<Either> call({params}) async {

    return await sl<ItemCartRepository>().getListItemOnCart();
  }

}