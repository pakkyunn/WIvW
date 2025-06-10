import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> categoryList = ["예능", "로맨스", "스릴러", "SF", "액션", "공포", "미스터리", "추리", "서바이벌", "애니메이션", "코미디", "다큐멘터리"];

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
                //TODO 해당 카테고리의 상세페이지로 이동
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