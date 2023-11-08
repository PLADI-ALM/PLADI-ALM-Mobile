// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponseModel _$NotificationResponseModelFromJson(
        Map<String, dynamic> json) =>
    NotificationResponseModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: NotificationResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationResponseModelToJson(
        NotificationResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
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
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
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

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      createdAt: json['createdAt'] as String,
      notificationInfo: json['notificationInfo'] as String,
      notificationType: json['notificationType'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'notificationInfo': instance.notificationInfo,
      'notificationType': instance.notificationType,
    };
