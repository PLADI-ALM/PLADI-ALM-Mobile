// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myinfo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyInfoResponseModel _$MyInfoResponseModelFromJson(Map<String, dynamic> json) =>
    MyInfoResponseModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: MyInfoResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyInfoResponseModelToJson(
        MyInfoResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

MyInfoResponse _$MyInfoResponseFromJson(Map<String, dynamic> json) =>
    MyInfoResponse(
      userId: json['userId'] as int,
      name: json['name'] as String?,
      role: json['role'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      department: json['department'] as String?,
      assets: json['assets'] as String?,
      affiliation: json['affiliation'] as String?,
    );

Map<String, dynamic> _$MyInfoResponseToJson(MyInfoResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'department': instance.department,
      'phone': instance.phone,
      'role': instance.role,
      'assets': instance.assets,
      'affiliation': instance.affiliation,
    };
