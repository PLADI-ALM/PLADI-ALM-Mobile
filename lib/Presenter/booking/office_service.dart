
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

}