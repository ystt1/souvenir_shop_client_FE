import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/presentation/setting/bloc/list_order_cubit.dart';
import 'package:souvenir_shop/presentation/setting/bloc/list_order_state.dart';
import 'package:souvenir_shop/presentation/setting/widgets/order_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => ListOrderCubit()..onGet(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const Text(
              "Your recent purchases",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            _orders(context)
          ]),
        ),
      ),
    );
  }

  Widget _orders(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<ListOrderCubit, ListOrderState>(
        builder: (BuildContext context, state) {
          if (state is ListOrderLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ListOrderFailure) {
            return Center(
              child: Text(state.errorMsg),
            );
          }
          if (state is ListOrderSuccess) {
            return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return  OrderCard(
                      order: state.orders[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: state.orders.length),
            );
          }
          return Center(
            child: Text("Some thing went wrong"),
          );
        },
      );
    });
  }
}
