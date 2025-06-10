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

  /// 버튼 텍스트 스타일. size 14, black
  static TextStyle? buttonTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 14,
      color: ColorFamily.black
  );
}