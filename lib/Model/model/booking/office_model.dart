
import 'package:frontend/Model/model/general_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../general_list_model.dart';

part 'office_model.g.dart';

/// 회의실 목록 조회를 위한 데이터 모델
@JsonSerializable()
class OfficeResponseModel extends GeneralModel {
  final OfficeResponse data;

  OfficeResponseModel({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory OfficeResponseModel.fromJson(Map<String, dynamic> json)
  => _$OfficeResponseModelFromJson(json);
}

@JsonSerializable()
class OfficeResponse extends GeneralListModel {
  List<OfficeInfo> content;

  OfficeResponse({
    required super.pageable,
    required super.last,
    required super.totalPages,
    required super.totalElements,
    required super.size,
    required super.number,
    required super.sort,
    required super.first,
    required super.numberOfElements,
    required super.empty,
    required this.content,
  });

  factory OfficeResponse.fromJson(Map<String, dynamic> json)
  => _$OfficeResponseFromJson(json);
}

@JsonSerializable()
class OfficeInfo {
  String location;
  int capacity;
  String description;
  List<String?> facilityList;
  String imgUrl;
  String name;
  int officeId;

  OfficeInfo({
    required this.location,
    required this.capacity,
    required this.description,
    required this.facilityList,
    required this.imgUrl,
    required this.name,
    required this.officeId,
  });

  factory OfficeInfo.fromJson(Map<String, dynamic> json)
  => _$OfficeInfoFromJson(json);
}

/// 회의실 개별 조회를 위한 데이터 모델
@JsonSerializable()
class OfficeDetailResponse extends GeneralModel {

  OfficeDetailInfo data;

  OfficeDetailResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory OfficeDetailResponse.fromJson(Map<String, dynamic> json)
  => _$OfficeDetailResponseFromJson(json);
}

@JsonSerializable()
class OfficeDetailInfo {
  String location;
  int capacity;
  String description;
  List<String?> facilityList;
  String imgUrl;
  String name;
  int officeId;
  bool isActive;

  OfficeDetailInfo({
    required this.location,
    required this.capacity,
    required this.description,
    required this.facilityList,
    required this.imgUrl,
    required this.name,
    required this.officeId,
    required this.isActive,
  });

  factory OfficeDetailInfo.fromJson(Map<String, dynamic> json)
  => _$OfficeDetailInfoFromJson(json);
}

/// 회의실 예약 현황 데이터 모델
@JsonSerializable()
class OfficeBookingResponse extends GeneralModel {

  OfficeBookingInfo data;

  OfficeBookingResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory OfficeBookingResponse.fromJson(Map<String, dynamic> json)
  => _$OfficeBookingResponseFromJson(json);
}

@JsonSerializable()
class OfficeBookingInfo {

  List<BookingTime?> bookedTimes;

  OfficeBookingInfo({
    required this.bookedTimes,
  });

  factory OfficeBookingInfo.fromJson(Map<String, dynamic> json)
  => _$OfficeBookingInfoFromJson(json);
}

@JsonSerializable()
class BookingTime {

  String startTime;
  String endTime;

  BookingTime({
    required this.startTime,
    required this.endTime,
  });

  factory BookingTime.fromJson(Map<String, dynamic> json)
  => _$BookingTimeFromJson(json);
}

@JsonSerializable()
class BookingDetailResponse extends GeneralModel {

  BookingDetail? data;

  BookingDetailResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory BookingDetailResponse.fromJson(Map<String, dynamic> json)
  => _$BookingDetailResponseFromJson(json);
}

@JsonSerializable()
class BookingDetail {

  String reservatorName;
  String reservatorPhone;
  String department;

  BookingDetail({
    required this.reservatorName,
    required this.reservatorPhone,
    required this.department,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json)
  => _$BookingDetailFromJson(json);
}

/// 회의실 예약 데이터 모델
@JsonSerializable()
class OfficeBookingRequest {

  String date;
  String startTime;
  String endTime;
  String memo;

  OfficeBookingRequest({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.memo,
  });

  Map<String, dynamic> toJson() => _$OfficeBookingRequestToJson(this);
}