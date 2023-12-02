import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/Model/model/equipment/image_url_model.dart';
import 'package:frontend/Model/model/equipment/image_url_request.dart';
import 'package:frontend/Model/network/api_manager.dart';

class EquipmentService {
  final equipmentURL = '/equipments?cond=';
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
}
