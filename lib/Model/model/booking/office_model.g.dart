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
      location: json['location'] as String?,
      capacity: json['capacity'] as String,
      description: json['description'] as String?,
      facilityList: (json['facilityList'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      imgUrl: json['imgUrl'] as String?,
      name: json['name'] as String,
      officeId: json['officeId'] as int,
      isActive: json['isActive'] as bool?,
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
      'isActive': instance.isActive,
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
      location: json['location'] as String?,
      capacity: json['capacity'] as String?,
      description: json['description'] as String?,
      facilityList: (json['facilityList'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      imgUrl: json['imgUrl'] as String?,
      name: json['name'] as String?,
      officeId: json['officeId'] as int?,
      isActive: json['isActive'] as bool?,
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
      reservatorDepartment: json['reservatorDepartment'] as String,
      startDateTime: json['startDateTime'] as String,
      endDateTime: json['endDateTime'] as String,
    );

Map<String, dynamic> _$BookingDetailToJson(BookingDetail instance) =>
    <String, dynamic>{
      'reservatorName': instance.reservatorName,
      'reservatorPhone': instance.reservatorPhone,
      'reservatorDepartment': instance.reservatorDepartment,
      'startDateTime': instance.startDateTime,
      'endDateTime': instance.endDateTime,
    };

OfficeBookingRequest _$OfficeBookingRequestFromJson(
        Map<String, dynamic> json) =>
    OfficeBookingRequest(
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      memo: json['memo'] as String,
    );

Map<String, dynamic> _$OfficeBookingRequestToJson(
        OfficeBookingRequest instance) =>
    <String, dynamic>{
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'memo': instance.memo,
    };

OfficeBookingHistoryResponse _$OfficeBookingHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    OfficeBookingHistoryResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: OfficeBookingHistoryData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfficeBookingHistoryResponseToJson(
        OfficeBookingHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

OfficeBookingHistoryData _$OfficeBookingHistoryDataFromJson(
        Map<String, dynamic> json) =>
    OfficeBookingHistoryData(
      content: (json['content'] as List<dynamic>)
          .map((e) => OfficeBookingHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfficeBookingHistoryDataToJson(
        OfficeBookingHistoryData instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

OfficeBookingHistory _$OfficeBookingHistoryFromJson(
        Map<String, dynamic> json) =>
    OfficeBookingHistory(
      id: json['id'] as int,
      name: json['name'] as String,
      detailInfo: json['detailInfo'] as String?,
      startDateTime: json['startDateTime'] as String,
      endDateTime: json['endDateTime'] as String,
      memo: json['memo'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$OfficeBookingHistoryToJson(
        OfficeBookingHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detailInfo': instance.detailInfo,
      'startDateTime': instance.startDateTime,
      'endDateTime': instance.endDateTime,
      'memo': instance.memo,
      'status': instance.status,
    };

AdminOfficeBookingHistoryResponse _$AdminOfficeBookingHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    AdminOfficeBookingHistoryResponse(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: AdminOfficeBookingHistory.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdminOfficeBookingHistoryResponseToJson(
        AdminOfficeBookingHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

AdminOfficeBookingHistory _$AdminOfficeBookingHistoryFromJson(
        Map<String, dynamic> json) =>
    AdminOfficeBookingHistory(
      officeId: json['officeId'] as int,
      name: json['name'] as String,
      location: json['location'] as String?,
      capacity: json['capacity'] as String,
      facilityList: (json['facilityList'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      description: json['description'] as String,
      imgUrl: json['imgUrl'] as String,
      officesLists: (json['officesLists'] as List<dynamic>)
          .map((e) => OfficesList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminOfficeBookingHistoryToJson(
        AdminOfficeBookingHistory instance) =>
    <String, dynamic>{
      'officeId': instance.officeId,
      'name': instance.name,
      'location': instance.location,
      'capacity': instance.capacity,
      'facilityList': instance.facilityList,
      'description': instance.description,
      'imgUrl': instance.imgUrl,
      'officesLists': instance.officesLists,
    };

OfficesList _$OfficesListFromJson(Map<String, dynamic> json) => OfficesList(
      reservatorName: json['reservatorName'] as String,
      reservatorPhone: json['reservatorPhone'] as String,
      startDateTime: json['startDateTime'] as String,
      endDateTime: json['endDateTime'] as String,
      goal: json['goal'] as String?,
      bookingStatus: json['bookingStatus'] as String,
    );

Map<String, dynamic> _$OfficesListToJson(OfficesList instance) =>
    <String, dynamic>{
      'reservatorName': instance.reservatorName,
      'reservatorPhone': instance.reservatorPhone,
      'startDateTime': instance.startDateTime,
      'endDateTime': instance.endDateTime,
      'goal': instance.goal,
      'bookingStatus': instance.bookingStatus,
    };
