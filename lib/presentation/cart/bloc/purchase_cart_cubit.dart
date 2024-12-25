import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/itemCart/usecase/purchase_cart_usecase.dart';
import 'package:souvenir_shop/presentation/cart/bloc/purchase_cart_state.dart';

import '../../../service_locator.dart';

class PurchaseCartCubit extends Cubit<PurchaseCartState> {
  PurchaseCartCubit() : super(PurchaseCartInitial());

  Future<void> onGet(List<String> ids) async {
    emit(PurchaseCartLoading());
    try {
      var returnedData = await sl<PurchaseCartUseCase>().call(params: ids);
      returnedData.fold((error) => emit(PurchaseCartFailure(errorMsg: error)),
          (data) {
        emit(PurchaseCartSuccess(purchaseGetEntity: data));
      });
    } catch (e) {
      emit(PurchaseCartFailure(errorMsg: e.toString()));
    }
  }
}
