import 'package:souvenir_shop/domain/product/entity/product.dart';

abstract class GetProductByIdState{}


class GetProductByIdInitial extends GetProductByIdState{}
class GetProductByIdLoading extends GetProductByIdState{}

class GetProductByIdFailure extends GetProductByIdState{
  final String errorMsg;

  GetProductByIdFailure({required this.errorMsg});
}

class GetProductByIdSuccess extends GetProductByIdState{
  final ProductEntity product;

  GetProductByIdSuccess({required this.product});
}
