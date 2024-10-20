import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/bloc/button/button_state.dart';
import 'package:souvenir_shop/common/bloc/button/button_state_cubit.dart';

class ReactiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const ReactiveButton(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
      builder: (context, state) {
        if (state is ButtonLoadingState) {
          return _loading();
        }
        return _initial();
      },
    );
  }

  Widget _loading() {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(alignment: Alignment.center,
        child: const CircularProgressIndicator(),),);
  }

  Widget _initial() {
    return ElevatedButton(
        onPressed: onPressed,
        child: Container(alignment: Alignment.center,
            child: Text(title)));
  }
}
