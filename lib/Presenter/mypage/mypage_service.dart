import 'package:dio/dio.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:frontend/Model/model/mypage/myinfo_request.dart';
import 'package:frontend/Model/model/mypage/profile_response.dart';
import 'package:frontend/Model/network/api_manager.dart';

class MypageService {
  final profileURL = '/users/position';
  final logoutURL = '/users/logout';
  final myInfoURL = '/users';

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

  Future<dynamic> getMyInfo() {
    return APIManager().request(RequestType.get, myInfoURL, null, null, null);
  }

  Future<dynamic> editMyInfo(String name, String phone, String assets) async {
    final body =
        MyInfoRequest(assets: assets, name: name, phone: phone).toJson();
    try {
      final response = await APIManager()
          .request(RequestType.patch, myInfoURL, null, null, body);
      if (response != null) {
        final data = GeneralModel.fromJson(response);

        if (data.status == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        // ignore: avoid_print
        print(error.message);
        return error.message;
      }
    }
  }
}
