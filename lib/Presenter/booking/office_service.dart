import 'package:dio/dio.dart';
import 'package:frontend/Model/model/booking/office_model.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:intl/intl.dart';

import '../../Model/network/api_manager.dart';

class OfficeService {
  final officeURL = '/offices';
  final officeBookingHistoryURL = '/bookings/offices';
  final officeAdminBookingHistoryURL = '/admin/bookings/offices';

  DateTime? selectedDate;
  DateTime? startTime;
  DateTime? endTime;

  String keyword = '';
  String selectedDateStr = '';
  String startTimeStr = '';
  String endTimeStr = '';

  /// Singleton Pattern
  static final OfficeService _officeService = OfficeService._();
  OfficeService._();
  factory OfficeService() {
    return _officeService;
  }

  Future<dynamic> getOfficeListData() async {
    final response = await APIManager().request(
        RequestType.get,
        officeURL,
        null,
        (keyword.isEmpty)
            ? null
            : {
                "facilityName": keyword,
                "startDate": '$selectedDateStr $startTimeStr',
                "endDate": '$selectedDateStr $endTimeStr'
              },
        null);
    return response;
  }

  Future<dynamic> getOfficeInfoData(int officeId) async {
    final response = await APIManager()
        .request(RequestType.get, '$officeURL/$officeId', null, null, null);
    return response;
  }

  Future<dynamic> getBookedTimeList(int officeId, DateTime selectedDate) async {
    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    final response = await APIManager().request(
        RequestType.get,
        '$officeURL/$officeId/booking-state',
        null,
        {'date': selectedDateStr},
        null);
    return response;
  }

  Future<dynamic> getBookedInfo(
      int officeId, DateTime selectedDate, int startTime) async {
    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    String startTimeStr = (startTime < 10) ? '0$startTime:00' : '$startTime:00';

    final response = await APIManager().request(
        RequestType.get,
        '$officeURL/$officeId/booking',
        null,
        {'date': selectedDateStr, 'time': startTimeStr},
        null);
    return response;
  }

  Future<dynamic> bookOffice(int officeId, DateTime selectedDate, int startIdx,
      int endIdx, String memo) async {
    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    String startTime = (startIdx < 10) ? '0$startIdx:00' : '$startIdx:00';
    String endTime = (endIdx < 10) ? '0$endIdx:00' : '$endIdx:00';

    OfficeBookingRequest body = OfficeBookingRequest(
        date: selectedDateStr,
        startTime: startTime,
        endTime: endTime,
        memo: memo);

    try {
      final response = await APIManager().request(RequestType.post,
          '$officeURL/$officeId/booking', null, null, body.toJson());

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

  // 회의실 예약 목록 조회
  Future<dynamic> getOfficeBookingHistoryList(bool isAdmin) async {
    String url =
        isAdmin ? officeAdminBookingHistoryURL : officeBookingHistoryURL;
    final response =
        await APIManager().request(RequestType.get, url, null, null, null);
    return response;
  }

  Future<dynamic> getAdminOfficeBookingHistoryList(int officeId) async {
    String url = "/admin/offices/offices/$officeId";
    final response =
        await APIManager().request(RequestType.get, url, null, null, null);
    return response;
  }

  // 회의실 예약 취소
  Future<dynamic> cancelBooking(int bookingId, bool isAdmin) async {
    String url = isAdmin
        ? '$officeAdminBookingHistoryURL/$bookingId/cancel'
        : '$officeBookingHistoryURL/$bookingId/cancel';
    final response =
        await APIManager().request(RequestType.patch, url, null, null, null);
    if (response == null) {
      return null;
    } else {
      GeneralModel result = GeneralModel.fromJson(response);
      if (result.status == 200) {
        return true;
      } else {
        return result.message;
      }
    }
  }

  // 회의실 예약 반려
  Future<dynamic> rejectBooking(int bookingId) async {
    try {
      final response = await APIManager().request(RequestType.patch,
          '$officeAdminBookingHistoryURL/$bookingId/cancel', null, null, null);

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
  void setDate(DateTime date) {
    selectedDate = date;
    selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate!);
  }

  void setStartTime(DateTime time) {
    startTime = time;
    startTimeStr = DateFormat('HH:mm').format(startTime!);
  }

  void setEndTime(DateTime time) {
    endTime = time;
    endTimeStr = DateFormat('HH:mm').format(endTime!);
  }

  bool isFilterInfoEmpty() {
    return (selectedDateStr.isEmpty ||
        startTimeStr.isEmpty ||
        endTimeStr.isEmpty);
  }
}
