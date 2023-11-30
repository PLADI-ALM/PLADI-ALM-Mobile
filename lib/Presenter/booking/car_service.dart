import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../Model/model/booking/return_booking_model.dart';
import '../../Model/model/general_model.dart';
import '../../Model/network/api_manager.dart';

class CarService {
  final carURL = '/cars';
  final carBookingHistoryURL = '/bookings/cars';
  final carAdminBookingHistoryURL = '/admin/bookings/cars';

  DateTime? startDate;
  DateTime? startTime;
  DateTime? endDate;
  DateTime? endTime;

  String keyword = '';

  /// Singleton Pattern
  static final CarService _carService = CarService._();
  CarService._();
  factory CarService() {
    return _carService;
  }

  Future<dynamic> getCarListData() async {
    String startTimeStr = '';
    String endTimeStr = '';

    if (startDate != null && startTime != null) {
      startTimeStr = '${DateFormat('yyyy-MM-dd').format(startDate!)} ${DateFormat('HH:mm').format(startTime!)}';
    }

    if (endDate != null && endTime != null) {
      endTimeStr = '${DateFormat('yyyy-MM-dd').format(endDate!)} ${DateFormat('HH:mm').format(endTime!)}';
    }


    final response = await APIManager().request(
        RequestType.get,
        carURL,
        null,
        (keyword.isEmpty)
            ? null
            : {
                "carName": keyword,
                "startDate": startTimeStr,
                "endDate": endTimeStr
              },
        null);
    return response;
  }

  Future<dynamic> getCarDetailData(int carId) async {
    final response = await APIManager()
        .request(RequestType.get, '$carURL/$carId', null, null, null);
    return response;
  }

  Future<dynamic> getAdminCarBookingHistoryList(int id) async {
    String url = "/admin/cars/$id";
    final response =
        await APIManager().request(RequestType.get, url, null, null, null);
    return response;
  }

  // 차량 예약 목록 조회
  Future<dynamic> getCarBookingHistoryList(bool isAdmin) async {
    String url = isAdmin ? carAdminBookingHistoryURL : carBookingHistoryURL;
    final response =
        await APIManager().request(RequestType.get, url, null, null, null);
    return response;
  }

  // 차량 예약 취소
  Future<dynamic> cancelBooking(int bookingId) async {
    try {
      final response = await APIManager().request(RequestType.patch,
          '$carBookingHistoryURL/$bookingId/cancel', null, null, null);

      if (response != null) {
        final data = GeneralModel.fromJson(response);
        return data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }

  // 차량 예약 반납
  Future<dynamic> returnBooking(
      bool isAdmin, int bookingId, String location, String? remark) async {
    String url = isAdmin
        ? '$carAdminBookingHistoryURL/$bookingId/return'
        : '$carBookingHistoryURL/$bookingId/return';

    ReturnBookingRequest body =
        ReturnBookingRequest(remark: remark, returnLocation: location);

    try {
      final response = await APIManager()
          .request(RequestType.patch, url, null, null, body.toJson());

      if (response != null) {
        final data = GeneralModel.fromJson(response);
        return data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }

  // 차량 예약 반려
  Future<dynamic> rejectBooking(int bookingId) async {
    try {
      final response = await APIManager().request(RequestType.patch,
          '$carAdminBookingHistoryURL/$bookingId/reject', null, null, null);

      if (response != null) {
        final data = GeneralModel.fromJson(response);
        return data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }

  /// Helper Methods
  void setStartInfo(DateTime date, DateTime time) {
    startDate = date;
    startTime = time;
  }

  void setEndInfo(DateTime date, DateTime time) {
    endDate = date;
    endTime = time;
  }

  bool isFilterInfoEmpty() {
    return ((startDate == null) ||
        (endDate == null) ||
        (startTime == null) ||
        (endTime == null));
  }
}
