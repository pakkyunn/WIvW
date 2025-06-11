import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wivw/style/color.dart';
import 'package:wivw/style/font.dart';

import '../provider/main_provider.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget{
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, provider, child) {
      return AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SvgPicture.asset('lib/icons/wIvw.svg'),
        ),
        title: Row(
          children: [
            Text('${provider.mainAppBarName} 뭐 봤었더라', style: TextStyle(color: FontColor.mainColor, fontFamily: FontFamily.cafe24Moyamoya)),
          ],
        ),
      );
    });
  }
}