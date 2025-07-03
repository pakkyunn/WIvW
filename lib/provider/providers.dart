import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wivw/model/content_model.dart';
import 'package:wivw/style/color.dart';

class MainProvider extends ChangeNotifier {
  Text _mainAppBarName = Text("내가", style: TextStyle(color: ColorFamily.lightPurple));
  int _categoryIdx = 0;
  int _bodyIndex = 0;
  int _bottomNavigationIdx = 0;

  Text get mainAppBarName => _mainAppBarName;
  int get categoryIdx => _categoryIdx;
  int get bodyIndex => _bodyIndex;
  int get bottomNavigationIdx => _bottomNavigationIdx;


  void setMainAppBarName(String name, Color color) {
    _mainAppBarName = Text(name, style: TextStyle(color: color),) ;
    notifyListeners();
  }

  void setCategoryIdx(int idx) {
    _categoryIdx = idx;
    notifyListeners();
  }

  void showBodyScreen(int index) {
    _bodyIndex = index;
    notifyListeners();
  }

  void setBottomNavigationIdx(int idx) {
    _bottomNavigationIdx = idx;
    notifyListeners();
  }

  List<ContentModel> _contentList = [];
  int _contentIndex = 0;

  List<ContentModel> get contentList => _contentList;
  int get contentIndex => _contentIndex;


  void setContentList(List<ContentModel> list) {
    _contentList = list;
    notifyListeners();
  }

  void setContentIndex(int idx) {
    _contentIndex = idx;
    notifyListeners();
  }

  Future<void> deleteContent(int contentIndex) async {
    _contentList.removeWhere((e) => e.index == contentIndex);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_contentList.map((e) => e.toJson()).toList());
    await prefs.setString('contentList', jsonString);
  }

  void providerNotify(){
    notifyListeners();
  }
}

class HomeProvider extends ChangeNotifier {
  String _sortType = "최근 작성순";

  String get sortType => _sortType;

  void setSortType(String sort) {
    _sortType = sort;
    notifyListeners();
  }
}


class WriteProvider extends ChangeNotifier {
  bool _isEdited = false;
  int _selectedCategoryType = 0;

  bool get isEdited => _isEdited;
  int get selectedCategoryType => _selectedCategoryType;

  void setEditState(bool edit) {
    _isEdited = edit;
    notifyListeners();
  }

  void selectCategoryType(int type) {
    _selectedCategoryType = type;
    notifyListeners();
  }
}

