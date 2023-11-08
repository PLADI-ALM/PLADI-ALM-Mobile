import 'package:frontend/Model/model/general_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponseModel extends GeneralModel {
  final ProfileResponse data;

  ProfileResponseModel(
      {required super.status,
      required super.code,
      required super.message,
      required this.data});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);
}

@JsonSerializable()
class ProfileResponse {
  String name;
  String role;

  ProfileResponse({
    required this.name,
    required this.role,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
