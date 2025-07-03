import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wivw/style/color.dart';
import 'package:wivw/style/font.dart';

import '../provider/providers.dart';
import '../utils.dart';

class DetailScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DetailScreenAppBar({required this.index, super.key});

  final int index;

  @override
  State<DetailScreenAppBar> createState() => _DetailScreenAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _DetailScreenAppBarState extends State<DetailScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        splashColor: Colors.transparent,
        icon: Icon(Icons.arrow_back_ios_new),
        padding: const EdgeInsets.only(left: 16.0),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          splashColor: Colors.transparent,
          icon: Icon(Icons.delete),
          padding: const EdgeInsets.only(right: 16.0),
          onPressed: () async {
            //TODO 감상평 삭제 다이얼로그
            final result = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('감상평을 삭제하시겠습니까?'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('삭제된 이후에는 복구할 수 없습니다.')],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('취소'),
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context, true),
                        },
                        child: Text('확인'),
                      ),
                    ],
                  ),
                ],
              ),
            );

            if (result == true) {
              print("@@@: ${widget.index}");
              Provider.of<MainProvider>(context, listen: false).deleteContent(widget.index);
              Navigator.pop(context, true);
              showSnackBar(context, "감상평이 삭제되었습니다.");
            } else {
              return; // 취소 선택 시 이동 안함
            }
          },
        ),
      ],
      title: Text(
        '',
        style: TextStyle(
          color: FontColor.mainColor,
          fontFamily: FontFamily.cafe24Moyamoya,
        ),
      ),
    );
  }
}
