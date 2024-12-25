class UserSignInReq
{
  String? userName;
  String? password;

  UserSignInReq({
    this.userName,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'password': this.password,
    };
  }

  factory UserSignInReq.fromMap(Map<String, dynamic> map) {
    return UserSignInReq(
      userName: map['userName'] as String,
      password: map['password'] as String,
    );
  }
}