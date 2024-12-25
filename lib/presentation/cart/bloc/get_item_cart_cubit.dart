import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/itemCart/usecase/get_list_item_cart_usecase.dart';
import 'package:souvenir_shop/presentation/cart/bloc/get_item_cart_state.dart';

import '../../../service_locator.dart';

class GetItemCartCubit extends Cubit<GetItemCartState> {
  GetItemCartCubit() : super(GetItemCartInitial());

  Future<void> onGet() async {
    emit(GetItemCartLoading());
    try {
      var returnedData = await sl<GetListItemCartUseCase>().call();
      returnedData.fold((error) {
        emit(GetItemCartFailure(errorMsg: error));
      }, (data) {
        emit(GetItemCartSuccess(carts: data));
      });
    } catch (e) {
      emit(GetItemCartFailure(errorMsg: e.toString()));
    }
  }
}
