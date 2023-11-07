

import 'package:intl/intl.dart';

import '../../Model/network/api_manager.dart';

class CarService {
  final carURL = '/cars';

  DateTime? startDate;
  DateTime? startTime;
  DateTime? endDate;
  DateTime? endTime;

  String keyword = '';

  /// Singleton Pattern
  static final CarService _carService = CarService._();
  CarService._();
  factory CarService() {
    return _carService;
  }

  Future<dynamic> getCarListData() async {
    final response = await APIManager().request(
        RequestType.get,
        carURL,
        null,
        (keyword.isEmpty)
            ? null
            : { "carName" : keyword,
                "startDate" : '${DateFormat('yyyy-MM-dd').format(startDate!)} ${DateFormat('HH:mm').format(startTime!)}',
                "endDate" : '${DateFormat('yyyy-MM-dd').format(endDate!)} ${DateFormat('HH:mm').format(endTime!)}'
              },
        null
    );
    return response;
  }

  Future<dynamic> getCarDetailData(int carId) async {
    final response = await APIManager().request(
        RequestType.get,
        '$carURL/$carId',
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