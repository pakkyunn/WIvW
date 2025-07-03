import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wivw/enums.dart';
import 'package:wivw/provider/providers.dart';

class ContentDeleteDialog extends StatefulWidget{
  const ContentDeleteDialog({super.key});

  @override
  State<ContentDeleteDialog> createState() => _ContentDeleteDialogState();
}

class _ContentDeleteDialogState extends State<ContentDeleteDialog> {
  @override
  Widget build(BuildContext context) {
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
                Provider.of<WriteProvider>(context, listen: false).selectCategoryType(CategoryType.values[index].number);
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
}