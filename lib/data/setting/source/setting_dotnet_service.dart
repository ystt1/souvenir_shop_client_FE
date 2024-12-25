import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../common/constant.dart';
import '../../../core/user_storage.dart';
import '../model/order_model.dart';
abstract class SettingDotNetService{
  Future<Either> getOrders();
}

class SettingDotNetServiceImp extends SettingDotNetService{
  @override
  Future<Either> getOrders() async {
    const String url = '$AppApi/Order/get-customer-orders';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${UserStorage.getToken()}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<OrderModel> orders = jsonData
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(orders);
      } else {
        return Left('Error: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}