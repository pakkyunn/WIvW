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
}

class WriteProvider extends ChangeNotifier {
  bool _isEdited = false;

  bool get isEdited => _isEdited;

  void setEditState(bool edit) {
    _isEdited = edit;
    notifyListeners();
  }
}

