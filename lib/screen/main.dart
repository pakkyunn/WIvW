import 'package:flutter/material.dart';
import 'package:wivw/color.dart';

import '../widget/MainBottomNavigationBar.dart';

void main() {
  runApp(const WIvW());
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
