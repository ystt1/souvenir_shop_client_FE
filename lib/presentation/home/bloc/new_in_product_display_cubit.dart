import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/product/usecase/get_new_in_products_usecase.dart';

import 'package:souvenir_shop/presentation/home/bloc/new_in_product_state.dart';
import '../../../service_locator.dart';

class NewInProductDisplayCubit extends Cubit<NewInProductDisplayState> {
  NewInProductDisplayCubit()
      :super(LoadingNewInProductDisplayState());

  Future<void> getNewIn() async {
    var data = await sl<GetNewInProductUseCase>().call();
    data.fold((error) {
      return emit(LoadingFailureNewInProductDisplayState());
    }, (data) {
      return emit(LoadingSuccessNewInProductDisplayState(newIn: data));
    });
  }
}