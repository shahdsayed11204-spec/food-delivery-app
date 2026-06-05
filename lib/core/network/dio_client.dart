import 'package:dio/dio.dart';

import '../utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api/',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
   DioClient(){
     // _dio.interceptors.add(
     //     LogInterceptor(requestBody: true, responseBody: true),
     // );
     _dio.interceptors.add(
       InterceptorsWrapper(
         onRequest: (options,handler)
         async{
           final token=await PrefHelper.getToken();
           print('TOKEN = $token');
           print('URL = ${options.path}');
           print('HEADERS = ${options.headers}');
           if(token !=null && token.isNotEmpty&&token!='guest'){
             options.headers['Authorization']='Bearer $token';
           }
           return handler.next(options);
         }
       )
     );
   }
   Dio get dio=>_dio;
}