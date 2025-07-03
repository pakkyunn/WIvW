import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wivw/enums.dart';
import 'package:wivw/provider/providers.dart';
import 'package:wivw/widget/detailScreenAppBar.dart';

import '../style/color.dart';
import '../style/textStyle.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.index});

  final int index;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    final thisContent = Provider.of<MainProvider>(context,listen: false).contentList.firstWhere((e) => e.index == widget.index);

    return Consumer<MainProvider>(
        builder: (context, provider, child) {
      return Scaffold(
      appBar: DetailScreenAppBar(index: widget.index),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        children: [
          SizedBox(
            // padding: const EdgeInsets.symmetric(vertical: 8.0),
            // color: ColorFamily.deepGreen,
            width: deviceWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 포스터 이미지
                SizedBox(
                  width: 150,
                  height: 230,
                  child: Card(
                    // color: Colors.white,
                    elevation: 1,
                    child:
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: provider.contentList.contains(thisContent)
                            ? DecorationImage(
                          image: FileImage(File(thisContent.posterPath)),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                /// 작품명
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "작품명",
                      style: TextStyleFamily.smallTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: deviceWidth - 70,
                  child: Text(thisContent.title, style: TextStyleFamily.normalTextStyle,),
                ),
                const SizedBox(height: 20),

                /// 카테고리
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "카테고리",
                      style: TextStyleFamily.smallTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 20,
                  width: deviceWidth - 70,
                  child: provider.contentList.contains(thisContent)
                    ? Text(CategoryType.values[thisContent.category-1].name, style: TextStyleFamily.normalTextStyle,)
                    : SizedBox()
                ),
                const SizedBox(height: 20),

                /// 감상평
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "감상평",
                      style: TextStyleFamily.smallTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: deviceWidth - 70,
                  child: provider.contentList.contains(thisContent)
                    ? Text(thisContent.review, style: TextStyleFamily.normalTextStyle,maxLines: null)
                    : SizedBox()
                ),
                const SizedBox(height: 20),

                /// 시청 날짜
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "시청 날짜",
                      style: TextStyleFamily.smallTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 20,
                  width: deviceWidth - 70,
                  child: provider.contentList.contains(thisContent)
                    ? Text(
                      thisContent.watchDate,
                      style: TextStyleFamily.normalTextStyle)
                    : SizedBox()
                ),
                const SizedBox(height: 20),

                /// 나의 평점
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("나의 평점", style: TextStyleFamily.smallTextStyle),
                      const SizedBox(width: 30),
                      provider.contentList.contains(thisContent)
                      ? Text(
                        "${thisContent.rating}",
                        style: TextStyleFamily.colorTextStyle,
                      )
                      : SizedBox()
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                /// 임시 버튼
                // Material(
                //   color: ColorFamily.coral,
                //   elevation: 1,
                //   shadowColor: Colors.black,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20.0),
                //   ),
                //   child: InkWell(
                //     splashColor: Colors.transparent,
                //     onTap: () {},
                //     borderRadius: BorderRadius.circular(20.0),
                //     child: SizedBox(
                //       height: 40,
                //       width: deviceWidth * 0.6,
                //       child: Container(
                //         alignment: Alignment.center,
                //         child: Text(
                //           "감상평 삭제",
                //           style: TextStyleFamily.buttonTextStyle,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ));
    });
  }
}