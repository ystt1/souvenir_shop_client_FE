import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/common/constant.dart';
import 'package:souvenir_shop/data/auth/models/user_creation_req.dart';
import 'package:http/http.dart' as http;
import 'package:souvenir_shop/data/auth/models/user_signin_req.dart';

import '../../../common/bloc/auth/user_entity.dart';

abstract class AuthDotNetService {
  Future<Either> register(UserCreationReq user);

  Future<Either> login(UserSignInReq user);
}

class AuthDotNetServiceImp extends AuthDotNetService {
  @override
  Future<Either> register(UserCreationReq user) async {
    const String url = '$AppApi/Account/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json-patch+json',
        },
        body: jsonEncode(user.toMap()),
      );

      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userResponse = AuthEntity.fromMap(responseBody);
        return Right(userResponse);
      } else if (response.statusCode == 400) {
        if (responseBody.containsKey('errors')) {
          final errors = responseBody['errors'] as Map<String, dynamic>;
          final firstField = errors.keys.first;
          final firstError =
              errors[firstField]?.first?.toString() ?? 'Unknown error.';
          return Left(firstError);
        } else if (responseBody.containsKey('message')) {
          final firstDescription =
              responseBody['message']?[0]?['description']?.toString() ??
                  'Unknown error.';
          return Left(firstDescription);
        } else {
          return Left('Unknown error.');
        }
      } else {
        return Left('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> login(UserSignInReq user) async {
    const String url = '$AppApi/Account/login';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json-patch+json',
        },
        body: jsonEncode(user.toMap()),
      );

      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final userResponse = AuthEntity.fromMap(responseBody);
        return Right(userResponse);
      } else if (response.statusCode == 401) {
        return Left(responseBody['message']);
      } else {
        return Left('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
