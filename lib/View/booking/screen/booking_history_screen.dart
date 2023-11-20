import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Model/model/booking/car_model.dart';
import '../../../Model/model/booking/office_model.dart';
import '../../../Model/model/booking/resource_model.dart';
import '../../../Presenter/booking/car_service.dart';
import '../../../Presenter/booking/office_service.dart';
import '../../../Presenter/booking/resource_service.dart';
import 'booking_screen.dart';
import '../../colors.dart';
import '../component/booking_item_card.dart';
import '../../common/component/main_app_bar.dart';

class BookingHistoryScreen extends StatefulWidget {
  final bool isAdmin;
  const BookingHistoryScreen({
    required this.isAdmin,
    Key? key
  }) : super(key: key);

  @override
  State<BookingHistoryScreen> createState() => BookingHistoryScreenState();
}

class BookingHistoryScreenState extends State<BookingHistoryScreen> with SingleTickerProviderStateMixin {
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
        response = await OfficeService().getOfficeBookingHistoryList(widget.isAdmin);
      case BookingType.resource:
        response = await ResourceService().getResourceBookingHistoryList(widget.isAdmin);
      case BookingType.car:
        response = await CarService().getCarBookingHistoryList(widget.isAdmin);
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
          const SizedBox(height: 10,),
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
          if (isLoading) { return const Center(child: CircularProgressIndicator(color: purple,),); }
          else {
            if (snapshot.hasError || snapshot.data == null) {
              return const Center(
                child: Text('정보를 불러오지 못 하였습니다.', style: TextStyle(fontSize: 16, color: purple),),
              );
            }
            else {
              data = configureData(snapshot.data);
              return (data.data.content.length == 0)
                  ? const Center(
                child: Text('예약 목록이 비어있습니다.', style: TextStyle(fontSize: 16, color: purple),),
              )
                  : Container(
                height: 300.0 * data.data.content.length,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data.data.content.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BookingItemCard(
                      isAdmin: widget.isAdmin,
                      type: currentType,
                      id: data.data.content[index].id,
                      name: data.data.content[index].name,
                      location: (currentType == BookingType.office)
                          ? data.data.content[index].detailInfo
                          : data.data.content[index].location,
                      startDateTime: data.data.content[index].startDateTime,
                      endDateTime: data.data.content[index].endDateTime,
                      memo: data.data.content[index].memo,
                      status: data.data.content[index].status,
                    );
                  },
                ),
              );
            }
          }

        }
    );
  }

  void reloadData(dynamic result) {
    print('reloadData called');
    if (result == null) { Fluttertoast.showToast(msg: '요청에 실패하였습니다.'); }
    else if (result.runtimeType == String) { Fluttertoast.showToast(msg: result); }
    else {
      Fluttertoast.showToast(msg: result.message);
      setState(() { fetchData(); });
    }
  }

  void changeLoadingStatus(bool loadingStatus) { setState(() { isLoading = loadingStatus; }); }

  /// Helper Methods
  void tabListener() {
    setState(() {
      switch (controller.index) {
        case 0: currentType = BookingType.office;
        case 1: currentType = BookingType.resource;
        case 2: currentType = BookingType.car;
      }
    });
  }

  dynamic configureData(dynamic response) {
    switch (currentType) {
      case BookingType.office: return OfficeBookingHistoryResponse.fromJson(response);
      case BookingType.resource: return ResourceBookingHistoryResponse.fromJson(response);
      case BookingType.car: return CarBookingHistoryResponse.fromJson(response);
    }
  }
}
