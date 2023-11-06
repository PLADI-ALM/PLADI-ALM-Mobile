

import 'package:intl/intl.dart';

import '../../Model/network/api_manager.dart';

class ResourceService {
  final resourceURL = '/resources';

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