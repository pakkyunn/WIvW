import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wivw/provider/main_provider.dart';
import 'package:wivw/screen/mainScreen.dart';
import 'package:wivw/style/color.dart';

import 'widget/mainBottomNavigationBar.dart';

void main() {
  runApp(const WIvW());
  ///TODO 로컬에 있는 리스트데이터를 모두 가져오고 프로바이더 등에 저장
}

class WIvW extends StatefulWidget {
  const WIvW({super.key});

  @override
  State<WIvW> createState() => _WIvWState();
}

class _WIvWState extends State<WIvW>{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MainProvider()),
        ],
        child: SafeArea(
          child: MaterialApp(
              title: 'WIvW',
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: ColorFamily.darkGray, brightness: Brightness.dark),
                  useMaterial3: true
              ),
              home: MainScreen()
          ),
        ),
      );
  }
}
