import 'package:flutter/material.dart';
import 'package:frontend/Model/model/booking/office_model.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:frontend/View/booking/component/car_item.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/main_app_bar.dart';

import '../../../Model/model/booking/car_model.dart';
import '../../../Model/model/booking/resource_model.dart';
import '../../../Presenter/booking/booking_service.dart';
import '../component/custom_search_bar.dart';
import '../component/office_item.dart';
import '../component/resource_item.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {

  static const category = ['회의실', '차량', '장비'];

  late final TabController controller;
  int index = 0;
  int selectedTab = 0;

  bool isLoading = true;
  dynamic data;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<dynamic> fetchData() async {
    isLoading = true;
    dynamic response;
    switch (index) {
      case 0:
        response = await BookingService().getOfficeListData();
      case 1:
        response = await BookingService().getCarListData();
      case 2:
        response = await BookingService().getResourceListData();
    }
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
          CustomSearchBar(index: index,),
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
          renderTabItem(category[0]),
          renderTabItem(category[1]),
          renderTabItem(category[2]),
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
        if (snapshot.hasError || snapshot.data == null) {
          return const Center(
            child: Text('정보를 불러오지 못 하였습니다.'),
          );
        }
        else {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator(color: purple,),);
          }
          data = configureData(snapshot.data);
          return Container(
            height: getItemHeight() * data.data.content.length,
            color: Colors.white,
            child:
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.data.content.length,
              itemBuilder: (BuildContext context, int index) {
                return renderItem(data, index);
              },
            ),
          );
        }

      }
    );
  }

  Widget renderItem(GeneralModel data, int itemIndex) {
    switch (index) {
      case 0:
        return OfficeItem(data: (data as OfficeResponseModel).data.content[itemIndex],);
      case 1:
        return CarItem(data: (data as CarResponseModel).data.content[itemIndex],);
      case 2:
        return ResourceItem(data: (data as ResourceResponseModel).data.content[itemIndex],);
    }
    return Container();
  }

  /// Helper Methods
  void tabListener() {
    setState(() {
      FocusScope.of(context).unfocus();
      index = controller.index;
      BookingService().setKeyword('');
    });
  }

  double getItemHeight() {
    switch (index) {
      case 0: return 292.0;
      case 1: return 232.0;
      case 2: return 232.0;
    }
    return 0.0;
  }

  dynamic configureData(dynamic response) {
    switch (index) {
      case 0:
        return OfficeResponseModel.fromJson(response);
      case 1:
        return CarResponseModel.fromJson(response);
      case 2:
        return ResourceResponseModel.fromJson(response);
    }
  }

  void searchItems(String keyword) {
    setState(() {
      BookingService().setKeyword(keyword);
    });
  }
}
