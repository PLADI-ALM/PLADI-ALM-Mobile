import 'dart:ffi';

import 'package:frontend/Model/model/general_list_model.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'equipment_list_model.g.dart';

@JsonSerializable()
class EquipmentResponseModel extends GeneralModel {
  final EquipmentResponse data;

  EquipmentResponseModel({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory EquipmentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentResponseModelFromJson(json);
}

@JsonSerializable()
class EquipmentResponse extends GeneralListModel {
  List<EquipmentModel> content;

  EquipmentResponse({
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

  factory EquipmentResponse.fromJson(Map<String, dynamic> json) =>
      _$EquipmentResponseFromJson(json);
}

@JsonSerializable()
class EquipmentModel {
  String category;
  String contact;
  String? description;
  int equipmentId;
  String? imgUrl;
  String keeper;
  String? location;
  String name;
  int quantity;

  EquipmentModel({
    required this.category,
    required this.contact,
    required this.description,
    required this.equipmentId,
    required this.imgUrl,
    required this.keeper,
    required this.location,
    required this.name,
    required this.quantity,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentModelFromJson(json);
}
