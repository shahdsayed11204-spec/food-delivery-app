import 'package:dio/dio.dart';

import 'api_exceptions.dart';
import 'dio_client.dart';

class ApiServices {

  final DioClient dioClient = DioClient();

  // Future<dynamic> get(String endPoint) async {
  //   try {
  //     final response = await dioClient.dio.get(endPoint);
  //     return response.data;
  //   } catch (e) {
  //     throw "An unexpected error occurred. Please try again";
  //   }
  // }

  Future<dynamic> get(String endPoint) async {
    try {
      final response = await dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (error) {
      throw ApiExceptions.handleError(error);
    }
  }

  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await dioClient.dio.post(
        endPoint,
        data: body,
      );

      print('STATUS CODE = ${response.statusCode}');
      print('DATA = ${response.data}');

      return response.data;
    } on DioException catch (error) {
      print('🔥 DIO ERROR STATUS = ${error.response?.statusCode}');
      print('🔥 DIO ERROR DATA = ${error.response?.data}');

      return error.response?.data;
    }
  }

  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioError catch (error) {
      throw ApiExceptions.handleError(error);
    }
  }

  Future<dynamic> delete(String endPoint, dynamic body) async {
    try {
      final response = await dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioError catch (error) {
      throw ApiExceptions.handleError(error);
    }
  }
}
