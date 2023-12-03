// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageUrlModel _$ImageUrlModelFromJson(Map<String, dynamic> json) =>
    ImageUrlModel(
      imageKey: json['imageKey'] as String,
      presignedUrl: json['presignedUrl'] as String,
    );

Map<String, dynamic> _$ImageUrlModelToJson(ImageUrlModel instance) =>
    <String, dynamic>{
      'imageKey': instance.imageKey,
      'presignedUrl': instance.presignedUrl,
    };
