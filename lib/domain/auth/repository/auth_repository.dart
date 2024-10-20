import 'package:dartz/dartz.dart';
import 'package:souvenir_shop/data/auth/models/user_creation_req.dart';

abstract class AuthRepository{
  Future<Either> signUp(UserCreationReq user);
  Future<Either> getAges();
}