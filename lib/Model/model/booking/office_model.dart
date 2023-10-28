
import 'package:frontend/Model/model/general_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../general_list_model.dart';

part 'office_model.g.dart';

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
    required super.pageable, required super.last, required super.totalPages, required super.totalElements, required super.size, required super.number, required super.sort, required super.first, required super.numberOfElements, required super.empty, required this.content,
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