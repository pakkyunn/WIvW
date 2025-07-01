import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'package:wivw/provider/providers.dart';
import 'package:wivw/screen/detailScreen.dart';
import 'package:wivw/style/color.dart';

import '../model/content_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> items = ['최근 작성순', '평점 높은순', '평점 낮은순', '최신 시청순', '과거 시청순'];
  List<ContentModel> _list = [];
  final TextEditingController _searchBarController = TextEditingController();
  final FocusNode _searchBarNode = FocusNode();
  String _searchKeyword = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initContentList();
    });
  }

  void _initContentList() {
    var provider = Provider.of<MainProvider>(context, listen: false);
    if (provider.categoryIdx >= 1 && provider.categoryIdx <= 12) {
      _list = provider.contentList
          .where((e) => e.category == provider.categoryIdx)
          .toList();
    } else {
      _list = provider.contentList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<MainProvider, HomeProvider>(
      builder: (context, mainProvider, homeProvider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                leading: Icon(Icons.search),
                hintText: "작품명 검색",
                trailing: _searchKeyword != ""
                    ? [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _searchBarController.text = "";
                              _searchKeyword = "";
                            });
                          },
                          icon: Icon(Icons.cancel),
                        ),
                      ]
                    : [],
                controller: _searchBarController,
                focusNode: _searchBarNode,
                onChanged: (value) {
                  setState(() {
                    _searchKeyword = value;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    _searchKeyword = value;
                  });
                },
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                  _searchBarNode.unfocus();
                },
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButtonHideUnderline(
                  child: Material(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      items: items
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          )
                          .toList(),
                      value: homeProvider.sortType,
                      onChanged: (String? value) {
                        homeProvider.setSortType(value!);
                        setState(() {
                          if (value == '최근 작성순') {
                            mainProvider.contentList.sort(
                              (a, b) => b.index.compareTo(a.index),
                            );
                          } else if (value == '평점 높은순') {
                            mainProvider.contentList.sort(
                              (a, b) => b.rating.compareTo(a.rating),
                            );
                          } else if (value == '평점 낮은순') {
                            mainProvider.contentList.sort(
                              (a, b) => a.rating.compareTo(b.rating),
                            );
                          } else if (value == '최신 시청순') {
                            mainProvider.contentList.sort(
                              (a, b) => b.watchDate.compareTo(a.watchDate),
                            );
                          } else if (value == '과거 시청순') {
                            mainProvider.contentList.sort(
                              (a, b) => a.watchDate.compareTo(b.watchDate),
                            );
                          }
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(height: 40),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(child: _makeListItem(context, _searchKeyword, mainProvider)),
          ],
        );
      },
    );
  }
}

Widget _makeListItem(
  BuildContext context,
  String keyword,
  MainProvider provider
) {
  var list =  provider.contentList;

  if (provider.categoryIdx >= 1 && provider.categoryIdx <= 12) {
    list = provider.contentList
        .where((e) => e.category == provider.categoryIdx)
        .toList();
  } else {
    list = provider.contentList;
  }

  if (keyword != "") {
    list = list.where((e) => e.title.contains(keyword)).toList();
  } else {
    list = list;
  }

  return ListView.builder(
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (context, index) {
      return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(index: index)),
          );
        },
        child: Column(
          children: [
            index != 0 ? Divider() : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.file(File(list[index].posterPath)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              list[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: ColorFamily.skyBlue,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 2.0),
                            ),
                            Expanded(
                              child: Text(
                                list[index].review,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: ColorFamily.skyBlue,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "나의 평점: ",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorFamily.skyBlue,
                                  ),
                                ),
                                Text(
                                  "${list[index].rating}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorFamily.skyBlue,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "시청 날짜: ",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorFamily.skyBlue,
                                  ),
                                ),
                                Text(
                                  list[index].watchDate,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorFamily.skyBlue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Divider()
          ],
        ),
      );
    },
  );
}
