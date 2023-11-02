import 'package:flutter/material.dart';
import 'package:frontend/Model/model/booking/office_model.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/main_app_bar.dart';

import '../../../Presenter/booking/booking_service.dart';
import '../component/custom_search_bar.dart';
import '../component/office_item.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {

  static const category = ['회의실', '차량', '장비'];

  late final TabController controller;
  int index = 0;
  int selectedTab = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  Future<dynamic> fetchData() async {
    dynamic response = await BookingService().getOfficeListData('회의실');
    isLoading = false;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return SizedBox(
      child: Column(
        children: [
          renderTabBar(),
          const CustomSearchBar(),
          Expanded(
            child: TabBarView(
              controller: controller,
              children:
              category.map((e) => renderItems(e)).toList(),
            ),
          )
        ],
      ),
    );
  }
  
  Widget renderTabBar() {
    const TextStyle selectedTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    const TextStyle unSelectedTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    return SizedBox(
      height: 38,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        indicatorColor: purple,
        indicatorWeight: 3.0,
        indicatorPadding: const EdgeInsets.only(left: 10, right: 10),
        labelColor: purple,
        labelStyle: selectedTextStyle,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: unSelectedTextStyle,
        tabs: [
          renderTabItem('회의실'),
          renderTabItem('차량'),
          renderTabItem('장비')
        ]
      ),
    );
  }

  Widget renderTabItem(String title) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 100) / 3 ,
      child: Tab(icon: Text(title),),
    );
  }
  
  Widget renderItems(String categoryName) {
    return FutureBuilder<dynamic>(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('정보를 불러오지 못 하였습니다.'),
          );
        }
        else {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator(color: purple,),);
          }
          OfficeResponseModel data = OfficeResponseModel.fromJson(snapshot.data);
          return Container(
            height: getItemHeight(categoryName) * data.data.content.length,
            color: Colors.white,
            child:
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.data.content.length,
              itemBuilder: (BuildContext context, int index) {
                return renderItem(categoryName, data, index);
              },
            ),
          );
        }

      }
    );
  }

  double getItemHeight(String categoryName) {
    switch (categoryName) {
      case '회의실': return 292.0;
      case '차량': return 232.0;
      case '장비': return 232.0;
    }
    return 0.0;
  }

  Widget renderItem(String categoryName, GeneralModel data, int index) {
    switch (categoryName) {
      case '회의실':
        return OfficeItem(data: (data as OfficeResponseModel).data.content[index],);
      case '차량':
        return OfficeItem(data: (data as OfficeResponseModel).data.content[index],);
      case '장비':
        return OfficeItem(data: (data as OfficeResponseModel).data.content[index],);
    }
    return Container();
  }
}
