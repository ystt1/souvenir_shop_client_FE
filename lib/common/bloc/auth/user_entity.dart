class AuthEntity {
  final String userName;
  final String email;
  final String token;

  const AuthEntity({
    required this.userName,
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'email': this.email,
      'token': this.token,
    };
  }

  factory AuthEntity.fromMap(Map<String, dynamic> map) {
    return AuthEntity(
      userName: map['userName'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }
}