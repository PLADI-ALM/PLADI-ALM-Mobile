import 'package:dio/dio.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:frontend/Model/model/mypage/profile_response.dart';
import 'package:frontend/Model/network/api_manager.dart';

class MypageService {
  final profileURL = '/users/position';
  final logoutURL = '/users/logout';

  static final MypageService _mypageService = MypageService._();
  MypageService._();
  factory MypageService() {
    return _mypageService;
  }

  Future<dynamic> getProfile() async {
    final response =
        APIManager().request(RequestType.get, profileURL, null, null, null);
    return response;
  }

  Future<dynamic> logout() async {
    try {
      final response =
          APIManager().request(RequestType.post, logoutURL, null, null, null);
      if (response != null) {
        APIManager().deleteToken();
        return true;
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