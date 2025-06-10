import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// import 'package:provider/provider.dart';
// import 'package:woo_yeon_hi/dao/d_day_dao.dart';
// import 'package:woo_yeon_hi/dao/user_dao.dart';
// import 'package:woo_yeon_hi/dialogs.dart';
// import 'package:woo_yeon_hi/provider/login_register_provider.dart';
// import 'package:woo_yeon_hi/screen/footPrint/footprint_history_detail_screen.dart';
// import 'package:woo_yeon_hi/style/color.dart';
// import 'package:woo_yeon_hi/style/textStyle.dart';
//
// import '../../model/dDay_model.dart';
// import '../../provider/dDay_provider.dart';
// import '../../style/font.dart';
// import '../../utils.dart';
import '../style/color.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({super.key});

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  // int userIdx;

  // @override
  // void initState() {
  //   super.initState();
  //   getListData();
  // }

  // Future<void> getListData() async {
  //   // 유저인덱스로 로컬에 있는(추후 파이어베이스로 전환) 리스트 데이터 가져오기
  //   var dDayProvider = Provider.of<DdayProvider>(context, listen: false);
  //   var dDayList = await getDdayList(context);
  //   dDayProvider.setDdayList(dDayList);
  // }
  
  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(3,(index) {
              return _makeListItem(index);
            }));
    // return userIdx == null
    //     ? const Center(
    //     child: CircularProgressIndicator(
    //       color: ColorFamily.skyBlue,
    //     ))
    //     : Consumer2<DdayProvider, UserProvider>(
    //     builder: (context, dDayProvider, userProvider, child) {
    //       return Padding(
    //           padding: const EdgeInsets.all(20),
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 Column(
    //                   children: [
    //                     Container(
    //                       padding:
    //                       const EdgeInsets.fromLTRB(10, 10, 10, 0),
    //                       child: Column(
    //                         children: [
    //                           // title, count
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text("연애 시작", style: dDayTitleTextStyle),
    //                               Text(
    //                                   countingOneOffDday(stringToDate(
    //                                       userProvider.loveDday)),
    //                                   style: dDayCountTextStyle)
    //                             ],
    //                           ),
    //                           const SizedBox(height: 20),
    //                           // content, date
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text("우리가 만난 날",
    //                                   style: dDayContentTextStyle),
    //                               Text(
    //                                   dateToStringWithDayLight(stringToDate(
    //                                       userProvider.loveDday)),
    //                                   style: dDayDateTextStyle)
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const Divider(color: ColorFamily.gray),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: [
    //                     Container(
    //                       padding:
    //                       const EdgeInsets.fromLTRB(10, 10, 10, 0),
    //                       child: Column(
    //                         children: [
    //                           // title, count
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text("내 생일", style: dDayTitleTextStyle),
    //                               Text(
    //                                   countingAnnualDday(stringToDate(
    //                                       userProvider.userBirth)),
    //                                   style: dDayCountTextStyle)
    //                             ],
    //                           ),
    //                           const SizedBox(height: 20),
    //                           // content, date
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text("", style: dDayContentTextStyle),
    //                               Text(
    //                                   makeBirthToDday(
    //                                       userProvider.userBirth),
    //                                   style: dDayDateTextStyle)
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const Divider(color: ColorFamily.gray),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: [
    //                     Container(
    //                       padding:
    //                       const EdgeInsets.fromLTRB(10, 10, 10, 0),
    //                       child: Column(
    //                         children: [
    //                           // title, count
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text("연인 생일", style: dDayTitleTextStyle),
    //                               userIdx == ""
    //                                   ? Text("", style: dDayCountTextStyle)
    //                                   : Text(
    //                                   countingAnnualDday(
    //                                       stringToDate(userIdx!)),
    //                                   style: dDayCountTextStyle)
    //                             ],
    //                           ),
    //                           const SizedBox(height: 20),
    //                           // content, date
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text("", style: dDayContentTextStyle),
    //                               userIdx == ""
    //                                   ? Text("연인의 생일이 등록되지 않았습니다.", style: dDayDateTextStyle)
    //                                   : Text(makeBirthToDday(userIdx!),
    //                                   style: dDayDateTextStyle)
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const Divider(color: ColorFamily.gray),
    //                     const SizedBox(height: 2.5),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: List.generate(dDayProvider.dDayList.length,
    //                           (index) {
    //                         return Dismissible(
    //                             key: Key(
    //                                 "${dDayProvider.dDayList[index]["dDay_idx"]}"),
    //                             direction: DismissDirection.endToStart,
    //                             confirmDismiss: (direction) async {
    //                               final result = await showDialog(
    //                                 context: context,
    //                                 builder: (context) {
    //                                   return Dialog(
    //                                     surfaceTintColor: ColorFamily.white,
    //                                     backgroundColor: ColorFamily.white,
    //                                     child: Wrap(
    //                                       children: [
    //                                         Padding(
    //                                           padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
    //                                           child: Column(
    //                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                             children: [
    //                                               const Text(
    //                                                 "디데이를 삭제하시겠습니까?",
    //                                                 style: TextStyleFamily.dialogButtonTextStyle,
    //                                               ),
    //                                               const SizedBox(height: 30),
    //                                               Row(
    //                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                                                 children: [
    //                                                   TextButton(
    //                                                     style: TextButton.styleFrom(
    //                                                       overlayColor: Colors.transparent,
    //                                                     ),
    //                                                     onPressed: () => Navigator.of(context).pop(false),
    //                                                     child: const Text(
    //                                                       "취소",
    //                                                       style: TextStyleFamily.dialogButtonTextStyle,
    //                                                     ),
    //                                                   ),
    //                                                   TextButton(
    //                                                     style: TextButton.styleFrom(
    //                                                       overlayColor: Colors.transparent,
    //                                                     ),
    //                                                     onPressed: () => Navigator.of(context).pop(true),
    //                                                     child: const Text(
    //                                                       "확인",
    //                                                       style: TextStyleFamily.dialogButtonTextStyle_pink,
    //                                                     ),
    //                                                   ),
    //                                                 ],
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   );
    //                                 },
    //                               );
    //                               return result; // true일 경우 삭제, false일 경우 삭제 안 함
    //                             },
    //                             onDismissed: (direction) async {
    //                               await deleteDday(context, dDayProvider.dDayList[index]["dDay_idx"]);
    //                               showPinkSnackBar(context, "디데이 항목이 삭제되었습니다");
    //                             },
    //                             child: _makeDdayItem(index));
    //                       }),
    //                 )
    //               ],
    //             ),
    //           )); // 항목들을 나열
    //     });
  }

  Widget _makeListItem(int index) {
    // var provider = Provider.of<DdayProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "컨텐츠 제목",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Expanded(
          child: Text(
            "컨텐츠 감상평",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
        ),
        Text("평점: 4.7", style: const TextStyle(fontSize: 12.0, color: Colors.black87)),
        Text(
          '시청 날짜',
          style: const TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
      ],
    );

    //   Column(
    //   children: [
    //     Wrap(
    //       children: [
    //         Card(
    //           elevation: 1.0,
    //           child: Container(
    //             padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    //             child: Column(
    //               children: [
    //                 // title, count
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       provider.dDayList[index]["dDay_title"],
    //                       style: dDayTitleTextStyle,
    //                     ),
    //                     Text(
    //                       countingOneOffDday(stringToDate(
    //                           provider.dDayList[index]["dDay_date"])),
    //                       style: dDayCountTextStyle,
    //                     )
    //                   ],
    //                 ),
    //                 const SizedBox(height: 20),
    //                 // content, date
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       provider.dDayList[index]["dDay_description"],
    //                       style: dDayContentTextStyle,
    //                     ),
    //                     Text(
    //                       provider.dDayList[index]["dDay_date"],
    //                       style: dDayDateTextStyle,
    //                     )
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 5),
    //   ],
    // );
  }
}