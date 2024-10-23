import 'package:souvenir_shop/domain/product/entity/product.dart';

abstract class TopSellingProductDisplayState{}

class LoadingTopSellingProductDisplayState extends TopSellingProductDisplayState{}

class LoadingSuccessTopSellingProductDisplayState extends TopSellingProductDisplayState{
  final List<ProductEntity> topSelling;

  LoadingSuccessTopSellingProductDisplayState({required this.topSelling});

}

class LoadingFailureTopSellingProductDisplayState extends TopSellingProductDisplayState{}