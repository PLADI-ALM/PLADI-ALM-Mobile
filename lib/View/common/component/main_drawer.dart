import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../colors.dart';

final bookingMenuList = ['회의실 예약','장비 예약', '차량 예약'];
final myBookingMenuList = ['회의실 예약 내역','장비 예약 내역', '차량 예약 내역'];
final adminMenuList = ['직원 관리','회의실 관리', '자원 관리', '회의실 예약 관리', '장비 예약 관리', '차량 예약 관리'];



class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  bool bookingMenuIsFolded = true;
  bool myBookingMenuIsFolded = true;
  bool adminMenuIsFolded = true;

  String selectedMenu = '';
  bool isAdmin = false;

  TextStyle menuStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7C7B84));
  TextStyle subMenuStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF7C7B84));

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: ListView(
        children: [
          renderProfile(),
          Divider(color: darkGrey.withOpacity(0.7),),

          renderMenu(
            const Icon(CupertinoIcons.square_grid_2x2, color: Color(0xFF7C7B84), size: 20,),
            "예약",
            bookingMenuList,
          ),

          renderMenu(
            const Icon(CupertinoIcons.clock, color: Color(0xFF7C7B84), size: 20,),
            "My 예약",
            myBookingMenuList,
          ),
          renderMenu(
            const Icon(CupertinoIcons.doc_text, color: Color(0xFF7C7B84), size: 20,),
            "비품 내역",
            []
          ),
          renderMenu(
            const Icon(CupertinoIcons.doc, color: Color(0xFF7C7B84), size: 20,),
            "자료 아카이빙",
            []
          ),
          isAdmin
              ? renderMenu(
                  const Icon(CupertinoIcons.person_2, color: Color(0xFF7C7B84), size: 20,),
                  "관리자",
                  adminMenuList,
                )
              : Container(),
          renderLogout(),
        ],
      ),
    );
  }

  Widget renderProfile() {
    return SizedBox(
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Icon(CupertinoIcons.person, color: Colors.black, size: 20,),
          ),
          Expanded(child: Text('홍길동', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: isAdmin ? purple : darkGrey,
                borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            child: Text(isAdmin ? '관리자' : '직원', style: const TextStyle(fontSize: 10, color: Colors.white),),
          )
        ],
      ),
    );
  }

  Widget renderMenu(Icon icon, String title, List<String> subMenuList) {
    return GestureDetector(
      onTap: () {
        setFoldState(title);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 8,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (subMenuList.isEmpty) {
                            selectedMenu = title;
                            didTapMenuItem();
                          }
                        });
                      },
                      child: Text(title, style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,
                          color: (title == selectedMenu) ? purple : const Color(0xFF7C7B84)),
                      ),
                    ),
                    (getFoldState(title) || subMenuList.isEmpty)
                        ? Container()
                        : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: subMenuList.map((e) =>
                                  SizedBox(
                                    height: 28,
                                    child: TextButton(
                                        onPressed: (){
                                          setState(() {
                                            selectedMenu = e;
                                            didTapMenuItem();
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.centerLeft
                                        ),
                                        child: Text(e, style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.bold,
                                            color: (e == selectedMenu) ? purple : const Color(0xFF7C7B84)),
                                        )
                                    ),
                                  )
                              ).toList(),
                            ),
                        )
                  ],
                )
            ),
            subMenuList.isNotEmpty
                ? Icon(getFoldState(title)
                    ? CupertinoIcons.chevron_down
                    : CupertinoIcons.chevron_up,
                    color: const Color(0xFF7C7B84), size: 17,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget renderLogout() {
    return GestureDetector(
      onTap: didTapLogout,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: SvgPicture.asset('asset/image/logout.svg'),
          ),
          const Text('로그아웃', style: TextStyle(fontSize: 11, color: Color(0xFFA65959)),),
          Flexible(child: Container())
        ],
      ),
    );
  }

  void setFoldState(String title) {
    setState(() {
      switch (title) {
        case '예약': bookingMenuIsFolded = !bookingMenuIsFolded;
        case 'My 예약': myBookingMenuIsFolded = !myBookingMenuIsFolded;
        case '관리자': adminMenuIsFolded = !adminMenuIsFolded;
      }
    });
  }

  bool getFoldState(String title) {
    switch (title) {
      case '예약': return bookingMenuIsFolded;
      case 'My 예약': return myBookingMenuIsFolded;
      case '관리자': return adminMenuIsFolded;
    }
    return false;
  }

  /// Event Methods
  void didTapLogout() {
    // TODO : 로그아웃 이벤트 정의
    print('didTapLogout');
  }

  void didTapMenuItem() {
    // TODO : 화면 전환 이벤트 정의
    switch (selectedMenu) {
      case '회의실 예약': print('회의실 예약 선택');
      case '장비 예약': print('장비 예약 선택');
      case '차량 예약': print('차량 예약 선택');

      case '회의실 예약 내역': print('회의실 예약 내역 선택');
      case '장비 예약 내역': print('장비 예약 내역 선택');
      case '차량 예약 내역': print('차량 예약 내역 선택');

      case '비품 내역': print('비품 내역 선택');
      case '자료 아카이빙': print('자료 아카이빙 선택');
    }
  }
}
