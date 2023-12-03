import 'package:frontend/Model/model/general_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'equipment_category_model.g.dart';

@JsonSerializable()
class EquipmentCategoryResponseModel extends GeneralModel {
  final EquipmentCategory data;

  EquipmentCategoryResponseModel(
      {required super.status,
      required super.code,
      required super.message,
      required this.data});

  factory EquipmentCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentCategoryResponseModelFromJson(json);
}

@JsonSerializable()
class EquipmentCategory {
  List<String> categoryNames;

  EquipmentCategory({
    required this.categoryNames,
  });

  factory EquipmentCategory.fromJson(Map<String, dynamic> json) =>
      _$EquipmentCategoryFromJson(json);
}
