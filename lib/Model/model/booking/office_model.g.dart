// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeResponseModel _$OfficeResponseModelFromJson(Map<String, dynamic> json) =>
    OfficeResponseModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: OfficeResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfficeResponseModelToJson(
        OfficeResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

OfficeResponse _$OfficeResponseFromJson(Map<String, dynamic> json) =>
    OfficeResponse(
      pageable: Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
      last: json['last'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      size: json['size'] as int,
      number: json['number'] as int,
      sort: Sort.fromJson(json['sort'] as Map<String, dynamic>),
      first: json['first'] as bool,
      numberOfElements: json['numberOfElements'] as int,
      empty: json['empty'] as bool,
      content: (json['content'] as List<dynamic>)
          .map((e) => OfficeInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfficeResponseToJson(OfficeResponse instance) =>
    <String, dynamic>{
      'pageable': instance.pageable,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
      'number': instance.number,
      'sort': instance.sort,
      'first': instance.first,
      'numberOfElements': instance.numberOfElements,
      'empty': instance.empty,
      'content': instance.content,
    };

OfficeInfo _$OfficeInfoFromJson(Map<String, dynamic> json) => OfficeInfo(
      location: json['location'] as String,
      capacity: json['capacity'] as int,
      description: json['description'] as String,
      facilityList: (json['facilityList'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      imgUrl: json['imgUrl'] as String,
      name: json['name'] as String,
      officeId: json['officeId'] as int,
    );

Map<String, dynamic> _$OfficeInfoToJson(OfficeInfo instance) =>
    <String, dynamic>{
      'location': instance.location,
      'capacity': instance.capacity,
      'description': instance.description,
      'facilityList': instance.facilityList,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'officeId': instance.officeId,
    };

OfficeDetailResponse _$OfficeDetailResponseFromJson(
        Map<String, dynamic> json) =>
    OfficeDetailResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: OfficeDetailInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfficeDetailResponseToJson(
        OfficeDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

OfficeDetailInfo _$OfficeDetailInfoFromJson(Map<String, dynamic> json) =>
    OfficeDetailInfo(
      location: json['location'] as String,
      capacity: json['capacity'] as String,
      description: json['description'] as String,
      facilityList: (json['facilityList'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      imgUrl: json['imgUrl'] as String,
      name: json['name'] as String,
      officeId: json['officeId'] as int,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$OfficeDetailInfoToJson(OfficeDetailInfo instance) =>
    <String, dynamic>{
      'location': instance.location,
      'capacity': instance.capacity,
      'description': instance.description,
      'facilityList': instance.facilityList,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'officeId': instance.officeId,
      'isActive': instance.isActive,
    };
