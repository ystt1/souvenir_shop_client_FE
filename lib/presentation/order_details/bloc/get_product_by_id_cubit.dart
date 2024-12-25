import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/product/usecase/get_product_by_id_usecase.dart';
import 'package:souvenir_shop/presentation/order_details/bloc/get_product_by_id_state.dart';

import '../../../service_locator.dart';

class GetProductByIdCubit extends Cubit<GetProductByIdState> {
  GetProductByIdCubit() : super(GetProductByIdInitial());

  Future<void> onGet(String id) async {
    emit(GetProductByIdLoading());
    try {
      final returnedData = await sl<GetProductsByIdUseCase>().call(params: id);
      returnedData.fold((error) => emit(GetProductByIdFailure(errorMsg: error)),
          (data) => emit(GetProductByIdSuccess(product: data)));
    } catch (e) {
      emit(GetProductByIdFailure(errorMsg: e.toString()));
    }
  }
}
