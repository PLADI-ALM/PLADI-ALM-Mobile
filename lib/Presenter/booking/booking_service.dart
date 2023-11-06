
import 'package:intl/intl.dart';

import '../../Model/network/api_manager.dart';

class BookingService {
  final officeListURL = '/offices';
  final carListURL = '/cars';
  final resourceListURL = '/resources';

  DateTime? selectedDate;
  DateTime? startTime;
  DateTime? endTime;

  String keyword = '';
  String selectedDateStr = '';
  String startTimeStr = '';
  String endTimeStr = '';



  /// Singleton Pattern
  static final BookingService _bookingService = BookingService._();
  BookingService._();
  factory BookingService() {
    return _bookingService;
  }

  Future<dynamic> getOfficeListData() async {
    final response = await APIManager().request(
        RequestType.get,
        officeListURL,
        null,
        (keyword.isEmpty)
            ? null
            : {"facilityName" : keyword, "startDate" : '$selectedDateStr $startTimeStr', "endDate" : '$selectedDateStr $endTimeStr'},
        null
    );
    return response;
  }

  Future<dynamic> getCarListData() async {
    final response = await APIManager().request(
        RequestType.get,
        carListURL,
        null,
        (keyword.isEmpty)
            ? null
            : {"carName" : keyword,  "startDate" : '$selectedDateStr $startTimeStr', "endDate" : '$selectedDateStr $endTimeStr'},
        null
    );
    return response;
  }

  Future<dynamic> getResourceListData() async {
    final response = await APIManager().request(
      RequestType.get,
      resourceListURL,
      null,
      (keyword.isEmpty)
          ? null
          : {"resourceName" : keyword, "startDate" : '$selectedDateStr $startTimeStr', "endDate" : '$selectedDateStr $endTimeStr'},
      null
    );
    return response;
  }

  /// Helper Methods
  void setKeyword(String input) { keyword = input; }
  String getKeyword() { return keyword; }

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
    return (selectedDateStr.isEmpty || startTimeStr.isEmpty || endTimeStr.isEmpty);
  }
}