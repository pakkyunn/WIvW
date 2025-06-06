import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wivw/color.dart';
import 'package:wivw/screen/CategoryScreen.dart';
import 'package:wivw/screen/HomeScreen.dart';
import 'package:wivw/screen/SettingScreen.dart';
import 'package:wivw/screen/WriteScreen.dart';
import 'package:wivw/widget/MainAppBar.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,      // 클릭 시 번지는 효과 제거
          // highlightColor: Colors.transparent,   // 클릭 시 강조 효과 제거
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: ColorFamily.gray,
          backgroundColor: Colors.black54,
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              // selectedIcon: SvgPicture.asset('lib/icons/Home.svg'),
              icon: SvgPicture.asset('lib/icons/Home.svg'),
              label: 'Home',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('lib/icons/Write.svg'),
              label: 'Write',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('lib/icons/Category.svg'),
              label: 'Category',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('lib/icons/Settings.svg'),
              label: 'Settings',
            ),
          ],
        ),
      ),
      body:
      <Widget>[
        /// Home page
        HomeScreen(),

        /// Write page
        WriteScreen(),

        /// Category page
        CategoryScreen(),

        /// Settings page
        SettingScreen()
      ][currentPageIndex],
    );
  }
}