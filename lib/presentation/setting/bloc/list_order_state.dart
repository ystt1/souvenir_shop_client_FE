import 'package:souvenir_shop/domain/setting/entity/order_entity.dart';

abstract class ListOrderState{}
class ListOrderInitial extends ListOrderState{}

class ListOrderLoading extends ListOrderState{}

class ListOrderSuccess extends ListOrderState{
  final List<OrderEntity> orders;

  ListOrderSuccess({required this.orders});
}

class ListOrderFailure extends ListOrderState{
  final String errorMsg;

  ListOrderFailure({required this.errorMsg});

}