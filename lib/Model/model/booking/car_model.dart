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

  factory CarResponseModel.fromJson(Map<String, dynamic> json)
  => _$CarResponseModelFromJson(json);
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

  factory CarResponse.fromJson(Map<String, dynamic> json)
  => _$CarResponseFromJson(json);
}

@JsonSerializable()
class CarInfo {
  String description;
  String location;
  String imgUrl;
  String name;
  int carId;

  CarInfo({
    required this.description,
    required this.location,
    required this.imgUrl,
    required this.name,
    required this.carId,
  });

  factory CarInfo.fromJson(Map<String, dynamic> json)
  => _$CarInfoFromJson(json);
}