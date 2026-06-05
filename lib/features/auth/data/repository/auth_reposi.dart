import 'package:Hungry_App/core/network/api_services.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/utils/pref_helper.dart';
import '../auth_model/user_model.dart';

class AuthRepo {
  ApiServices apiService = ApiServices();
  bool isGuest = false;//user have a token
  UserModel? _currentUser;

  /// Login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];

        print('📡 Login response - code: $code, data: $data');

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        final user = UserModel.fromJson(data);
        print('🔐 Login successful - User token: ${user.token ?? 'null'}');

        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
          print('💾 Token saved to storage: ${user.token}');
        } else {
          print('⚠️ No token received from server!');
        }

        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Signup
  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post('/register', {
        'name': name,
        'password': password,
        'email': email,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final coder = int.tryParse(code);
        final data = response['data'];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        /// condtion assement
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Get Profile data
  Future<UserModel?> getProfileData() async {
    try {
      final token = await PrefHelper.getToken();
      if (token == null || token == 'guest') {
        return null;
      }

      final response = await apiService.get('/profile');

      if (response is ApiError) {
        throw response;
      }

      final user = UserModel.fromJson(response['data']);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Update Profile data
  Future<UserModel?> updateProfile({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagepath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'address': address,
        if (visa != null && visa.isNotEmpty) 'Visa': visa,
        if (imagepath != null && imagepath.isNotEmpty)
          'image': await MultipartFile.fromFile(
            imagepath,
            filename: 'profile.jpg',
          ),
      });
      final response = await apiService.post('/update-profile', formData);

      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];
        final coder = int.tryParse(code);

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        final updatedUser = UserModel.fromJson(data);
        _currentUser = updatedUser;
        return updatedUser;
      } else {
        throw ApiError(message: 'Invalid  Error from here');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

 /// LogOut   
  Future<void> logOut() async {
    final response = await apiService.post('/logout', {});

    final code = response['code'];
    final msg = response['message'];

    if (code != 200 && code != 201) {
      throw ApiError(message: msg ?? 'Logout failed');
    }
    await PrefHelper.clearToken();
    _currentUser = null;
    isGuest = true;
  }

 /// AutoLogin
 Future<UserModel?>autoLogin()async{
    final token= await PrefHelper.getToken();
    if(token==null|| token =='guest')
      {
        isGuest=true;
        _currentUser=null;
        return null;
      }
    isGuest=false;
    try{
      final user= await getProfileData();
      _currentUser=user;
       return user;
    }catch(e){
      await PrefHelper.clearToken();
      isGuest=true;
      _currentUser=null;
      return null;
    }
 }

/// As a Gusset
Future<void> asGusset()async{
    isGuest =true;
    _currentUser =null;
    await PrefHelper.saveToken('guest');

}

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => !isGuest && _currentUser != null;


}
