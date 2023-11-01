import 'dart:convert';

import 'package:frontend/Model/model/general_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponseModel extends GeneralModel {
  final LoginResponse data;

  LoginResponseModel({
    required super.status,
    required super.code,
    required super.message,
    required this.data
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);
}


@JsonSerializable()
class LoginResponse {
  String accessToken;
  String refreshToken;
  String role;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}
