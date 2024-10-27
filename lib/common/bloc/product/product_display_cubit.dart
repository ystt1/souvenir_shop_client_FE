import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_state.dart';
import 'package:souvenir_shop/core/usecase/usecase.dart';

class ProductDisplayCubit extends Cubit<ProductDisplayState> {
  final UseCase useCase;

  ProductDisplayCubit({required this.useCase}) : super(ProductInitialState());

  Future<void> getProducts({dynamic params}) async {
    emit(ProductLoadingState());
    var data = await useCase.call(params: params);
    data.fold((error) {
      return emit(ProductLoadingFailureState());
    }, (data) {
      return emit(ProductLoadingSuccessState(products: data));
    });
  }

  void getInitial()
  {
    return emit(ProductInitialState());
  }
}