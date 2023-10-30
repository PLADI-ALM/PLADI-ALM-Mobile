
import 'package:intl/intl.dart';

import '../../Model/network/api_manager.dart';

class BookingService {
  final officeListURL = '/offices';
  final carListURL = '/cars';
  final resourceListURL = '/resources';

  String keyword = '';
  String startDate = '';
  String endDate = '';

  /// Singleton Pattern
  static final BookingService _bookingService = BookingService._();
  BookingService._();
  factory BookingService() {
    return _bookingService;
  }

  Future<dynamic> getOfficeListData() async {
    setDate();
    final response = await APIManager().request(
        RequestType.get,
        officeListURL,
        null,
        (keyword.isEmpty)
            ? null
            : {"facilityName" : keyword, "startDate" : startDate, "endDate" : endDate},
        null
    );
    return response;
  }

  Future<dynamic> getCarListData() async {
    setDate();
    final response = await APIManager().request(
        RequestType.get,
        carListURL,
        null,
        (keyword.isEmpty)
            ? null
            : {"carName" : keyword, "startDate" : startDate, "endDate" : endDate},
        null
    );
    return response;
  }

  Future<dynamic> getResourceListData() async {
    setDate();
    final response = await APIManager().request(
      RequestType.get,
      resourceListURL,
      null,
      (keyword.isEmpty)
          ? null
          : {"resourceName" : keyword, "startDate" : startDate, "endDate" : endDate},
      null
    );
    return response;
  }

  /// Helper Methods
  void setKeyword(String input) { keyword = input; }
  String getKeyword() { return keyword; }

  void setDate() {
    startDate = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
    endDate = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now().add(const Duration(hours: 1)));
  }
}