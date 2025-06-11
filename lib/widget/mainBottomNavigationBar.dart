// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:wivw/style/color.dart';
// import 'package:wivw/screen/categoryScreen.dart';
// import 'package:wivw/screen/homeScreen.dart';
// import 'package:wivw/screen/settingScreen.dart';
// import 'package:wivw/screen/writeScreen.dart';
// import 'package:wivw/widget/mainAppBar.dart';
//
// import '../provider/main_provider.dart';
//
// class MainBottomNavigationBar extends StatefulWidget {
//   const MainBottomNavigationBar(this.selectedIndex, {super.key});
//   final int selectedIndex;
//
//   @override
//   State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
// }
//
// class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//         data: ThemeData(
//           splashColor: Colors.transparent,      // 클릭 시 번지는 효과 제거
//           // highlightColor: Colors.transparent,   // 클릭 시 강조 효과 제거
//         ),
//         child: NavigationBar(
//           onDestinationSelected: (int index) {
//             setState(() {
//               widget.selectedIndex = index;
//             });
//             Provider.of<MainProvider>(context, listen: false).setMainAppBarName("내가");
//           },
//           indicatorColor: ColorFamily.gray,
//           backgroundColor: Colors.black54,
//           selectedIndex: widget.selectedIndex,
//           destinations: <Widget>[
//             NavigationDestination(
//               // selectedIcon: SvgPicture.asset('lib/icons/Home.svg'),
//               icon: SvgPicture.asset('lib/icons/home.svg'),
//               label: 'Home',
//             ),
//             NavigationDestination(
//               icon: SvgPicture.asset('lib/icons/write.svg'),
//               label: 'Write',
//             ),
//             NavigationDestination(
//               icon: SvgPicture.asset('lib/icons/category.svg'),
//               label: 'Category',
//             ),
//             NavigationDestination(
//               icon: SvgPicture.asset('lib/icons/settings.svg'),
//               label: 'Settings',
//             ),
//           ],
//         )
//     );
//   }
// }