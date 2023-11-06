
import 'package:dio/dio.dart';
import 'package:frontend/Model/model/booking/office_model.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:intl/intl.dart';

import '../../Model/network/api_manager.dart';

class OfficeService {
  final officeInfoURL = '/offices';

  /// Singleton Pattern
  static final OfficeService _officeService = OfficeService._();
  OfficeService._();
  factory OfficeService() {
    return _officeService;
  }

  Future<dynamic> getOfficeInfoData(int officeId) async {
    final response = await APIManager().request(
        RequestType.get,
        '$officeInfoURL/$officeId',
        null, null, null
    );
    return response;
  }

  Future<dynamic> getBookedTimeList(int officeId, DateTime selectedDate) async {
    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    final response = await APIManager().request(
        RequestType.get,
        '$officeInfoURL/$officeId/booking-state',
        null,
        {'date':selectedDateStr},
        null
    );
    return response;
  }

  Future<dynamic> getBookedInfo(int officeId, DateTime selectedDate, int startTime) async {
    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    String startTimeStr = (startTime < 10) ? '0$startTime:00' : '$startTime:00';

    print('selectedDateStr - $selectedDateStr');
    print('startTimeStr - $startTimeStr');
    final response = await APIManager().request(
        RequestType.get,
        '$officeInfoURL/$officeId/booking',
        null,
        {'date':selectedDateStr, 'time':startTimeStr},
        null
    );
    return response;
  }

  Future<dynamic> bookOffice(int officeId, DateTime selectedDate, int startIdx, int endIdx, String memo) async {

    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    String startTime = (startIdx < 10) ? '0$startIdx:00' : '$startIdx:00';
    String endTime = (endIdx < 10) ? '0$endIdx:00' : '$endIdx:00';

    OfficeBookingRequest body = OfficeBookingRequest(
        date: selectedDateStr,
        startTime: startTime,
        endTime: endTime,
        memo: memo
    );

    try {
      final response = await APIManager().request(
          RequestType.post,
          '$officeInfoURL/$officeId/booking',
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

}