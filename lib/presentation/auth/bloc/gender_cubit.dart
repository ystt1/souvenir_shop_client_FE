

import 'package:flutter_bloc/flutter_bloc.dart';

class GenderCubit extends Cubit<bool>{
  GenderCubit():super(false);


  void selectedGender(bool index)
  {

    emit(index);
  }
}