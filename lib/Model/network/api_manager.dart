import 'package:dio/dio.dart';

import 'constants.dart';

enum RequestType { get, post, patch, delete, put }

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
  bool isAdmin = false;
  String fcmToken = "";

  dynamic request(
    RequestType requestType,
    String path,
    Options? options,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  ) async {
    setToken();
    // print('${await storage.read(key: accessTokenKey)}');
    // print('${defaultOptions.headers}');

    if (options != null && options.headers != null) {
      defaultOptions.headers!.addAll(options.headers!);
    }

    dynamic response;
    switch (requestType) {
      case RequestType.get:
        response = await dio.get(baseUrl + path,
            options: defaultOptions, queryParameters: queryParameters);

      case RequestType.post:
        response = await dio.post(baseUrl + path,
            options: defaultOptions,
            queryParameters: queryParameters,
            data: data);

      case RequestType.patch:
        response = await dio.patch(baseUrl + path,
            options: defaultOptions,
            queryParameters: queryParameters,
            data: data);
      case RequestType.put:
        response = await dio.put(baseUrl + path,
            options: defaultOptions,
            queryParameters: queryParameters,
            data: data);

      case RequestType.delete:
        response = await dio.delete(baseUrl + path,
            options: defaultOptions, queryParameters: queryParameters);
    }

    // print('api + $response');
    // print('api + ${response.data}');

    return response.data;
  }

  /// Request methods
  dynamic imageRequest(
    RequestType requestType,
    String path,
    Options? options,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  ) async {
    dynamic response;
    switch (requestType) {
      case RequestType.get:
        response = await dio.get(path,
            options: options, queryParameters: queryParameters);

      case RequestType.post:
        response = await dio.post(path,
            options: options, queryParameters: queryParameters, data: data);

      case RequestType.patch:
        response = await dio.patch(path,
            options: options, queryParameters: queryParameters, data: data);

      case RequestType.put:
        Options op = Options();
        op.contentType = 'multipart/form-data';
        op.maxRedirects!.isFinite;
        response = await dio.put(path,
            options: op, queryParameters: queryParameters, data: data);

      case RequestType.delete:
        response = await dio.delete(path,
            options: options, queryParameters: queryParameters);
    }

    // print('api + $response');
    // print('api + ${response.data}');

    return response.data;
  }

  /// Methods of Token
  void writeToken(String accessToken, String refreshToken, String role) async {
    await storage.write(key: accessTokenKey, value: accessToken);
    await storage.write(key: accessTokenKey, value: accessToken);
    await storage.write(key: roleKey, value: role);

    setToken();
    isAdmin = await storage.read(key: roleKey) == 'ADMIN';
  }

  void setToken() async {
    defaultOptions.headers = {
      'Accept': 'application/json',
      'authorization': await storage.read(key: accessTokenKey),
    };
  }

  void deleteToken() {
    storage.delete(key: refreshTokenKey);
    storage.delete(key: accessTokenKey);
  }

  Future<bool> checkToken() async {
    // storage.deleteAll();

    final refreshToken = await storage.read(key: refreshTokenKey);
    final accessToken = await storage.read(key: accessTokenKey);
    isAdmin = await storage.read(key: roleKey) == 'ADMIN';

    if (refreshToken == null && accessToken == null) {
      return false;
    } else {
      setToken();
      return true;
    }
  }

  void setFcmToken(String fcmToken) {
    this.fcmToken = fcmToken;
  }

  String getFcmToken() {
    return fcmToken;
  }
}
