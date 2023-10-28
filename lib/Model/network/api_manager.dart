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