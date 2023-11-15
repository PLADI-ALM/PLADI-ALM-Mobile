import 'package:dio/dio.dart';
import 'package:frontend/Model/model/login/email_code_request.dart';
import 'package:frontend/Model/model/login/email_request.dart';
import 'package:frontend/Model/model/login/login_request.dart';
import 'package:frontend/Model/model/login/login_response.dart';

import '../../Model/model/general_model.dart';
import '../../Model/network/api_manager.dart';

class LoginService {
  final loginURL = '/users/login';
  final emailUrl = '/users/email';
  final emailCodeUrl = '/users/email-code';
  final passwordUrl = '/users/password';

  static final LoginService _loginService = LoginService._();
  LoginService._();
  factory LoginService() {
    return _loginService;
  }

  Future<dynamic> login(String email, String password) async {
    final body = LoginRequest(email: email, password: password).toJson();

    try {
      final response = await APIManager()
          .request(RequestType.post, loginURL, null, null, body);

      if (response != null) {
        final data = LoginResponseModel.fromJson(response);
        APIManager().writeToken(
            data.data.accessToken, data.data.refreshToken, data.data.role);
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }

  Future<dynamic> requestEmail(String email) async {
    final body = EmailRequest(email: email).toJson();

    try {
      final response = await APIManager()
          .request(RequestType.post, emailUrl, null, null, body);

      if (response != null) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }

  Future<dynamic> requestEmailCode(String email, String code) async {
    final body = EmailCodeRequest(email: email, code: code).toJson();

    try {
      final response = await APIManager()
          .request(RequestType.post, emailCodeUrl, null, null, body);

      if (response != null) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }

  Future<dynamic> changePassword(String email, String password) async {
    final body = LoginRequest(email: email, password: password).toJson();

    try {
      final response = await APIManager()
          .request(RequestType.patch, passwordUrl, null, null, body);

      if (response != null) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }
}
