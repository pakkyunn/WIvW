import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wivw/screen/homeScreen.dart';
import 'package:wivw/style/color.dart';

import '../enums.dart';
import '../provider/providers.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.onChange});
  final void Function(int) onChange;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> categoryList = CategoryType.values.map((e) => e.name).toList();

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, provider, child) {
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
                  provider.setCategoryIdx(CategoryType.values[index].number);
                  var list = provider.contentList.where((model) => model.category == provider.categoryIdx).toList();
                  provider.setContentList(list);
                  provider.setMainAppBarName(categoryList[index], ColorFamily.coral);
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
    );
  }
}