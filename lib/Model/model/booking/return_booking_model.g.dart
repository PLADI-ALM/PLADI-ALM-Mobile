// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnBookingRequest _$ReturnBookingRequestFromJson(
        Map<String, dynamic> json) =>
    ReturnBookingRequest(
      remark: json['remark'] as String?,
      returnLocation: json['returnLocation'] as String,
    );

Map<String, dynamic> _$ReturnBookingRequestToJson(
        ReturnBookingRequest instance) =>
    <String, dynamic>{
      'remark': instance.remark,
      'returnLocation': instance.returnLocation,
    };
