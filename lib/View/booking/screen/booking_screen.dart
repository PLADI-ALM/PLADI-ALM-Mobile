import 'package:flutter/material.dart';
import 'package:frontend/Model/model/booking/office_model.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:frontend/Presenter/booking/office_service.dart';
import 'package:frontend/Presenter/booking/resource_service.dart';
import 'package:frontend/View/booking/component/car_item.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/main_app_bar.dart';

import '../../../Model/model/booking/car_model.dart';
import '../../../Model/model/booking/resource_model.dart';
import '../../../Presenter/booking/car_service.dart';
import '../component/custom_search_bar.dart';
import '../component/office_item.dart';
import '../component/resource_item.dart';

enum BookingType { office, resource, car }

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  static const category = ['회의실', '장비', '차량'];
  BookingType currentType = BookingType.office;

  late final TabController controller;
  int selectedTab = 0;

  bool isLoading = true;
  dynamic data;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
    isLoading = true;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<dynamic> fetchData() async {
    isLoading = true;
    dynamic response;
    switch (currentType) {
      case BookingType.office:
        response = await OfficeService().getOfficeListData();
      case BookingType.resource:
        response = await ResourceService().getResourceListData();
      case BookingType.car:
        response = await CarService().getCarListData();
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
          CustomSearchBar(
            type: currentType,
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: category.map((e) => renderItems(e)).toList(),
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
          ]),
    );
  }

  Widget renderTabItem(String title) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 100) / 3,
      child: Tab(
        icon: Text(title),
      ),
    );
  }

  Widget renderItems(String categoryName) {
    return FutureBuilder<dynamic>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(
              child: Text(
                '정보를 불러오지 못 하였습니다.',
                style: TextStyle(fontSize: 16, color: purple),
              ),
            );
          } else {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: purple,
                ),
              );
            }
            data = configureData(snapshot.data);
            return Container(
              height: getItemHeight() * data.data.content.length,
              color: Colors.white,
              child: (data.data.content.length == 0)
                  ? const Center(
                      child: Text(
                        '결과 정보가 없습니다.',
                        style: TextStyle(fontSize: 16, color: purple),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: data.data.content.length,
                      itemBuilder: (BuildContext context, int index) {
                        return renderItem(data, index);
                      },
                    ),
            );
          }
        });
  }

  Widget renderItem(GeneralModel data, int itemIndex) {
    switch (currentType) {
      case BookingType.office:
        return OfficeItem(
          data: (data as OfficeResponseModel).data.content[itemIndex],
        );
      case BookingType.resource:
        return ResourceItem(
          data: (data as ResourceResponseModel).data.content[itemIndex],
        );
      case BookingType.car:
        return CarItem(
          data: (data as CarResponseModel).data.content[itemIndex],
        );
    }
  }

  /// Helper Methods
  void tabListener() {
    setState(() {
      FocusScope.of(context).unfocus();
      switch (controller.index) {
        case 0:
          currentType = BookingType.office;
        case 1:
          currentType = BookingType.resource;
        case 2:
          currentType = BookingType.car;
      }
      OfficeService().keyword = '';
      ResourceService().keyword = '';
      CarService().keyword = '';
    });
  }

  double getItemHeight() {
    switch (currentType) {
      case BookingType.office:
        return 292.0;
      case BookingType.resource:
        return 232.0;
      case BookingType.car:
        return 232.0;
    }
  }

  dynamic configureData(dynamic response) {
    switch (currentType) {
      case BookingType.office:
        return OfficeResponseModel.fromJson(response);
      case BookingType.resource:
        return ResourceResponseModel.fromJson(response);
      case BookingType.car:
        return CarResponseModel.fromJson(response);
    }
  }

  void searchItems(String keyword) {
    setState(() {
      switch (currentType) {
        case BookingType.office:
          OfficeService().keyword = keyword;
        case BookingType.resource:
          ResourceService().keyword = keyword;
        case BookingType.car:
          CarService().keyword = keyword;
      }
    });
  }
}
