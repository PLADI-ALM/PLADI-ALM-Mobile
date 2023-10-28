
import 'package:frontend/Model/model/general_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'office_model.g.dart';

@JsonSerializable()
class OfficeResponseModel extends GeneralModel {
  final OfficeInfo data;

  OfficeResponseModel({
    required super.status,
    required super.message,
    required this.data,
  });

  factory OfficeResponseModel.fromJson(Map<String, dynamic> json)
  => _$OfficeResponseModelFromJson(json);
}

@JsonSerializable()
class OfficeInfo {
  String capacity;
  String description;
  List<String> facilityList;
  String imgUrl;
  String name;
  int officeId;

  OfficeInfo({
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