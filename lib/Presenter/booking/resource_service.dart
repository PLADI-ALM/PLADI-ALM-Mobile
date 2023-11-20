

import 'package:dio/dio.dart';
import 'package:frontend/Model/model/booking/resource_model.dart';
import 'package:intl/intl.dart';

import '../../Model/model/general_model.dart';
import '../../Model/network/api_manager.dart';

class ResourceService {
  final resourceURL = '/resources';
  final resourceBookingHistoryURL = '/bookings/resources';
  final resourceAdminBookingHistoryURL = '/admin/bookings/resources';

  DateTime? startDate;
  DateTime? startTime;
  DateTime? endDate;
  DateTime? endTime;

  String keyword = '';

  /// Singleton Pattern
  static final ResourceService _resourceService = ResourceService._();
  ResourceService._();
  factory ResourceService() {
    return _resourceService;
  }

  Future<dynamic> getResourceListData() async {
    final response = await APIManager().request(
        RequestType.get,
        resourceURL,
        null,
        (keyword.isEmpty)
            ? null
            : { "resourceName" : keyword,
                "startDate" : '${DateFormat('yyyy-MM-dd').format(startDate!)} ${DateFormat('HH:mm').format(startTime!)}',
                "endDate" : '${DateFormat('yyyy-MM-dd').format(endDate!)} ${DateFormat('HH:mm').format(endTime!)}'
              },
        null
    );
    return response;
  }

  Future<dynamic> getResourceDetailData(int resourceId) async {
    final response = await APIManager().request(
        RequestType.get,
        '$resourceURL/$resourceId',
        null, null, null
    );
    return response;
  }

  Future<dynamic> getBookedTimeList(int resourceId, DateTime selectedMonth, DateTime? selectedDay) async {
    String selectedMonthStr = DateFormat('yyyy-MM').format(selectedMonth);
    String selectedDayStr = (selectedDay != null) ? DateFormat('yyyy-MM-dd').format(selectedDay!) : '';

    print('selectedMonthStr - $selectedMonthStr');
    print('selectedDayStr - $selectedDayStr');

    final response = await APIManager().request(
        RequestType.get,
        '$resourceURL/$resourceId/booking-state',
        null,
        {
          'month':selectedMonthStr,
          // 'date':selectedDayStr
        },
        null
    );
    return response;
  }

  Future<dynamic> getBookedInfo(int resourceId, DateTime selectedDate, int selectedTime) async {
    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    String selectedTimeStr = (selectedTime < 10) ? '0$selectedTime:00' : '$selectedTime:00';

    final response = await APIManager().request(
        RequestType.get,
        '$resourceURL/$resourceId/booking',
        null,
        {'dateTime':'$selectedDateStr $selectedTimeStr'},
        null
    );
    return response;
  }

  Future<dynamic> getBookedDetailInfo(int resourceId, DateTime selectedDate, int selectedTime) async {
    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    String startTimeStr = (selectedTime < 10) ? '0$startTime:00' : '$startTime:00';

    final response = await APIManager().request(
        RequestType.get,
        '$resourceURL/$resourceId/booking',
        null,
        {'date':selectedDateStr, 'time':startTimeStr},
        null
    );
    return response;
  }

  Future<dynamic> bookResource(int resourceId, DateTime startDate, DateTime endDate, String memo) async {

    String startDateStr = DateFormat('yyyy-MM-dd HH').format(startDate);
    String endDateStr = DateFormat('yyyy-MM-dd HH').format(endDate);

    ResourceBookingRequest body = ResourceBookingRequest(
        startDateTime: startDateStr,
        endDateTime: endDateStr,
        memo: memo,
    );

    try {
      final response = await APIManager().request(
          RequestType.post,
          '$resourceURL/$resourceId',
          null, null,
          body.toJson()
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

  // 장비 예약 목록 조회
  Future<dynamic> getResourceBookingHistoryList(bool isAdmin) async {
    String url = isAdmin ? resourceAdminBookingHistoryURL : resourceBookingHistoryURL;
    final response = await APIManager().request(
        RequestType.get,
        url,
        null, null, null
    );
    return response;
  }

  // 장비 예약 취소
  Future<dynamic> cancelBooking(int bookingId) async {
    try {
      final response = await APIManager().request(
          RequestType.patch,
          '$resourceBookingHistoryURL/$bookingId/cancel',
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

  // 장비 예약 반납
  Future<dynamic> returnBooking(int bookingId) async {
    final response = await APIManager().request(
        RequestType.patch,
        '$resourceBookingHistoryURL/$bookingId',
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