import 'package:dartz/dartz.dart';

abstract class SettingRepository{
  Future<Either> getListFavorite();
  Future<Either> getListOrder();
  Future<Either> getListItemOrder(String idOrder);
}