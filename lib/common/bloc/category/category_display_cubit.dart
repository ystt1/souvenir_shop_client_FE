import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/bloc/category/category_display_state.dart';
import 'package:souvenir_shop/domain/category/usecase/get_category_usecase.dart';

import '../../../service_locator.dart';

class CategoryDisplayCubit extends Cubit<CategoryDisplayState> {
  CategoryDisplayCubit() : super(CategoryDisplayLoadingState());

  Future<void> getCategories() async {
    var categories = await sl<GetCategoryUseCase>().call();

    categories.fold((error) {
      return emit(CategoryDisplayFailureState());
    }, (data) {
      return emit(CategoryDisplaySuccessState(listCate: data));
    });
  }
}
