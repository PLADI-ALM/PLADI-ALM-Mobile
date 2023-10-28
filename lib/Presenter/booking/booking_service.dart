
import '../../Model/network/api_manager.dart';

class BookingService {
  final officeListURL = '/offices';

  /// Singleton Pattern
  static final BookingService _bookingService = BookingService._();
  BookingService._();
  factory BookingService() {
    return _bookingService;
  }

  Future<dynamic> getOfficeListData(String category) async {
    final response = await APIManager().request(
        RequestType.get,
        officeListURL,
        null, null, null
    );
    return response;
  }

}