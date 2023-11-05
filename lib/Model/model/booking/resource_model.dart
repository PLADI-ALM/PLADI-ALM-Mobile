import 'package:json_annotation/json_annotation.dart';

import '../general_list_model.dart';
import '../general_model.dart';

part 'resource_model.g.dart';

@JsonSerializable()
class ResourceResponseModel extends GeneralModel {
  final ResourceResponse data;

  ResourceResponseModel({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory ResourceResponseModel.fromJson(Map<String, dynamic> json)
  => _$ResourceResponseModelFromJson(json);
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

  factory ResourceResponse.fromJson(Map<String, dynamic> json)
  => _$ResourceResponseFromJson(json);
}

@JsonSerializable()
class ResourceInfo {
  String description;
  String location;
  String imgUrl;
  String name;
  int resourceId;

  ResourceInfo({
    required this.description,
    required this.location,
    required this.imgUrl,
    required this.name,
    required this.resourceId,
  });

  factory ResourceInfo.fromJson(Map<String, dynamic> json)
  => _$ResourceInfoFromJson(json);
}