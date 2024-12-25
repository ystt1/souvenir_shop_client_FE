import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/helper/change_time.dart';
import 'package:souvenir_shop/common/helper/navigator/app_navigator.dart';
import 'package:souvenir_shop/presentation/order_details/page/order_details.dart';

import '../../../common/app_colors.dart';
import '../../../domain/setting/entity/order_entity.dart';
import '../../../domain/setting/entity/order_item_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor(order.status);
    final int itemsCount = _getTotalQuantity(order.orderItems); // Tổng số lượng từ orderItems

    return GestureDetector(
      onTap: () => AppNavigator.push(context, OrderDetails(order: order,)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon hiển thị trạng thái
            Icon(
              _getStatusIcon(order.status),
              color: statusColor,
              size: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ID đơn hàng và ngày
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
              'Order #${order.id.substring(0, 5)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatDateTime(order.orderDate),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Thông tin số lượng, trạng thái và tổng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$itemsCount items',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      // Badge trạng thái
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getStatusText(order.status),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        'Total: \$${order.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }


  Color _getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.orangeAccent; // Pending
      case 2:
        return Colors.blueAccent; // Shipped
      case 3:
        return Colors.green; // Delivered
      default:
        return Colors.grey; // Unknown
    }
  }


  IconData _getStatusIcon(int status) {
    switch (status) {
      case 1:
        return Icons.access_time; // Pending
      case 2:
        return Icons.local_shipping; // Shipped
      case 3:
        return Icons.check_circle; // Delivered
      default:
        return Icons.help_outline; // Unknown
    }
  }


  String _getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Pending';
      case 2:
        return 'Shipped';
      case 3:
        return 'Delivered';
      default:
        return 'Unknown';
    }
  }

  // Hàm tính tổng quantity từ danh sách orderItems
  int _getTotalQuantity(List<OrderItemEntity> orderItems) {
    return orderItems.fold(0, (sum, item) => sum + item.quantity);
  }
}
