import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wivw/provider/providers.dart';
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
  String? sortType;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                isFullScreen: false,
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                    // trailing:
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                      return List<ListTile>.generate(5, (int index) {
                        final String item = 'item $index';
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            setState(() {
                              controller.closeView(item);
                            });
                          },
                        );
                      });
                    },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButtonHideUnderline(
                  child: Material(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        '최근 작성순',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
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
                      value: sortType,
                      onChanged: (String? value) {
                        setState(() {
                          sortType = value;
                          if (value == '최근 작성순') {
                            provider.contentList.sort(
                              (a, b) => b.index.compareTo(a.index),
                            );
                          } else if (value == '평점 높은순') {
                            provider.contentList.sort(
                              (a, b) => b.rating.compareTo(a.rating),
                            );
                          } else if (value == '평점 낮은순') {
                            provider.contentList.sort(
                              (a, b) => a.rating.compareTo(b.rating),
                            );
                          } else if (value == '최신 시청순') {
                            provider.contentList.sort(
                              (a, b) => a.watchDate.compareTo(b.watchDate),
                            );
                          } else if (value == '과거 시청순') {
                            provider.contentList.sort(
                              (a, b) => b.watchDate.compareTo(a.watchDate),
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
            Expanded(child: _makeListItem(context)),
          ],
        );
      },
    );
  }
}

Widget _makeListItem(BuildContext context) {
  var provider = Provider.of<MainProvider>(context, listen: false);
  List<ContentModel> list;
  if (provider.categoryIdx >= 1 && provider.categoryIdx <= 12) {
    list = provider.contentList
        .where((e) => e.category == provider.categoryIdx)
        .toList();
  } else {
    list = provider.contentList;
  }
  return ListView.builder(
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (context, index) {
      return Column(
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
                    child: Image.file(
                      File(list[index].posterPath),
                    ),
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
                          const Padding(padding: EdgeInsets.only(bottom: 2.0)),
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
                                dateToStringFull(DateTime.now()),
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
      );
    },
  );
}
