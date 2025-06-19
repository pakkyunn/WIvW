import 'package:flutter/material.dart';
import 'package:wivw/model/content_model.dart';
import 'package:wivw/style/color.dart';

class MainProvider extends ChangeNotifier {
  Text _mainAppBarName = Text("내가", style: TextStyle(color: ColorFamily.lightPurple));
  int _categoryIdx = 0;

  Text get mainAppBarName => _mainAppBarName;
  int get categoryIdx => _categoryIdx;

  void setMainAppBarName(String name, Color color) {
    _mainAppBarName = Text(name, style: TextStyle(color: color),) ;
    notifyListeners();
  }

  void setCategoryIdx(int idx) {
    _categoryIdx = idx;
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

  void providerNotify(){
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

