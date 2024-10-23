

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/product/usecase/get_top_selling_product_usecase.dart';
import 'package:souvenir_shop/presentation/home/bloc/top_selling_product_display_state.dart';

import '../../../service_locator.dart';

class TopSellingProductDisplayCubit
    extends Cubit<TopSellingProductDisplayState> {
  TopSellingProductDisplayCubit()
      :super(LoadingTopSellingProductDisplayState());

  Future<void> getTopSelling() async {
    var data = await sl<GetTopSellingProductUseCase>().call();
    data.fold((error) {
      return emit(LoadingFailureTopSellingProductDisplayState());
    }, (data) {
      return emit(LoadingSuccessTopSellingProductDisplayState( topSelling: data));
    });
  }
}