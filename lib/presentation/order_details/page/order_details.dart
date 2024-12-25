import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souvenir_shop/common/app_colors.dart';
import 'package:souvenir_shop/common/bloc/product/product_display_cubit.dart';
import 'package:souvenir_shop/common/widget/back_icon_appbar.dart';
import 'package:souvenir_shop/domain/product/usecase/get_product_by_id_usecase.dart';
import 'package:souvenir_shop/domain/setting/entity/order_entity.dart';
import 'package:souvenir_shop/presentation/order_details/bloc/get_product_by_id_state.dart';

import '../bloc/get_product_by_id_cubit.dart';

class OrderDetails extends StatelessWidget {
  final OrderEntity order;

  const OrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackIconAppbar(),
        title: Text(
          'Order #${order.id.substring(0, 5)}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _statusTimeline(order.status),
            const SizedBox(height: 24),
            _labelTitle('Ordered Items'),
            const SizedBox(height: 8),
            _orderedItemsList(),
            const SizedBox(height: 24),
            _labelTitle('Order Summary'),
            const SizedBox(height: 8),
            _orderSummary(),
          ],
        ),
      ),
    );
  }

  Widget _statusTimeline(int status) {
    // Danh sách các giai đoạn theo thứ tự
    final List<String> statusSteps = ['Pending', 'Shipped', 'Delivered'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        statusSteps.length,
        (index) {
          final isActive = index <= status;
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circle indicator
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? Colors.green : Colors.grey,
                    ),
                    child: isActive
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                  // Line connector
                  if (index < statusSteps.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: index < status ? Colors.green : Colors.grey,
                      ),
                    ),
                  const SizedBox(width: 8),
                  // Title
                  Text(
                    statusSteps[index],
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey,
                      fontSize: 14,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              // Thêm khoảng cách giữa các dòng
              if (index < statusSteps.length - 1) const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  Widget _labelTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _orderedItemsList() {
    
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return BlocProvider(
            create: (BuildContext context) => GetProductByIdCubit()..onGet(order.orderItems[index].productId),
            child: BlocBuilder<GetProductByIdCubit, GetProductByIdState>(
              builder: (BuildContext context, state) {
                if (state is GetProductByIdLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetProductByIdFailure) {
                  return Center(
                    child: Text(state.errorMsg),
                  );
                }
                if (state is GetProductByIdSuccess) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.secondBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          state.product.imageUrl,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.product.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${state.product.discountPrice} x ${order.orderItems[index].quantity}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${(state.product.discountPrice * order.orderItems[index].quantity)..toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: Text('Some thing went wrong'),
                );
              },
            ),
          );
        },
        itemCount: order.orderItems.length,
      ),
    );
  }

  Widget _orderSummary() {
    final double subtotal = 65.0;
    final double shippingFee = 5.0;
    final double total = subtotal + shippingFee;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _summaryRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          order.total.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }


}
