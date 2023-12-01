import 'package:json_annotation/json_annotation.dart';

import '../general_list_model.dart';
import '../general_model.dart';

part 'resource_model.g.dart';

/// 장비 목록 조회용 데이터 모델
@JsonSerializable()
class ResourceResponseModel extends GeneralModel {
  final ResourceResponse data;

  ResourceResponseModel({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory ResourceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResourceResponseModelFromJson(json);
}

@JsonSerializable()
class ResourceResponse extends GeneralListModel {
  List<ResourceInfo> content;

  ResourceResponse({
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

  factory ResourceResponse.fromJson(Map<String, dynamic> json) =>
      _$ResourceResponseFromJson(json);
}

@JsonSerializable()
class ResourceInfo {
  String? description;
  String? location;
  String? manufacturer;
  String? imgUrl;
  String name;
  int resourceId;

  ResourceInfo({
    this.description,
    this.location,
    this.manufacturer,
    this.imgUrl,
    required this.name,
    required this.resourceId,
  });

  factory ResourceInfo.fromJson(Map<String, dynamic> json) =>
      _$ResourceInfoFromJson(json);
}

/// 장비 세부 조회용 데이터 모델
@JsonSerializable()
class ResourceDetailResponse extends GeneralModel {
  ResourceDetailInfo data;

  ResourceDetailResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory ResourceDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ResourceDetailResponseFromJson(json);
}

@JsonSerializable()
class ResourceDetailInfo {
  String? description;
  String? location;
  String? imgUrl;
  String? name;
  int? responsibilityId;
  String? responsibilityName;
  String? responsibilityPhone;
  String? manufacturer;

  ResourceDetailInfo({
    required this.description,
    required this.location,
    required this.imgUrl,
    required this.name,
    required this.responsibilityId,
    required this.responsibilityName,
    required this.responsibilityPhone,
    required this.manufacturer,
  });

  factory ResourceDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$ResourceDetailInfoFromJson(json);
}

/// 장비 예약 현황 데이터 모델
@JsonSerializable()
class ResourceBookedList extends GeneralModel {
  List<String> data;

  ResourceBookedList({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory ResourceBookedList.fromJson(Map<String, dynamic> json) =>
      _$ResourceBookedListFromJson(json);
}

/// 장비 날짜별 예약 시간 현황 데이터 모델
@JsonSerializable()
class ResourceBookingOfDateResponse extends GeneralModel {
  List<String?> data;

  ResourceBookingOfDateResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory ResourceBookingOfDateResponse.fromJson(Map<String, dynamic> json) =>
      _$ResourceBookingOfDateResponseFromJson(json);
}

/// 장비 예약 데이터 모델
@JsonSerializable()
class ResourceBookingRequest {
  String startDateTime;
  String endDateTime;
  String memo;

  ResourceBookingRequest({
    required this.startDateTime,
    required this.endDateTime,
    required this.memo,
  });

  Map<String, dynamic> toJson() => _$ResourceBookingRequestToJson(this);
}

@JsonSerializable()
class GeneralBookingInfoListResponse extends GeneralModel {
  List<GeneralBookingDetail>? data;

  GeneralBookingInfoListResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory GeneralBookingInfoListResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralBookingInfoListResponseFromJson(json);
}

@JsonSerializable()
class GeneralBookingDetailResponse extends GeneralModel {
  GeneralBookingDetail? data;

  GeneralBookingDetailResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory GeneralBookingDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralBookingDetailResponseFromJson(json);
}

@JsonSerializable()
class GeneralBookingDetail {
  String reservatorName;
  String reservatorPhone;
  String reservatorDepartment;
  String startDateTime;
  String endDateTime;

  GeneralBookingDetail({
    required this.reservatorName,
    required this.reservatorPhone,
    required this.reservatorDepartment,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory GeneralBookingDetail.fromJson(Map<String, dynamic> json) =>
      _$GeneralBookingDetailFromJson(json);
}

/// 장비 예약 목록 조회 데이터 모델
@JsonSerializable()
class ResourceBookingHistoryResponse extends GeneralModel {
  ResourceBookingHistoryData data;

  ResourceBookingHistoryResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory ResourceBookingHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ResourceBookingHistoryResponseFromJson(json);
}

@JsonSerializable()
class ResourceBookingHistoryData {
  List<ResourceBookingHistory> content;

  ResourceBookingHistoryData({
    required this.content,
  });

  factory ResourceBookingHistoryData.fromJson(Map<String, dynamic> json) =>
      _$ResourceBookingHistoryDataFromJson(json);
}

@JsonSerializable()
class ResourceBookingHistory {
  int id;
  String name;
  String? location;
  String startDateTime;
  String endDateTime;
  String? memo;
  String status;

  ResourceBookingHistory({
    required this.id,
    required this.name,
    this.location,
    required this.startDateTime,
    required this.endDateTime,
    this.memo,
    required this.status,
  });

  factory ResourceBookingHistory.fromJson(Map<String, dynamic> json) =>
      _$ResourceBookingHistoryFromJson(json);
}

@JsonSerializable()
class AdminResourceBookingHistoryResponse extends GeneralModel {
  AdminResourceBookingHistory data;

  AdminResourceBookingHistoryResponse({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory AdminResourceBookingHistoryResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AdminResourceBookingHistoryResponseFromJson(json);
}

@JsonSerializable()
class AdminResourceBookingHistory {
  int id;
  String responsibilityName;
  String responsibilityPhone;
  String? description;
  String imgUrl;
  List<ResourcesList> productList;

  AdminResourceBookingHistory({
    required this.id,
    required this.responsibilityName,
    required this.responsibilityPhone,
    required this.description,
    required this.imgUrl,
    required this.productList,
  });

  factory AdminResourceBookingHistory.fromJson(Map<String, dynamic> json) =>
      _$AdminResourceBookingHistoryFromJson(json);
}

@JsonSerializable()
class ResourcesList {
  String reservatorName;
  String reservatorPhone;
  String startDateTime;
  String endDateTime;
  String? memo;
  String bookingStatus;

  ResourcesList({
    required this.reservatorName,
    required this.reservatorPhone,
    required this.startDateTime,
    required this.endDateTime,
    required this.memo,
    required this.bookingStatus,
  });

  factory ResourcesList.fromJson(Map<String, dynamic> json) =>
      _$ResourcesListFromJson(json);
}
