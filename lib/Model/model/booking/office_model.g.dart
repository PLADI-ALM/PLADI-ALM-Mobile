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
      capacity: json['capacity'] as int,
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

OfficeBookingResponse _$OfficeBookingResponseFromJson(
        Map<String, dynamic> json) =>
    OfficeBookingResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: OfficeBookingInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfficeBookingResponseToJson(
        OfficeBookingResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

OfficeBookingInfo _$OfficeBookingInfoFromJson(Map<String, dynamic> json) =>
    OfficeBookingInfo(
      bookedTimes: (json['bookedTimes'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : BookingTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfficeBookingInfoToJson(OfficeBookingInfo instance) =>
    <String, dynamic>{
      'bookedTimes': instance.bookedTimes,
    };

BookingTime _$BookingTimeFromJson(Map<String, dynamic> json) => BookingTime(
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$BookingTimeToJson(BookingTime instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

BookingDetailResponse _$BookingDetailResponseFromJson(
        Map<String, dynamic> json) =>
    BookingDetailResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : BookingDetail.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingDetailResponseToJson(
        BookingDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

BookingDetail _$BookingDetailFromJson(Map<String, dynamic> json) =>
    BookingDetail(
      reservatorName: json['reservatorName'] as String,
      reservatorPhone: json['reservatorPhone'] as String,
      department: json['department'] as String,
    );

Map<String, dynamic> _$BookingDetailToJson(BookingDetail instance) =>
    <String, dynamic>{
      'reservatorName': instance.reservatorName,
      'reservatorPhone': instance.reservatorPhone,
      'department': instance.department,
    };
