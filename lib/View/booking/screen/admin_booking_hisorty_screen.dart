import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Model/model/booking/car_model.dart';
import 'package:frontend/Model/model/booking/resource_model.dart';
import 'package:frontend/Presenter/booking/car_service.dart';
import 'package:frontend/Presenter/booking/resource_service.dart';
import 'package:frontend/View/booking/component/admin_booking_history_cell.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

import '../../../Model/model/booking/office_model.dart';
import '../../../Presenter/booking/office_service.dart';
import 'booking_screen.dart';
import '../../colors.dart';

class AdminBookingHistoryScreen extends StatefulWidget {
  final int id;
  final BookingType currentType;
  const AdminBookingHistoryScreen(
      {Key? key, required this.id, required this.currentType})
      : super(key: key);

  @override
  State<AdminBookingHistoryScreen> createState() =>
      AdminBookingHistoryScreenState();
}

class AdminBookingHistoryScreenState extends State<AdminBookingHistoryScreen>
    with SingleTickerProviderStateMixin {
  static const category = ['회의실', '장비', '차량'];

  bool isLoading = true;
  int length = 0;
  dynamic data;

  Future<dynamic> fetchData() async {
    isLoading = true;
    dynamic response;
    switch (widget.currentType) {
      case BookingType.office:
        response =
            await OfficeService().getAdminOfficeBookingHistoryList(widget.id);
      case BookingType.car:
        response = await CarService().getAdminCarBookingHistoryList(widget.id);
      case BookingType.resource:
        response = await ResourceService()
            .getAdminResourceBookingHistoryList(widget.id);
    }
    isLoading = false;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubAppBar(titleText: "예약 내역"),
      body: renderItems(),
    );
  }

  Widget renderBody() {
    return Container();
  }

  Widget renderItems() {
    return FutureBuilder<dynamic>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: purple,
              ),
            );
          } else {
            if (snapshot.hasError || snapshot.data == null) {
              return const Center(
                child: Text(
                  '정보를 불러오지 못 하였습니다.',
                  style: TextStyle(fontSize: 16, color: purple),
                ),
              );
            } else {
              data = configureData(snapshot.data);
              return (length == 0)
                  ? const Center(
                      child: Text(
                        '예약 내역이 비어있습니다.',
                        style: TextStyle(fontSize: 16, color: purple),
                      ),
                    )
                  : Container(
                      height: 300.0 * length,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: length,
                        itemBuilder: (BuildContext context, int index) {
                          return widget.currentType == BookingType.office
                              ? AdminBookingHistoryCell(
                                  reservatorName: data
                                      .data.officesLists[index].reservatorName,
                                  reservatorPhone: data
                                      .data.officesLists[index].reservatorPhone,
                                  startDateTime: data
                                      .data.officesLists[index].startDateTime,
                                  endDateTime:
                                      data.data.officesLists[index].endDateTime,
                                  goal: data.data.officesLists[index].goal,
                                  bookingStatus: data
                                      .data.officesLists[index].bookingStatus)
                              : AdminBookingHistoryCell(
                                  reservatorName: data
                                      .data.productList[index].reservatorName,
                                  reservatorPhone: data
                                      .data.productList[index].reservatorPhone,
                                  startDateTime: data
                                      .data.productList[index].startDateTime,
                                  endDateTime:
                                      data.data.productList[index].endDateTime,
                                  goal: data.data.productList[index].memo,
                                  bookingStatus: data
                                      .data.productList[index].bookingStatus);
                        },
                      ),
                    );
            }
          }
        });
  }

  void reloadData(dynamic result) {
    if (result == null) {
      Fluttertoast.showToast(msg: '요청에 실패하였습니다.');
    } else if (result.runtimeType == String) {
      Fluttertoast.showToast(msg: result);
    } else {
      Fluttertoast.showToast(msg: result.message);
      setState(() {
        fetchData();
      });
    }
  }

  void changeLoadingStatus(bool loadingStatus) {
    setState(() {
      isLoading = loadingStatus;
    });
  }

  dynamic configureData(dynamic response) {
    switch (widget.currentType) {
      case BookingType.office:
        final data = AdminOfficeBookingHistoryResponse.fromJson(response);
        length = data.data.officesLists.length;
        return data;
      case BookingType.car:
        final data = AdminCarBookingHistoryResponse.fromJson(response);
        length = data.data.productList.length;
        return data;
      case BookingType.resource:
        final data = AdminResourceBookingHistoryResponse.fromJson(response);
        length = data.data.productList.length;
        return data;
    }
  }
}
