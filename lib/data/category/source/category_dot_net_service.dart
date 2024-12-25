
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../common/constant.dart';
import '../../../core/user_storage.dart';
import '../models/category.dart';

abstract class CategoryDotNetService {
  Future<Either> getCategories();
}

class CategoryDotNetServiceImp extends CategoryDotNetService {
  @override
  Future<Either> getCategories() async {
    const String url = '$AppApi/Category';
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
        List<CategoryModel> categories =
            responseBody.map((data) {
             return CategoryModel.fromMap(data);}).toList();
        return Right(categories);
      } else {
        return Left(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      print('catch service' + e.toString());
      return Left(e.toString());
    }
  }
}
