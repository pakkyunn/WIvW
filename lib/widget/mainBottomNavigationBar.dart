import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wivw/style/color.dart';
import 'package:wivw/screen/categoryScreen.dart';
import 'package:wivw/screen/homeScreen.dart';
import 'package:wivw/screen/settingScreen.dart';
import 'package:wivw/screen/writeScreen.dart';
import 'package:wivw/widget/mainAppBar.dart';

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
              icon: SvgPicture.asset('lib/icons/home.svg'),
              label: 'Home',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('lib/icons/write.svg'),
              label: 'Write',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('lib/icons/category.svg'),
              label: 'Category',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('lib/icons/settings.svg'),
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