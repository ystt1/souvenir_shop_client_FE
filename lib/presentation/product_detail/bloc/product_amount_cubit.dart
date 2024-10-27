import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAmountCubit extends Cubit<int> {
  ProductAmountCubit() : super(1);

  void increase() {
    return emit(state + 1);
  }

  void decrease() {
    if (state != 1) {
      return emit(state - 1);
    }
  }
}
