// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentCategoryResponseModel _$EquipmentCategoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    EquipmentCategoryResponseModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: EquipmentCategory.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EquipmentCategoryResponseModelToJson(
        EquipmentCategoryResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

EquipmentCategory _$EquipmentCategoryFromJson(Map<String, dynamic> json) =>
    EquipmentCategory(
      categoryNames: (json['categoryNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$EquipmentCategoryToJson(EquipmentCategory instance) =>
    <String, dynamic>{
      'categoryNames': instance.categoryNames,
    };
