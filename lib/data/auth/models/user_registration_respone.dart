class UserRegistrationResponse {
  final String userName;
  final String email;
  final String token;

  UserRegistrationResponse({
    required this.userName,
    required this.email,
    required this.token,
  });

  factory UserRegistrationResponse.fromMap(Map<String, dynamic> map) {
    return UserRegistrationResponse(
      userName: map['userName'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }
}