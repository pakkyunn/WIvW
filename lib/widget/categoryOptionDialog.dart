import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wivw/enums.dart';
import 'package:wivw/provider/providers.dart';

class CategoryOptionDialog extends StatefulWidget{
  const CategoryOptionDialog({super.key});

  @override
  State<CategoryOptionDialog> createState() => _CategoryOptionDialogState();
}

class _CategoryOptionDialogState extends State<CategoryOptionDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WriteProvider>(builder: (context, provider, child) {
      return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3열
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.0 // 버튼+텍스트 비율 조정
        ),
        itemCount: CategoryType.values.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  provider.selectCategoryType(CategoryType.values[index].number);
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.star),
              ),
              SizedBox(height: 8),
              Text(CategoryType.getNameByNumber(index+1)!),
            ],
          );
        },
      );
    }
    );
  }
}