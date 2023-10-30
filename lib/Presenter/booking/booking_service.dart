
import '../../Model/network/api_manager.dart';

class BookingService {
  final officeListURL = '/offices';
  final resourceListURL = '/resources';

  String keyword = '';

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
        (keyword.isNotEmpty) ? {"facilityName" : keyword} : null,
        null
    );
    return response;
  }

  Future<dynamic> getResourceListData() async {
    final response = await APIManager().request(
      RequestType.get,
      resourceListURL,
      null,
      (keyword.isNotEmpty) ? {"resourceName" : keyword} : null,
      null
    );
    return response;
  }

  /// Helper Methods
  void setKeyword(String input) { keyword = input; }
  String getKeyword() { return keyword; }
}