import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/setting/usecase/get_list_order_usecase.dart';
import 'package:souvenir_shop/presentation/setting/bloc/list_order_state.dart';

import '../../../service_locator.dart';

class ListOrderCubit extends Cubit<ListOrderState> {
  ListOrderCubit() : super(ListOrderInitial());

  Future<void> onGet() async {
    emit(ListOrderLoading());
    try {
      var returnedData = await sl<GetListOrderUseCase>().call();
      returnedData.fold((error) {
        emit(ListOrderFailure(errorMsg: error));
      }, (data) {
        emit(ListOrderSuccess(orders: data));
      });
    } catch (e) {
      print(e.toString());
      emit(ListOrderFailure(errorMsg: e.toString()));
    }
  }
}
