import 'dart:ffi';

import 'package:frontend/Model/model/general_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'myinfo_response.g.dart';

@JsonSerializable()
class MyInfoResponseModel extends GeneralModel {
  final MyInfoResponse data;

  MyInfoResponseModel(
      {required super.status,
      required super.code,
      required super.message,
      required this.data});

  factory MyInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyInfoResponseModelFromJson(json);
}

@JsonSerializable()
class MyInfoResponse {
  int userId;
  String? name;
  String? email;
  String? department;
  String? phone;
  String? role;
  String? assets;
  String? affiliation;

  MyInfoResponse({
    required this.userId,
    required this.name,
    required this.role,
    required this.phone,
    required this.email,
    required this.department,
    required this.assets,
    required this.affiliation,
  });

  factory MyInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$MyInfoResponseFromJson(json);
}
