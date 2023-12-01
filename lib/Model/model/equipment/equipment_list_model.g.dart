// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentResponseModel _$EquipmentResponseModelFromJson(
        Map<String, dynamic> json) =>
    EquipmentResponseModel(
      status: json['status'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      data: EquipmentResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EquipmentResponseModelToJson(
        EquipmentResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

EquipmentResponse _$EquipmentResponseFromJson(Map<String, dynamic> json) =>
    EquipmentResponse(
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
          .map((e) => EquipmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EquipmentResponseToJson(EquipmentResponse instance) =>
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

EquipmentModel _$EquipmentModelFromJson(Map<String, dynamic> json) =>
    EquipmentModel(
      category: json['category'] as String,
      contact: json['contact'] as String,
      description: json['description'] as String?,
      equipmentId: json['equipmentId'] as int,
      imgUrl: json['imgUrl'] as String?,
      keeper: json['keeper'] as String,
      location: json['location'] as String?,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$EquipmentModelToJson(EquipmentModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'contact': instance.contact,
      'description': instance.description,
      'equipmentId': instance.equipmentId,
      'imgUrl': instance.imgUrl,
      'keeper': instance.keeper,
      'location': instance.location,
      'name': instance.name,
      'quantity': instance.quantity,
    };
