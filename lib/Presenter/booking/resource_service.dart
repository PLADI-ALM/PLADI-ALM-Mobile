

import '../../Model/network/api_manager.dart';

class ResourceService {
  final resourceURL = '/resources';

  String keyword = '';
  String startDate = '';
  String endDate = '';

  /// Singleton Pattern
  static final ResourceService _resourceService = ResourceService._();
  ResourceService._();
  factory ResourceService() {
    return _resourceService;
  }

  Future<dynamic> getResourceDetailData(int resourceId) async {
    final response = await APIManager().request(
        RequestType.get,
        '$resourceURL/$resourceId',
        null, null, null
    );
    return response;
  }
}