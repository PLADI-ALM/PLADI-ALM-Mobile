import 'package:json_annotation/json_annotation.dart';

part 'image_url_model.g.dart';

@JsonSerializable()
class ImageUrlModel {
  String imageKey;
  String presignedUrl;

  ImageUrlModel({
    required this.imageKey,
    required this.presignedUrl,
  });

  factory ImageUrlModel.fromJson(Map<String, dynamic> json) =>
      _$ImageUrlModelFromJson(json);
}
