import 'package:json_annotation/json_annotation.dart';

import '../general_list_model.dart';
import '../general_model.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarResponseModel extends GeneralModel {
  final CarResponse data;

  CarResponseModel({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory CarResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CarResponseModelFromJson(json);
}

@JsonSerializable()
class CarResponse extends GeneralListModel {
  List<CarInfo> content;

  CarResponse({
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

  factory CarResponse.fromJson(Map<String, dynamic> json) =>
      _$CarResponseFromJson(json);
}

@JsonSerializable()
class CarInfo {
  String? description;
  String? location;
  String? manufacturer;
  String? imgUrl;
  String name;
  int carId;

  CarInfo({
    this.description,
    this.location,
    this.imgUrl,
    required this.name,
    required this.carId,
  });

  factory CarInfo.fromJson(Map<String, dynamic> json) =>
      _$CarInfoFromJson(json);
}

/// 차량 세부 조회용 데이터 모델
@JsonSerializable()
class CarDetailResponse extends GeneralModel {
  CarDetailInfo data;

  CarDetailResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory CarDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CarDetailResponseFromJson(json);
}

@JsonSerializable()
class CarDetailInfo {
  String? description;
  String? imgUrl;
  String? location;
  String? manufacturer;
  String? name;
  int? responsibilityId;
  String? responsibilityName;
  String? responsibilityPhone;

  CarDetailInfo({
    required this.description,
    required this.imgUrl,
    required this.location,
    required this.name,
    required this.responsibilityId,
    required this.responsibilityName,
    required this.responsibilityPhone,
  });

  factory CarDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$CarDetailInfoFromJson(json);
}

/// 차량 예약 목록 조회 데이터 모델
@JsonSerializable()
class CarBookingHistoryResponse extends GeneralModel {
  CarBookingHistoryData data;

  CarBookingHistoryResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory CarBookingHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CarBookingHistoryResponseFromJson(json);
}

@JsonSerializable()
class CarBookingHistoryData {
  List<CarBookingHistory> content;

  CarBookingHistoryData({
    required this.content,
  });

  factory CarBookingHistoryData.fromJson(Map<String, dynamic> json) =>
      _$CarBookingHistoryDataFromJson(json);
}

@JsonSerializable()
class CarBookingHistory {
  int id;
  int targetId;
  String name;
  String? location;
  String startDateTime;
  String endDateTime;
  String? memo;
  String status;

  CarBookingHistory({
    required this.id,
    required this.targetId,
    required this.name,
    this.location,
    required this.startDateTime,
    required this.endDateTime,
    this.memo,
    required this.status,
  });

  factory CarBookingHistory.fromJson(Map<String, dynamic> json) =>
      _$CarBookingHistoryFromJson(json);
}

/// 장비 예약 데이터 모델
@JsonSerializable()
class CarBookingRequest {
  String startDateTime;
  String endDateTime;
  String memo;

  CarBookingRequest({
    required this.startDateTime,
    required this.endDateTime,
    required this.memo,
  });

  Map<String, dynamic> toJson() => _$CarBookingRequestToJson(this);
}

@JsonSerializable()
class AdminCarBookingHistoryResponse extends GeneralModel {
  AdminCarBookingHistory data;

  AdminCarBookingHistoryResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory AdminCarBookingHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCarBookingHistoryResponseFromJson(json);
}

@JsonSerializable()
class AdminCarBookingHistory {
  int id;
  String responsibilityName;
  String responsibilityPhone;
  String? description;
  String imgUrl;
  List<CarsList> productList;

  AdminCarBookingHistory({
    required this.id,
    required this.responsibilityName,
    required this.responsibilityPhone,
    required this.description,
    required this.imgUrl,
    required this.productList,
  });

  factory AdminCarBookingHistory.fromJson(Map<String, dynamic> json) =>
      _$AdminCarBookingHistoryFromJson(json);
}

@JsonSerializable()
class CarsList {
  String reservatorName;
  String reservatorPhone;
  String startDateTime;
  String endDateTime;
  String? memo;
  String bookingStatus;

  CarsList({
    required this.reservatorName,
    required this.reservatorPhone,
    required this.startDateTime,
    required this.endDateTime,
    required this.memo,
    required this.bookingStatus,
  });

  factory CarsList.fromJson(Map<String, dynamic> json) =>
      _$CarsListFromJson(json);
}
