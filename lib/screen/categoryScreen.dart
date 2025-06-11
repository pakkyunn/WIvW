import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wivw/screen/homeScreen.dart';

import '../enums.dart';
import '../provider/main_provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.onChange});
  final void Function(int) onChange;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> categoryList = CategoryType.values.map((e) => e.type).toList();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3열
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.2, // 버튼+텍스트 비율 조정
      ),
      itemCount: categoryList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<MainProvider>(context, listen: false)
                    .setCategoryIdx(CategoryType.values.firstWhere((e) => e.type == categoryList[index]).value);
                Provider.of<MainProvider>(context, listen: false).setMainAppBarName(categoryList[index]);
                //TODO 해당 카테고리의 작품들만 보여주는 리스트 화면으로 이동
                widget.onChange(0);
              },
              child: Icon(Icons.star),
            ),
            SizedBox(height: 8),
            Text(categoryList[index]),
          ],
        );
      },
    );
  }
}