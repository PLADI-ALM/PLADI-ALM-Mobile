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
      description: json['description'] as String?,
      location: json['location'] as String?,
      imgUrl: json['imgUrl'] as String?,
      name: json['name'] as String,
      carId: json['carId'] as int,
    )..manufacturer = json['manufacturer'] as String?;

Map<String, dynamic> _$CarInfoToJson(CarInfo instance) => <String, dynamic>{
      'description': instance.description,
      'location': instance.location,
      'manufacturer': instance.manufacturer,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'carId': instance.carId,
    };

CarDetailResponse _$CarDetailResponseFromJson(Map<String, dynamic> json) =>
    CarDetailResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: CarDetailInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarDetailResponseToJson(CarDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

CarDetailInfo _$CarDetailInfoFromJson(Map<String, dynamic> json) =>
    CarDetailInfo(
      description: json['description'] as String?,
      imgUrl: json['imgUrl'] as String?,
      location: json['location'] as String?,
      name: json['name'] as String?,
      responsibilityId: json['responsibilityId'] as int?,
      responsibilityName: json['responsibilityName'] as String?,
      responsibilityPhone: json['responsibilityPhone'] as String?,
    )..manufacturer = json['manufacturer'] as String?;

Map<String, dynamic> _$CarDetailInfoToJson(CarDetailInfo instance) =>
    <String, dynamic>{
      'description': instance.description,
      'imgUrl': instance.imgUrl,
      'location': instance.location,
      'manufacturer': instance.manufacturer,
      'name': instance.name,
      'responsibilityId': instance.responsibilityId,
      'responsibilityName': instance.responsibilityName,
      'responsibilityPhone': instance.responsibilityPhone,
    };

CarBookingHistoryResponse _$CarBookingHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    CarBookingHistoryResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data:
          CarBookingHistoryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarBookingHistoryResponseToJson(
        CarBookingHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

CarBookingHistoryData _$CarBookingHistoryDataFromJson(
        Map<String, dynamic> json) =>
    CarBookingHistoryData(
      content: (json['content'] as List<dynamic>)
          .map((e) => CarBookingHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarBookingHistoryDataToJson(
        CarBookingHistoryData instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

CarBookingHistory _$CarBookingHistoryFromJson(Map<String, dynamic> json) =>
    CarBookingHistory(
      id: json['id'] as int,
      targetId: json['targetId'] as int,
      name: json['name'] as String,
      location: json['location'] as String?,
      startDateTime: json['startDateTime'] as String,
      endDateTime: json['endDateTime'] as String,
      memo: json['memo'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$CarBookingHistoryToJson(CarBookingHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'targetId': instance.targetId,
      'name': instance.name,
      'location': instance.location,
      'startDateTime': instance.startDateTime,
      'endDateTime': instance.endDateTime,
      'memo': instance.memo,
      'status': instance.status,
    };

CarBookingRequest _$CarBookingRequestFromJson(Map<String, dynamic> json) =>
    CarBookingRequest(
      startDateTime: json['startDateTime'] as String,
      endDateTime: json['endDateTime'] as String,
      memo: json['memo'] as String,
    );

Map<String, dynamic> _$CarBookingRequestToJson(CarBookingRequest instance) =>
    <String, dynamic>{
      'startDateTime': instance.startDateTime,
      'endDateTime': instance.endDateTime,
      'memo': instance.memo,
    };

AdminCarBookingHistoryResponse _$AdminCarBookingHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    AdminCarBookingHistoryResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data:
          AdminCarBookingHistory.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdminCarBookingHistoryResponseToJson(
        AdminCarBookingHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

AdminCarBookingHistory _$AdminCarBookingHistoryFromJson(
        Map<String, dynamic> json) =>
    AdminCarBookingHistory(
      id: json['id'] as int,
      responsibilityName: json['responsibilityName'] as String,
      responsibilityPhone: json['responsibilityPhone'] as String,
      description: json['description'] as String?,
      imgUrl: json['imgUrl'] as String,
      productList: (json['productList'] as List<dynamic>)
          .map((e) => CarsList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminCarBookingHistoryToJson(
        AdminCarBookingHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'responsibilityName': instance.responsibilityName,
      'responsibilityPhone': instance.responsibilityPhone,
      'description': instance.description,
      'imgUrl': instance.imgUrl,
      'productList': instance.productList,
    };

CarsList _$CarsListFromJson(Map<String, dynamic> json) => CarsList(
      reservatorName: json['reservatorName'] as String,
      reservatorPhone: json['reservatorPhone'] as String,
      startDateTime: json['startDateTime'] as String,
      endDateTime: json['endDateTime'] as String,
      memo: json['memo'] as String?,
      bookingStatus: json['bookingStatus'] as String,
    );

Map<String, dynamic> _$CarsListToJson(CarsList instance) => <String, dynamic>{
      'reservatorName': instance.reservatorName,
      'reservatorPhone': instance.reservatorPhone,
      'startDateTime': instance.startDateTime,
      'endDateTime': instance.endDateTime,
      'memo': instance.memo,
      'bookingStatus': instance.bookingStatus,
    };
