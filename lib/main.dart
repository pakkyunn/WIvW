import 'package:flutter/material.dart';
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
    return SafeArea(
      child: MaterialApp(
          title: '내가 뭐 봤었더라?',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: ColorFamily.darkGray, brightness: Brightness.dark),
              useMaterial3: true
          ),
          home: MainBottomNavigationBar()
      ),
    );
  }
}
