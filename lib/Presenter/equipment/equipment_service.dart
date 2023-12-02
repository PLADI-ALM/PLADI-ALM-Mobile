import 'package:dio/dio.dart';
import 'package:frontend/Model/model/equipment/equipment_category_model.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:frontend/Model/network/api_manager.dart';

class EquipmentService {
  final equipmentURL = '/equipments?cond=';
  final equipmentCategoryURL = "/equipments/categories";

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

  Future<dynamic> getEquipmentCategory() async {
    final response = APIManager()
        .request(RequestType.get, equipmentCategoryURL, null, null, null);
    return response;
  }
}
