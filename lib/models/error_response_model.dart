// class ErrorResponseModel {
//   String? errorMessage;
//   ErrorResponseModel({this.errorMessage});
// }



class ErrorResponseModel {
  String? errorMessage;
  int? statusCode;
  Map<String, String> fieldErrors;

  ErrorResponseModel({this.errorMessage, this.statusCode, this.fieldErrors = const {}});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json, int code) {
    final errors = <String, String>{};
    (json['errors'] as Map<String, dynamic>? ?? {}).forEach((key, value) {
      errors[key] = value is List ? value.join('\n') : value.toString();
    });
    return ErrorResponseModel(
      errorMessage: json['message']?.toString(),
      statusCode: code,
      fieldErrors: errors,
    );
  }
}