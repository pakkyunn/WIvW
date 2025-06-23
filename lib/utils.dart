import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wivw/style/color.dart';
import 'package:wivw/style/textStyle.dart';
import 'package:intl/intl.dart';


Future<void> checkFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  const firstLaunchKey = 'is_first_launch';
  final isFirst = prefs.getBool(firstLaunchKey) ?? true;

  if (isFirst) {
    final prefs = await SharedPreferences.getInstance();
    final emptyListJson = jsonEncode([].map((e) => e.toJson()).toList()); // 최초 실행시 빈 리스트를 로컬에 저장
    await prefs.setString('contentList', emptyListJson);
    await prefs.setInt('contentIndex', 0); // 최초 실행시 인덱스 0을 로컬에 저장
    print("@@@: isFirstLaunch");
    // 첫 실행 이후에는 false로 변경
    await prefs.setBool(firstLaunchKey, false);
  }

  print("@@@: isNotFirstLaunch");
}



class DoubleBackToExitWrapper extends StatefulWidget {
  final Widget child;
  const DoubleBackToExitWrapper({required this.child, Key? key}) : super(key: key);

  @override
  State<DoubleBackToExitWrapper> createState() => _DoubleBackToExitWrapperState();
}

class _DoubleBackToExitWrapperState extends State<DoubleBackToExitWrapper> {
  DateTime? _lastBackPressed;

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      Fluttertoast.showToast(
        msg: "한 번 더 누르면 앱을 종료합니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false; // 앱 종료 막기
    }
    return true; // 앱 종료 허용
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child,
    );
  }
}


void showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message, textAlign: TextAlign.center, style: TextStyleFamily.normalTextStyle),
          backgroundColor: ColorFamily.darkGray,
          duration: const Duration(seconds: 2))
  );
}

/// Datetime 객체를 날짜 표시 형식으로 변환
String dateToStringFull(DateTime date) {
  String formattedDay = DateFormat('yyyy-mm-dd').format(date);
  // String year = DateFormat('yyyy').format(date);
  // String month = date.month.toString().padLeft(2, " ");
  // String day = date.day.toString().padLeft(2, " ");
  return formattedDay;
}

/// 'yy년 M월 d일' 형태의 문자열 날짜 데이터를 DateTime으로 변환
DateTime stringToDate(String date) {
  List<String> splitDate = date.split("-");
  int year = 2000+int.parse(splitDate[0]) > DateTime.now().year
  ? 1900+int.parse(splitDate[0])
  : 2000+int.parse(splitDate[0]);

  int month = int.parse(splitDate[1].replaceAll(" ", ""));

  int day = int.parse(splitDate[2].replaceAll(" ", ""));

  return DateTime(year, month, day);
}
