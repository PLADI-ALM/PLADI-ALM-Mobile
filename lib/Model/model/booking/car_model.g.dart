// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarResponseModel _$CarResponseModelFromJson(Map<String, dynamic> json) =>
    CarResponseModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: CarResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarResponseModelToJson(CarResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

CarResponse _$CarResponseFromJson(Map<String, dynamic> json) => CarResponse(
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
          .map((e) => CarInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarResponseToJson(CarResponse instance) =>
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

CarInfo _$CarInfoFromJson(Map<String, dynamic> json) => CarInfo(
      description: json['description'] as String,
      location: json['location'] as String,
      imgUrl: json['imgUrl'] as String,
      name: json['name'] as String,
      carId: json['carId'] as int,
    );

Map<String, dynamic> _$CarInfoToJson(CarInfo instance) => <String, dynamic>{
      'description': instance.description,
      'location': instance.location,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'carId': instance.carId,
    };
