import 'package:frontend/Model/network/api_manager.dart';

class NotificationService {
  final notificationURL = '/users/notification?size=100';

  static final NotificationService _mypageService = NotificationService._();
  NotificationService._();
  factory NotificationService() {
    return _mypageService;
  }

  Future<dynamic> getNotification() async {
    final response = APIManager()
        .request(RequestType.get, notificationURL, null, null, null);
    return response;
  }
}
