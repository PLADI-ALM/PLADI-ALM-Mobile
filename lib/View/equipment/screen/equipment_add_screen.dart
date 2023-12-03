import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/Model/model/equipment/equipment_category_model.dart';
import 'package:frontend/Model/model/equipment/equipment_list_model.dart';
import 'package:frontend/Model/model/equipment/image_url_model.dart';
import 'package:frontend/Presenter/equipment/equipment_service.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:frontend/View/equipment/screen/equipment_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EquipmentAddScreen extends StatefulWidget {
  final EquipmentModel? equipment;

  const EquipmentAddScreen({super.key, this.equipment});

  @override
  State<StatefulWidget> createState() => _EquipmentAddScreen();
}

class _EquipmentAddScreen extends State<EquipmentAddScreen> {
  var categories = [""];
  File? userImage;
  String? _selectedCategory;

  FocusNode nameFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();
  FocusNode loacationFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController loacationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    checkEdit();
    super.initState();
  }

  void checkEdit() async {
    if (widget.equipment != null) {
      nameController.text = widget.equipment!.name;
      quantityController.text = widget.equipment!.quantity;

      _selectedCategory = widget.equipment!.category;

      if (widget.equipment!.location != null) {
        loacationController.text = widget.equipment!.location!;
      }
      if (widget.equipment!.description != null) {
        descriptionController.text = widget.equipment!.description!;
      }

      if (widget.equipment!.imgUrl != null) {
        urlToFile(widget.equipment!.imgUrl!);
      }
    }
  }

  void urlToFile(String imageUrl) async {
    final http.Response responseData = await http.get(Uri.parse(imageUrl));
    Uint8List uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/jpeg').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    setState(() {
      userImage = file;
    });
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    quantityFocusNode.dispose();
    loacationFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(
        titleText: widget.equipment == null ? '신규 비품 추가' : "비품 수정",
      ),
      body: futureBody(),
      bottomNavigationBar: PurpleBottomButton(
        title: widget.equipment == null ? '추가' : "수정",
        onPressed: checkEssential,
      ),
    );
  }

  Widget futureBody() {
    return FutureBuilder(
        future: EquipmentService().getEquipmentCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return notCategoryBody();
          }

          if (snapshot.hasData) {
            categories = EquipmentCategoryResponseModel.fromJson(snapshot.data)
                .data
                .categoryNames;
            if (categories.isEmpty) {
              return notCategoryBody();
            } else {
              return renderBody();
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget notCategoryBody() {
    return Center(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: const Text("카테고리 목록이 없습니다.\n다시 시도해주세요.",
          style: TextStyle(fontSize: 16, color: Colors.purple)),
    ));
  }

  Widget renderBody() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 14, right: 20, left: 20),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '비품명 ',
                    style: TextStyle(
                      color: Color(0xFF4C4C4C),
                      fontSize: 16,
                      fontFamily: 'NanumSquare_ac',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Color(0xFFEC6240),
                      fontSize: 16,
                      fontFamily: 'NanumSquare_ac',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: TextField(
              maxLines: 1,
              focusNode: nameFocusNode,
              obscureText: false,
              controller: nameController,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF939393))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF640FAF))),
                  isDense: true,
                  hintText: "비품명을 입력해주세요.",
                  contentPadding: EdgeInsets.all(10)),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const SizedBox(
            width: double.infinity,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '수량 ',
                    style: TextStyle(
                      color: Color(0xFF4C4C4C),
                      fontSize: 16,
                      fontFamily: 'NanumSquare_ac',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Color(0xFFEC6240),
                      fontSize: 16,
                      fontFamily: 'NanumSquare_ac',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: TextField(
              maxLines: 1,
              keyboardType: TextInputType.number,
              focusNode: quantityFocusNode,
              obscureText: false,
              controller: quantityController,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF939393))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF640FAF))),
                  isDense: true,
                  hintText: "수량을 입력해주세요.",
                  contentPadding: EdgeInsets.all(10)),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const SizedBox(
            width: double.infinity,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '카테고리 ',
                    style: TextStyle(
                      color: Color(0xFF4C4C4C),
                      fontSize: 16,
                      fontFamily: 'NanumSquare_ac',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Color(0xFFEC6240),
                      fontSize: 16,
                      fontFamily: 'NanumSquare_ac',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            width: double.infinity,
            height: 42,
            padding: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFF939393)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: DropdownButton(
              hint: const Text('카테고리를 선택해주세요.',
                  style: TextStyle(
                    color: Color(0xFF4C4C4C),
                    fontSize: 13,
                    fontFamily: 'NanumSquare_ac',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  )),
              isExpanded: true,
              underline: const SizedBox.shrink(),
              value: _selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const SizedBox(
              width: double.infinity,
              child: Text(
                '보관 장소',
                style: TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 16,
                  fontFamily: 'NanumSquare_ac',
                  fontWeight: FontWeight.w700,
                ),
              )),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: TextField(
              maxLines: 1,
              focusNode: loacationFocusNode,
              obscureText: false,
              controller: loacationController,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF939393))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF640FAF))),
                  isDense: true,
                  hintText: "보관장소를 입력해주세요.",
                  contentPadding: EdgeInsets.all(10)),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const SizedBox(
              width: double.infinity,
              child: Text(
                '설명',
                style: TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 16,
                  fontFamily: 'NanumSquare_ac',
                  fontWeight: FontWeight.w700,
                ),
              )),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            width: double.infinity,
            height: 87,
            child: TextField(
              maxLines: 10,
              focusNode: descriptionFocusNode,
              obscureText: false,
              controller: descriptionController,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF939393))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF640FAF))),
                  isDense: true,
                  hintText: "비품 설명을 입력해주세요.",
                  contentPadding: EdgeInsets.all(10)),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const SizedBox(
              width: double.infinity,
              child: Text(
                '첨부사진',
                style: TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 16,
                  fontFamily: 'NanumSquare_ac',
                  fontWeight: FontWeight.w700,
                ),
              )),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Container(
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF6F6F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  width: 79,
                  height: 79,
                  child: IconButton(
                    icon: userImage == null
                        ? SvgPicture.asset('asset/image/image_plus.svg')
                        : Image.file(
                            userImage!,
                            fit: BoxFit.fill,
                          ),
                    onPressed: imageAdd,
                  )),
            ],
          )
        ],
      ),
    );
  }

  void showAlert(String content) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: const Column(
              children: <Widget>[
                Text("비품 추가 오류"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(content),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "확인",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void imageAdd() async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        userImage = File(image.path);
      });
    }
  }

  void checkEssential() {
    if (nameController.text == "" ||
        quantityController.text == "" ||
        _selectedCategory == null) {
      showAlert("필수 요소를 입력해주세요.");
    } else {
      checkImage();
    }
  }

  void checkImage() async {
    if (userImage != null) {
      dynamic response = await EquipmentService().getImageUrl();
      final data = ImageUrlModel.fromJson(response);

      Future<dynamic> result =
          EquipmentService().putIamge(data.presignedUrl, userImage!);
      result.then((value) => {
            if (value == true)
              {addEquipment(data.imageKey)}
            else
              {showAlert("알 수 없는 오류가 발생했습니다. 다시 시도해주세요.")}
          });
    } else {
      addEquipment(null);
    }
  }

  void addEquipment(String? imageKey) {
    var name = nameController.text;
    var quantity = quantityController.text;
    var description =
        descriptionController.text == "" ? null : descriptionController.text;
    var location =
        loacationController.text == "" ? null : loacationController.text;
    var imgKey = imageKey != null ? "equipment/$imageKey" : null;

    if (widget.equipment == null) {
      Future<dynamic> result = EquipmentService().addEquipment(
          _selectedCategory!, description, imgKey, location, name, quantity);
      result.then((value) => {
            if (value == true) {moveToPop()} else {showAlert(value)}
          });
    } else {
      Future<dynamic> result = EquipmentService().editEquipment(
          widget.equipment!.equipmentId,
          _selectedCategory!,
          description,
          imgKey,
          location,
          name,
          quantity);
      result.then((value) => {
            if (value == true)
              {Navigator.of(context).pop(), Navigator.of(context).pop()}
            else
              {showAlert(value)}
          });
    }
  }

  void moveToPop() {
    Navigator.of(context).pop();
  }
}
