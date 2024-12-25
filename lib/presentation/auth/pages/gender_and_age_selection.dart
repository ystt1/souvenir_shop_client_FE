import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/auth/auth_state_cubit.dart';
import 'package:souvenir_shop/common/bloc/button/button_state.dart';
import 'package:souvenir_shop/common/bloc/button/button_state_cubit.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';

import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/data/auth/models/user_creation_req.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_up_usecase.dart';

import 'package:souvenir_shop/presentation/auth/bloc/gender_cubit.dart';
import 'package:souvenir_shop/presentation/home/pages/home_page.dart';

import '../../../common/bloc/auth/auth_state.dart';
import '../../../common/widget/reactive_button.dart';

class GenderAndAgeSelection extends StatefulWidget {
  final UserCreationReq userCreationReq;

  const GenderAndAgeSelection({super.key, required this.userCreationReq});

  @override
  State<GenderAndAgeSelection> createState() => _GenderAndAgeSelectionState();
}

class _GenderAndAgeSelectionState extends State<GenderAndAgeSelection> {
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconAppbar(),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GenderCubit()),
          BlocProvider(create: (context) => ButtonStateCubit())
        ],
        child: BlocListener<AuthStateCubit, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is AuthLoading) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                child: CircularProgressIndicator(),
              )));
            }
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                child: Text("Đăng kí thành công"),
              )));
              AppNavigator.pushReplacement(context, const HomePage());
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                child: Text(state.errorMessage),
              )));
            }
          },
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _tellUs(context),
                      SizedBox(height: 20,),
                      _genderSelection(context),
                      SizedBox(height: 20,),
                      _address(context),
                      SizedBox(height: 20,),
                      _ageSelection(context)
                    ]),
              ),
              const Spacer(),
              _finishButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tellUs(BuildContext context) {
    return const Text(
      "Tell more about yourself",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  Widget _genderSelection(BuildContext context) {
    return BlocBuilder<GenderCubit, bool>(
        builder: (BuildContext context, bool state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _genderTitle(context, "Men", true),
          const SizedBox(
            width: 20,
          ),
          _genderTitle(context, "Women", false),
        ],
      );
    });
  }

  Widget _genderTitle(BuildContext context, String gender, bool index) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.read<GenderCubit>().selectedGender(index);
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: context.read<GenderCubit>().state == index
                ? AppColors.primary
                : AppColors.secondBackground,
            border: Border.all(width: 0),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(child: Text(gender)),
        ),
      ),
    );
  }

  Widget _address(BuildContext context) {
    return const Text("Where are you from?");
  }

  Widget _ageSelection(BuildContext context) {
    return TextField(
      controller: _addressController,
      decoration: const InputDecoration(hintText: "Enter Address"),
    );
  }

  Widget _finishButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 16, left: 16),
        child: Builder(builder: (context) {
          return ReactiveButton(
              onPressed: () {
                widget.userCreationReq.gender =
                    context.read<GenderCubit>().state;
                widget.userCreationReq.address = _addressController.text;
                UserCreationReq userCreationReq = UserCreationReq(
                    email: widget.userCreationReq.email,
                    userName: widget.userCreationReq.userName,
                    password: widget.userCreationReq.password,
                    fullName: widget.userCreationReq.fullName,
                    phoneNumber: widget.userCreationReq.phoneNumber,
                    address: _addressController.text,
                    avatarUrl: "test",
                    gender: context.read<GenderCubit>().state);
                context
                    .read<AuthStateCubit>()
                    .execute(usecase: SignUpUseCase(), params: userCreationReq);
              },
              widget: const Text("finish"));
        }));
  }
}
