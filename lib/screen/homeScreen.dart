import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wivw/provider/main_provider.dart';
import 'package:wivw/style/color.dart';

import '../model/content_model.dart';
import '../widget/homeListView.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onChange});
  final void Function(int) onChange;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //TODO mainProvider의 categoryIdx의 값에 따라 리스트 목록을 분기. 0인 경우 모두 표시.

  bool isDark = false;

  List<ContentModel> contents = [
    ContentModel(DateTime(DateTime.april),
        "블랙미러7",
        "미디어와 정보기술의 발달이 인간의 윤리관을 앞서나갔을 때의 부정적인 면을 다룬다. 흔히 미디어는 시대를 비추는 거울이란 표현으로 많이 쓰이는데, 검은 거울이란 전자기기를 껐을 때 검은 화면에 보고 있던 사람 본인의 얼굴이 비친다는 점에서 따왔으며, 드라마의 주제를 잘 함축한 제목이다.",
        4.8, "스릴러", "546546-54654564"),
    ContentModel(DateTime(DateTime.august),
        "하트페어링",
        "연애는 설렘에서 시작된다. 그렇다면 연애가 결혼이 되려면?! 결혼을 꿈꾸는 청춘남녀들이 한 집에 모였다. 이들은 한 달간 이탈리아와 서울을 오가며 운명적 페어링을 통해 자신만의 평생 짝을 찾아간다.",
        4.0, "로맨스", "646546-654564"),
    ContentModel(DateTime(DateTime.december),
        "히든페이스",
        "갇혔다 지켜봤다 벗겨졌다, 지휘자 성진(송승헌)이 이끄는 오케스트라의 첼리스트이자 약혼녀 수연(조여정)이 어느 날 영상 편지만을 남겨둔 채 자취를 감춘다.",
        4.1, "스릴러", "786546-7465454"),
  ];

  final List<String> items = [
    '기본순',
    '평점 높은순',
    '평점 낮은순',
    '최신 시청순',
    '과거 시청순',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
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
                    '기본순',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                        if (value == '기본순') {
                          contents.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                          print("@@: ${contents[0].name}, ${contents[1].name}, ${contents[2].name}");
                        } else if (value == '평점 높은순') {
                          contents.sort((a, b) => b.rating.compareTo(a.rating));
                          print("@@: ${contents[0].name}, ${contents[1].name}, ${contents[2].name}");
                        } else if (value == '평점 낮은순') {
                          contents.sort((a, b) => a.rating.compareTo(b.rating));
                          print("@@: ${contents[0].name}, ${contents[1].name}, ${contents[2].name}");
                        } else if (value == '최신 시청순') {
                          contents.sort((a, b) => a.date.compareTo(b.date));
                          print("@@: ${contents[0].name}, ${contents[1].name}, ${contents[2].name}");
                        } else if (value == '과거 시청순') {
                          contents.sort((a, b) => b.date.compareTo(a.date));
                          print("@@: ${contents[0].name}, ${contents[1].name}, ${contents[2].name}");
                        }
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: List.generate(10, (index) {
              return _makeListItem(0);
            }),
          ),
        ),
      ],
    );
  }
}

Widget _makeListItem(int index) {
  // var provider = Provider.of<DdayProvider>(context, listen: false);
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(aspectRatio: 1.0, child: Image.asset("lib/asset/poster/heart_pairing.png")),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: _ArticleDescription(
                    "하트페어링",
                    "연애는 설렘에서 시작된다. 그렇다면 연애가 결혼이 되려면?! 결혼을 꿈꾸는 청춘남녀들이 한 집에 모였다. 이들은 한 달간 이탈리아와 서울을 오가며 운명적 페어링을 통해 자신만의 평생 짝을 찾아간다.",
                    "나의 평점: 4.0",
                    "시청 기간: 25. 4. 27. - 25. 5. 16.",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Divider()
    ],
  );
}

Widget _ArticleDescription(
  String title,
  String subtitle,
  String rating,
  String date,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorFamily.skyBlue,
        ),
      ),
      const Padding(padding: EdgeInsets.only(bottom: 2.0)),
      Expanded(
        child: Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12.0, color: ColorFamily.skyBlue),
        ),
      ),
      Text(rating, style: TextStyle(fontSize: 12.0, color: ColorFamily.skyBlue)),
      Text(date, style: TextStyle(fontSize: 12.0, color: ColorFamily.skyBlue)),
    ],
  );
}
