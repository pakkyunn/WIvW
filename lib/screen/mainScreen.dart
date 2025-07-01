import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wivw/main.dart';
import 'package:wivw/screen/categoryScreen.dart';
import 'package:wivw/screen/settingScreen.dart';
import 'package:wivw/screen/writeScreen.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:wivw/utils.dart';

import '../provider/providers.dart';
import '../style/color.dart';
import '../widget/mainAppBar.dart';
import 'homeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List _screens = [
    HomeScreen(),
    WriteScreen(),
    CategoryScreen(),
    SettingScreen(),
  ];

  Future<void> _onItemTapped(int index) async {
    var mainProvider = Provider.of<MainProvider>(context, listen: false);
    var writeProvider = Provider.of<WriteProvider>(context, listen: false);
    if (writeProvider.isEdited) {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('작성 중인 내용이 있습니다'),
          content: Text('작성 내용을 저장하지 않고 이동하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('확인'),
            ),
          ],
        ),
      );

      if (result == true) {
        mainProvider.showBodyScreen(index);
        mainProvider.setBottomNavigationIdx(index);
        mainProvider.setCategoryIdx(0);
        writeProvider.setEditState(false); // 확인 선택 시 작성상태 초기화
      } else {
        return; // 취소 선택 시 이동 안함
      }
    } else {
      mainProvider.showBodyScreen(index);
      mainProvider.setBottomNavigationIdx(index);
      mainProvider.setCategoryIdx(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body:_screens[Provider.of<MainProvider>(
        context,
        listen: false,
      ).bodyIndex],
      bottomNavigationBar: mainBottomNavigationBar(),
    );
  }

  Theme mainBottomNavigationBar() {
    var provider = Provider.of<MainProvider>(context);
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        unselectedWidgetColor: ColorFamily.skyBlue,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        // backgroundColor: ColorFamily.lightPurple,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('lib/asset/icons/home.svg'),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              'lib/asset/icons/home.svg',
              color: ColorFamily.mint,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('lib/asset/icons/write.svg'),
            label: 'Write',
            activeIcon: SvgPicture.asset(
              'lib/asset/icons/write.svg',
              color: ColorFamily.mint,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('lib/asset/icons/category.svg'),
            label: 'Category',
            activeIcon: SvgPicture.asset(
              'lib/asset/icons/category.svg',
              color: ColorFamily.mint,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('lib/asset/icons/settings.svg'),
            label: 'Settings',
            activeIcon: SvgPicture.asset(
              'lib/asset/icons/settings.svg',
              color: ColorFamily.mint,
            ),
          ),
        ],
        currentIndex: provider.bottomNavigationIdx,
        selectedItemColor: ColorFamily.mint,
        onTap: (index) {
          if (provider.bottomNavigationIdx != index) {
            _onItemTapped(index);
            provider.setMainAppBarName("내가", ColorFamily.lightPurple);
          }else if(index == 0){
            _onItemTapped(index);
            provider.setMainAppBarName("내가", ColorFamily.lightPurple);
          }else if(index == 2){
            _onItemTapped(index);
            provider.setMainAppBarName("내가", ColorFamily.lightPurple);
          }
        },
      ),
    );
  }
}
