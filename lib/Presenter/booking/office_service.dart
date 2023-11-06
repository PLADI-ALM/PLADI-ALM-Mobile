
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

}