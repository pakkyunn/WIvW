import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wivw/screen/categoryScreen.dart';
import 'package:wivw/screen/settingScreen.dart';
import 'package:wivw/screen/writeScreen.dart';

import '../provider/providers.dart';
import '../style/color.dart';
import '../widget/mainAppBar.dart';
import '../widget/mainBottomNavigationBar.dart';
import 'homeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget Function(void Function(int) onChange)> _screens = [
    (onChange) => HomeScreen(onChange: onChange),
    (onChange) => WriteScreen(onChange: onChange),
    (onChange) => CategoryScreen(onChange: onChange),
    (onChange) => SettingScreen(onChange: onChange),
  ];

  Future<void> _onItemTapped(int index) async {
    if (Provider.of<WriteProvider>(context, listen: false).isEdited) {
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

      if (result == true){
        setState(() {_selectedIndex = index;});
        print("@@3확인눌렀을때index: $index");
        print("@@4확인눌렀을때_selectedindex: $_selectedIndex");
        Provider.of<WriteProvider>(context, listen: false).setEditState(false); // 확인 선택 시 작성상태 초기화
      } else {
        return; // 취소 선택 시 이동 안함
      }
    } else {
      setState(() {_selectedIndex = index;});
      // print("@@1: 온아이템탭");
    }
  }

  void _changeBody(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("@@2: 체인지바디메서드");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(),
        body: _screens[_selectedIndex](_changeBody),
        bottomNavigationBar: mainBottomNavigationBar()
    );
  }

  Theme mainBottomNavigationBar() {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        unselectedWidgetColor: ColorFamily.skyBlue
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
              // backgroundColor: ColorFamily.lightPurple,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/icons/home.svg'), label: 'Home', activeIcon: SvgPicture.asset('lib/icons/home.svg', color: ColorFamily.mint)),
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/icons/write.svg'), label: 'Write', activeIcon: SvgPicture.asset('lib/icons/write.svg', color: ColorFamily.mint)),
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/icons/category.svg'), label: 'Category', activeIcon: SvgPicture.asset('lib/icons/category.svg', color: ColorFamily.mint)),
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/icons/settings.svg'), label: 'Settings', activeIcon: SvgPicture.asset('lib/icons/settings.svg', color: ColorFamily.mint)),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorFamily.mint,
        onTap: (index) {
          if(_selectedIndex != index){
            _onItemTapped(index);
            Provider.of<MainProvider>(context, listen: false).setMainAppBarName(
              "내가", ColorFamily.lightPurple);
          }
        },
      ),
    );
  }
}