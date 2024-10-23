import 'package:souvenir_shop/domain/category/entity/category_entity.dart';

abstract class CategoryDisplayState{}

class CategoryDisplayLoadingState extends CategoryDisplayState{}

class CategoryDisplaySuccessState extends CategoryDisplayState{
  final List<CategoryEntity> listCate;

  CategoryDisplaySuccessState({required this.listCate});
}

class CategoryDisplayFailureState extends CategoryDisplayState{}