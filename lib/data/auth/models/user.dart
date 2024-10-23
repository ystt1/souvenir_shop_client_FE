import 'package:souvenir_shop/domain/auth/entity/user_entity.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String address;
  final int gender;

  const UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.address,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'name': this.name,
      'email': this.email,
      'address': this.address,
      'gender': this.gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String??"",
      name: map['name'] as String??"",
      email: map['email'] as String??"",
      address: map['age'] as String??"",
      gender: map['gender'] as int??0,
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
        userId: userId,
        name: name,
        email: email,
        address: address,
        gender: gender);
  }
}
