import 'package:frontend/Model/model/general_list_model.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponseModel extends GeneralModel {
  final NotificationResponse data;

  NotificationResponseModel({
    required super.status,
    required super.code,
    required super.message,
    required this.data,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseModelFromJson(json);
}

@JsonSerializable()
class NotificationResponse extends GeneralListModel {
  List<NotificationModel> content;

  NotificationResponse({
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

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}

@JsonSerializable()
class NotificationModel {
  String createdAt;
  String notificationInfo;
  String notificationType;

  NotificationModel({
    required this.createdAt,
    required this.notificationInfo,
    required this.notificationType,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
