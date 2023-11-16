

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../Model/model/general_model.dart';
import '../../Model/network/api_manager.dart';

class CarService {
  final carURL = '/cars';
  final carBookingHistoryURL = '/bookings/cars';

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
    final response = await APIManager().request(
        RequestType.get,
        carURL,
        null,
        (keyword.isEmpty)
            ? null
            : { "carName" : keyword,
                "startDate" : '${DateFormat('yyyy-MM-dd').format(startDate!)} ${DateFormat('HH:mm').format(startTime!)}',
                "endDate" : '${DateFormat('yyyy-MM-dd').format(endDate!)} ${DateFormat('HH:mm').format(endTime!)}'
              },
        null
    );
    return response;
  }

  Future<dynamic> getCarDetailData(int carId) async {
    final response = await APIManager().request(
        RequestType.get,
        '$carURL/$carId',
        null, null, null
    );
    return response;
  }

  // 차량 예약 목록 조회
  Future<dynamic> getCarBookingHistoryList() async {
    final response = await APIManager().request(
        RequestType.get,
        carBookingHistoryURL,
        null, null, null
    );
    return response;
  }

  // 차량 예약 취소
  Future<dynamic> cancelBooking(int bookingId) async {
    try {
      final response = await APIManager().request(
          RequestType.patch,
          '$carBookingHistoryURL/$bookingId/cancel',
          null, null, null
      );

      if (response != null) {
        final data = GeneralModel.fromJson(response);
        return data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error = GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }

  // 차량 예약 반납
  Future<dynamic> returnBooking(int bookingId) async {
    final response = await APIManager().request(
        RequestType.patch,
        '$carBookingHistoryURL/$bookingId',
        null, null, null
    );
    return response;
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
    return ((startDate == null) || (endDate == null) || (startTime == null) || (endTime == null));
  }

}