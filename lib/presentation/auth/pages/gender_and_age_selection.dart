import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/button/button_state.dart';
import 'package:souvenir_shop/common/bloc/button/button_state_cubit.dart';

import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/data/auth/models/user_creation_req.dart';
import 'package:souvenir_shop/domain/auth/usecase/sign_up_usecase.dart';

import 'package:souvenir_shop/presentation/auth/bloc/gender_cubit.dart';

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
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is ButtonSuccessState) {
              var snackBar = SnackBar(
                content: Text("success"),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      _genderSelection(context),
                      _address(context),
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
    return BlocBuilder<GenderCubit, int>(
        builder: (BuildContext context, int state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _genderTitle(context, "Men", 1),
          const SizedBox(
            width: 20,
          ),
          _genderTitle(context, "Women", 2),
        ],
      );
    });
  }

  Widget _genderTitle(BuildContext context, String gender, int index) {
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
      decoration: InputDecoration(hintText: "Enter Address"),
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
                widget.userCreationReq.age = _addressController.text;
                context.read<ButtonStateCubit>().execute(
                    usecase: SignUpUseCase(), params: widget.userCreationReq);
              },
              title: "finish");
        }));
  }
}
