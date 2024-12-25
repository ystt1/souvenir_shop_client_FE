import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../common/constant.dart';
import 'package:http/http.dart' as http;

import '../../../core/user_storage.dart';
import '../model/product.dart';

abstract class ProductDotNetService {
  Future<Either> getAllProduct();

  Future<Either> searchProduct(String name);

  Future<Either> getNewInProducts();

  Future<Either> getProductsByCategoryId(String categoryId);

  Future<Either> getProductsByTitle(String title);

  Future<Either> getProductById(String id);
}

class ProductDotNetServiceImp extends ProductDotNetService {
  @override
  Future<Either> getNewInProducts() {
    // TODO: implement getNewInProducts
    throw UnimplementedError();
  }

  @override
  Future<Either> getProductsByCategoryId(String categoryId) {
    // TODO: implement getProductsByCategoryId
    throw UnimplementedError();
  }

  @override
  Future<Either> getProductsByTitle(String title) {
    // TODO: implement getProductsByTitle
    throw UnimplementedError();
  }

  @override
  Future<Either> getAllProduct() async {
    const String url = '$AppApi/Product';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${UserStorage.getToken()}',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        List<ProductModel> products = responseBody.map((data) {
          return ProductModel.fromMap(data);
        }).toList();
        return Right(products);
      } else {
        return Left(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> searchProduct(String name) async {
    String url = '$AppApi/Product/search?name=$name';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${UserStorage.getToken()}',
        },
      );
      print("search" + response.body);
      if (response.statusCode == 200) {
        List<dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        List<ProductModel> products = responseBody.map((data) {
          return ProductModel.fromMap(data);
        }).toList();
        return Right(products);
      } else {
        return Left(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      print("e" + e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getProductById(String id) async {
    print(id);
    String url = '$AppApi/Product/$id';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${UserStorage.getToken()}',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        try {
          ProductModel product = ProductModel.fromMap(responseBody);
          return Right(product);
        } catch (e) {
          return const Right([]);
        }
      } else if (response.statusCode == 404) {
        return Left(jsonDecode(response.body)["message"]);
      }
      return Left("http error status code " + response.statusCode.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
