import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/domain/auth/usecase/get_current_user_usecase.dart';
import 'package:souvenir_shop/presentation/home/bloc/user_info_display_state.dart';
import 'package:souvenir_shop/service_locator.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoState>{
  UserInfoDisplayCubit():super(LoadingUserState());

  void displayUserInfo()
  async {
    var user= await sl<GetCurrentUserUseCase>().call();
    user.fold((error){
      return emit(LoadingFailureUserState());
    }, (data){

      return emit(LoadingSuccessUserState(user: data));
    });
  }

}