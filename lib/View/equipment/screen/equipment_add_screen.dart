import 'package:flutter/material.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

class EquipmentAddScreen extends StatefulWidget {
  const EquipmentAddScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EquipmentAddScreen();
}

class _EquipmentAddScreen extends State<EquipmentAddScreen> {
  final categories = ["1", "2", "3"];
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
    super.initState();
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
      appBar: const SubAppBar(
        titleText: '신규 비품 추가',
      ),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return Container(
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
          SizedBox(
            width: double.infinity,
            height: 42,
            child: DropdownButton(
              hint: const Text('카테고리를 선택해주세요.',
                  style: TextStyle(
                    color: Color(0xFFC9C9C9),
                    fontSize: 13,
                    fontFamily: 'NanumSquare_ac',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  )),
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
          SizedBox(
            width: double.infinity,
            height: 42,
            child: TextField(
              maxLines: 1,
              focusNode: nameFocusNode,
              obscureText: false,
              controller: nameController,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF640FAF))),
                  isDense: true,
                  hintText: "비품명을 입력해주세요.",
                  contentPadding: EdgeInsets.all(10)),
            ),
          ),
        ],
      ),
    );
  }

  void moveToAddEquipment() {}
}
