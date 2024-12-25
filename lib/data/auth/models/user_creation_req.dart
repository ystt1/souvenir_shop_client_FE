class UserCreationReq {
  final String email;
  final String userName;
  final String password;
  final String fullName;
  final String phoneNumber;
  late String address;
  final String avatarUrl;
  late bool gender;

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'userName': this.userName,
      'password': this.password,
      'fullName': this.fullName,
      'phoneNumber': this.phoneNumber,
      'address': this.address,
      'avatarUrl': this.avatarUrl,
      'gender': this.gender,
    };
  }

  factory UserCreationReq.fromMap(Map<String, dynamic> map) {
    return UserCreationReq(
      email: map['email'] as String,
      userName: map['userName'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      avatarUrl: map['avatarUrl'] as String,
      gender: map['gender'] as bool,
    );
  }

  UserCreationReq({
    required this.email,
    required this.userName,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.avatarUrl,
    required this.gender,
  });
}
