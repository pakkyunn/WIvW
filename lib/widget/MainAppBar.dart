import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wivw/color.dart';
import 'package:wivw/font.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget{
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SvgPicture.asset('lib/icons/WIvW.svg'),
      ),
      title: Row(
        children: [
          Text('내가 뭐 봤었더라', style: TextStyle(color: FontColor.mainColor, fontFamily: FontFamily.cafe24Moyamoya)),
        ],
      ),
    );
  }
}