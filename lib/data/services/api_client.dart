import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/data/services/api_endpoints.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';

class ApiClient {
  late final Dio dio;
  
  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiEndpoint.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    _addInterceptors();
    _restoreToken();
  }
  
  void _addInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final sharedPrefs = Get.find<SharedPreference>();
        final token = sharedPrefs.getToken();
        
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            final newToken = await _refreshToken();
            if (newToken != null) {
              final sharedPrefs = Get.find<SharedPreference>();
              sharedPrefs.saveToken(newToken);
              
              error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final response = await dio.fetch(error.requestOptions);
              return handler.resolve(response);
            }
          } catch (e) {
            Get.offAllNamed('/login');
          }
        }
        
        return handler.next(error);
      },
    ));
  }
  
  void _restoreToken() {
    try {
      final sharedPrefs = Get.find<SharedPreference>();
      final token = sharedPrefs.getToken();
      if (token != null && token.isNotEmpty) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
    }
  }
  
  Future<String?> _refreshToken() async {
    try {
      final sharedPrefs = Get.find<SharedPreference>();
      final refreshToken = sharedPrefs.getRefreshToken();
      
      if (refreshToken == null || refreshToken.isEmpty) {
        return null;
      }
      
      final response = await dio.post(
        ApiEndpoint.refresh,
        data: {'refreshToken': refreshToken},
      );
      
      if (response.data['success'] == true) {
        return response.data['data']['accessToken'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
    final sharedPrefs = Get.find<SharedPreference>();
    sharedPrefs.saveToken(token);
  }
  
  void removeAuthToken() {
    dio.options.headers.remove('Authorization');
    final sharedPrefs = Get.find<SharedPreference>();
    sharedPrefs.clearAll();
  }
}