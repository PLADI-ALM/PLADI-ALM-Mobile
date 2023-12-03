import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/Model/model/equipment/equipment_add_request.dart';
import 'package:frontend/Model/model/equipment/image_url_request.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:frontend/Model/network/api_manager.dart';

class EquipmentService {
  final equipmentGetURL = '/equipments?size=200&cond=';
  final equipmentPostURL = '/equipments';
  final equipmentCategoryURL = "/equipments/categories";
  final bukitURL =
      "https://gpkzpnv8lh.execute-api.ap-northeast-2.amazonaws.com/dev/presignedurl-lambda";

  String? url;
  String? key;

  static final EquipmentService _equipmentService = EquipmentService._();
  EquipmentService._();
  factory EquipmentService() {
    return _equipmentService;
  }

  Future<dynamic> getEquipment(String cond) async {
    final response = APIManager()
        .request(RequestType.get, equipmentGetURL + cond, null, null, null);
    return response;
  }

  Future<dynamic> getEquipmentCategory() async {
    final response = APIManager()
        .request(RequestType.get, equipmentCategoryURL, null, null, null);
    return response;
  }

  Future<dynamic> getImageUrl() async {
    final body = ImageUrlRequest(ext: "jpeg", dir: "equipment").toJson();
    final response =
        APIManager().imageRequest(RequestType.post, bukitURL, null, null, body);

    return response;
  }

  Future<dynamic> putIamge(String url, File image) async {
    Dio dio = Dio();
    var len = await image.length();
    var response = await dio.put(url,
        data: image.openRead(),
        options: Options(contentType: "multiple/form-data", headers: {
          Headers.contentLengthHeader: len,
        } // set content-length
            ));
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> addEquipment(String category, String? description,
      String? imgKey, String? location, String name, String quantity) async {
    try {
      final body = EquipmentAddRequest(
              category: category,
              description: description,
              imgKey: imgKey,
              location: location,
              name: name,
              quantity: quantity)
          .toJson();

      var response = APIManager()
          .request(RequestType.post, equipmentPostURL, null, null, body);
      if (response != null) {
        return true;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }

  Future<dynamic> editEquipment(
      int equipmentId,
      String category,
      String? description,
      String? imgKey,
      String? location,
      String name,
      String quantity) async {
    try {
      final body = EquipmentAddRequest(
              category: category,
              description: description,
              imgKey: imgKey,
              location: location,
              name: name,
              quantity: quantity)
          .toJson();

      var response = APIManager().request(RequestType.patch,
          "$equipmentPostURL/$equipmentId", null, null, body);
      if (response != null) {
        return true;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }

  Future<dynamic> deleteEquipment(int equipmentId) async {
    try {
      var response = APIManager().request(RequestType.delete,
          "$equipmentPostURL/$equipmentId", null, null, null);
      if (response != null) {
        return true;
      }
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final error =
            GeneralModel.fromJson(response.data as Map<String, dynamic>);
        return error.message;
      }
    }
  }
}
