import 'package:frontend/Model/network/api_manager.dart';

class EquipmentService {
  final equipmentURL = '/equipments?size=100';

  static final EquipmentService _equipmentService = EquipmentService._();
  EquipmentService._();
  factory EquipmentService() {
    return _equipmentService;
  }

  Future<dynamic> getEquipment() async {
    final response =
        APIManager().request(RequestType.get, equipmentURL, null, null, null);
    return response;
  }
}
