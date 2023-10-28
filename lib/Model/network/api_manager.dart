import 'package:dio/dio.dart';

import 'constants.dart';

enum RequestType { get, post, patch, delete }

class APIManager {

  /// Singleton Pattern
  static final APIManager _apiManager = APIManager._();

  APIManager._();

  factory APIManager() {
    return _apiManager;
  }

  /// Variables
  final dio = Dio();
  Options defaultOptions = Options();

  /// Request methods
  dynamic request(
      RequestType requestType,
      String path,
      Options? options,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      ) async {

    if (options != null && options.headers != null) {
      defaultOptions.headers!.addAll(options.headers!);
    }

    dynamic response;
    switch (requestType) {
      case RequestType.get :
        response = await dio.get(
            baseUrl + path,
            options: defaultOptions,
            queryParameters: queryParameters
        );

      case RequestType.post :
        response = await dio.post(
            baseUrl + path,
            options: defaultOptions,
            queryParameters: queryParameters,
            data: data
        );

      case RequestType.patch :
        response = await dio.patch(
            baseUrl + path,
            options: defaultOptions,
            queryParameters: queryParameters,
            data: data
        );

      case RequestType.delete :
        response = await dio.delete(
            baseUrl + path,
            options: defaultOptions,
            queryParameters: queryParameters
        );
    }

    // print('api + ${response}');
    // print('api + ${response.data}');

    return response.data;
  }

  /// Methods of Token
  void writeToken(String accessToken, String refreshToken) async {
    await storage.write(key: accessTokenKey, value: accessToken);
    await storage.write(key: refreshTokenKey, value: refreshToken);
    setToken();
  }

  void setToken() async {
    defaultOptions.headers = {
      'Accept' : 'application/json',
      'authorization': await storage.read(key: accessTokenKey),
    };
  }

  Future<bool> checkToken() async {
    // final refreshToken = await storage.read(key: refreshTokenKey);
    // final accessToken = await storage.read(key: accessTokenKey);
    //
    // if (refreshToken == null && accessToken == null) {
    //   return false;
    // } else {
    //   setToken();
    //   return true;
    // }
    return true;
  }
}