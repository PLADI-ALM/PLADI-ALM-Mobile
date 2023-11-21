import 'package:json_annotation/json_annotation.dart';

part 'return_booking_model.g.dart';

@JsonSerializable()
class ReturnBookingRequest {
  String? remark;
  String returnLocation;

  ReturnBookingRequest({
    required this.remark,
    required this.returnLocation,
  });

  Map<String, dynamic> toJson() => _$ReturnBookingRequestToJson(this);
}