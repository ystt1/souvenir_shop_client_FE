class ErrorDetail {
  final String code;
  final String description;

  ErrorDetail({required this.code, required this.description});

  factory ErrorDetail.fromMap(Map<String, dynamic> map) {
    return ErrorDetail(
      code: map['code'] as String,
      description: map['description'] as String,
    );
  }
}

class ErrorResponse {
  final List<ErrorDetail> errors;

  ErrorResponse({required this.errors});

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    final errors = (map['message'] as List<dynamic>)
        .map((error) => ErrorDetail.fromMap(error as Map<String, dynamic>))
        .toList();
    return ErrorResponse(errors: errors);
  }
}