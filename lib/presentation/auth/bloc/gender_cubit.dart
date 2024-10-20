

import 'package:flutter_bloc/flutter_bloc.dart';

class GenderCubit extends Cubit<int>{
  GenderCubit():super(1);


  void selectedGender(int index)
  {

    emit(index);
  }
}