import 'package:flutter/material.dart';


import 'color.dart';
import 'font.dart';

class TextStyleFamily {
  /// 일반 텍스트 스타일. size 14, black
  static TextStyle normalTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 14,
      color: ColorFamily.white
  );

  /// 작은 텍스트 스타일. size 14, black
  static TextStyle smallTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 12,
      color: ColorFamily.lightYellow
  );

  /// 강조 텍스트 스타일. size 14, black
  static TextStyle impactTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryBold,
      fontSize: 20,
      color: ColorFamily.white,
  );

  /// 색상 텍스트 스타일. size 14, black
  static TextStyle colorTextStyle = TextStyle(
    fontFamily: FontFamily.mapleStoryBold,
    fontSize: 20,
    color: ColorFamily.pink
  );

  /// 버튼 텍스트 스타일. size 14, black
  static TextStyle buttonTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 14,
      color: ColorFamily.black
  );
}