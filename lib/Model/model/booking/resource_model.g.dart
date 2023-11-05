// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResourceResponseModel _$ResourceResponseModelFromJson(
        Map<String, dynamic> json) =>
    ResourceResponseModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: ResourceResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResourceResponseModelToJson(
        ResourceResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ResourceResponse _$ResourceResponseFromJson(Map<String, dynamic> json) =>
    ResourceResponse(
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
          .map((e) => ResourceInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResourceResponseToJson(ResourceResponse instance) =>
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

ResourceInfo _$ResourceInfoFromJson(Map<String, dynamic> json) => ResourceInfo(
      description: json['description'] as String,
      location: json['location'] as String,
      imgUrl: json['imgUrl'] as String?,
      name: json['name'] as String,
      resourceId: json['resourceId'] as int,
    );

Map<String, dynamic> _$ResourceInfoToJson(ResourceInfo instance) =>
    <String, dynamic>{
      'description': instance.description,
      'location': instance.location,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'resourceId': instance.resourceId,
    };

ResourceDetailResponse _$ResourceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ResourceDetailResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: ResourceDetailInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResourceDetailResponseToJson(
        ResourceDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ResourceDetailInfo _$ResourceDetailInfoFromJson(Map<String, dynamic> json) =>
    ResourceDetailInfo(
      description: json['description'] as String,
      location: json['location'] as String,
      imgUrl: json['imgUrl'] as String?,
      name: json['name'] as String,
      responsibilityId: json['responsibilityId'] as int,
      responsibilityName: json['responsibilityName'] as String,
      responsibilityPhone: json['responsibilityPhone'] as String,
    );

Map<String, dynamic> _$ResourceDetailInfoToJson(ResourceDetailInfo instance) =>
    <String, dynamic>{
      'description': instance.description,
      'location': instance.location,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'responsibilityId': instance.responsibilityId,
      'responsibilityName': instance.responsibilityName,
      'responsibilityPhone': instance.responsibilityPhone,
    };
