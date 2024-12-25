import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/item_cart/model/cart_item_model.dart';
import 'package:souvenir_shop/data/item_cart/model/item_cart_add_req.dart';
import 'package:souvenir_shop/data/item_cart/model/purchase_get_model.dart';
import 'package:souvenir_shop/domain/itemCart/entity/purchase_get_entity.dart';

import '../../../common/constant.dart';
import 'package:http/http.dart' as http;

import '../../../core/user_storage.dart';

abstract class ItemCartDotNetService {
  Future<Either> addToCart(ItemCartAddReq item);

  Future<Either> getItemCart();

  Future<Either> purchase(List<String> ids);

  Future<Either> placeOrder(PurchaseGetEntity purchase);
}

class ItemCartDotNetServiceImp extends ItemCartDotNetService {
  @override
  Future<Either> addToCart(ItemCartAddReq item) async {
    const String url = '$AppApi/Cart';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json-patch+json',
          'Authorization': 'Bearer ${UserStorage.getToken()}',
        },
        body: jsonEncode(item.toMap()),
      );

      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right('add success');
      } else if (response.statusCode == 401) {
        return Left('ERROR 401');
      } else {
        return Left('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getItemCart() async {
    const String url = '$AppApi/Cart/get-cart';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${UserStorage.getToken()}',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData =
            jsonDecode(utf8.decode(response.bodyBytes));

        if (jsonData['cartItems'] != null && jsonData['cartItems'] is List) {
          final List<dynamic> cartItemsData = jsonData['cartItems'];
          final List<CartItemModel> cartItems =
              cartItemsData.map((item) => CartItemModel.fromMap(item)).toList();
          return Right(cartItems);
        } else {
          return Left('cartItems not found or is not a list');
        }
      }
      return Left(utf8.decode(response.bodyBytes));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> purchase(List<String> ids) async {
    try {
      const String url = '$AppApi/Order/purchase';
      Map<String, dynamic> body = {
        "cartItemIds": ids,
      };
      final response = await http.post(Uri.parse(url),
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer ${UserStorage.getToken()}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return Right(PurchaseGetModel(
            total: jsonDecode(response.body)["total"],
            sendToPlaceOrderString: response.body, time: jsonDecode(response.body)["orderDate"]));
      }
      if(response.statusCode==400)
        {
          return Left(jsonDecode(response.body)["message"]);
        }
      return Left(response.body);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> placeOrder(PurchaseGetEntity purchase) async {
    try {
      const String url = '$AppApi/Order/place-order';
      final response = await http.post(Uri.parse(url),
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer ${UserStorage.getToken()}',
            'Content-Type': 'application/json',
          },
          body: purchase.sendToPlaceOrderString);
      if (response.statusCode == 200) {


        return Right("place order success");
      }
      if(response.statusCode==400)
      {
        return Left(jsonDecode(response.body)["title"]);
      }
      return Left(response.body);
    } catch (e) {
      print("e"+e.toString());
      return Left(e.toString());
    }
  }
}
