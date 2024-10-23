import 'package:souvenir_shop/domain/product/entity/product.dart';

abstract class NewInProductDisplayState{}

class LoadingNewInProductDisplayState extends NewInProductDisplayState{}

class LoadingSuccessNewInProductDisplayState extends NewInProductDisplayState{
  final List<ProductEntity> newIn;

  LoadingSuccessNewInProductDisplayState({required this.newIn});

}

class LoadingFailureNewInProductDisplayState extends NewInProductDisplayState{}