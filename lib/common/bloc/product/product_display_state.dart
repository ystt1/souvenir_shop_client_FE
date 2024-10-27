import 'package:souvenir_shop/domain/product/entity/product.dart';

class ProductDisplayState{}
class ProductInitialState extends ProductDisplayState{}

class ProductLoadingState extends ProductDisplayState{}

class ProductLoadingSuccessState extends ProductDisplayState{
  final List<ProductEntity> products;

  ProductLoadingSuccessState({required this.products});
}

class ProductLoadingFailureState extends ProductDisplayState{}