// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeResponseModel _$OfficeResponseModelFromJson(Map<String, dynamic> json) =>
    OfficeResponseModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: OfficeInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfficeResponseModelToJson(
        OfficeResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

OfficeInfo _$OfficeInfoFromJson(Map<String, dynamic> json) => OfficeInfo(
      capacity: json['capacity'] as String,
      description: json['description'] as String,
      facilityList: (json['facilityList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imgUrl: json['imgUrl'] as String,
      name: json['name'] as String,
      officeId: json['officeId'] as int,
    );

Map<String, dynamic> _$OfficeInfoToJson(OfficeInfo instance) =>
    <String, dynamic>{
      'capacity': instance.capacity,
      'description': instance.description,
      'facilityList': instance.facilityList,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'officeId': instance.officeId,
    };
