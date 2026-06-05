import 'package:dio/dio.dart';

import 'api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (statusCode != null) {
      if (data is Map<String, dynamic> && data['massage'] != null) {
        return ApiError(message: data['massage'], StatusCode: statusCode);
      }
    }
    if (statusCode == 401) {
      return ApiError(message: 'Unauthized');
    }
    if (statusCode == 302) {
      return ApiError(message: 'The Email is Already Taken');
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: "Connection timeout. Please check your internet connection",
        );
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request timeout. Please try again");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Response timeout. Please try again");
      case DioException.connectionError:
        return ApiError(message: "Response timeout");
      case DioException.badResponse:
        return ApiError(
          message: 'An unexpected error occurred. Please try again',
        );
      default:
        return ApiError(
          message: "An unexpected error occurred. Please try again",
        );
    }
  }
}

// if(statusCode == 302) {
//   return ApiError(message: 'The Email is Already Taken');
// }

// print('Error response: ${error.response?.data}');
// print('Status code: $statusCode');
