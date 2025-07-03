import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wivw/provider/providers.dart';
import 'package:wivw/screen/mainScreen.dart';
import 'package:wivw/style/color.dart';
import 'package:wivw/utils.dart';

import 'model/content_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkFirstLaunch();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider())
      ],
      child: const WIvW()));
}

class WIvW extends StatefulWidget {
  const WIvW({super.key});

  @override
  State<WIvW> createState() => _WIvWState();
}

class _WIvWState extends State<WIvW>{
  @override
  void initState() {
    super.initState();
    loadContentData();
  }

  Future<void> loadContentData() async {
    var provider = Provider.of<MainProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final List<dynamic> jsonList = jsonDecode(prefs.getString('contentList')!);
    final List<ContentModel> contentList = jsonList
        .map((item) => ContentModel.fromJson(item as Map<String, dynamic>))
        .toList();

    contentList.sort((a, b) => b.index.compareTo(a.index)); // 최근 작성순으로 정렬
    final contentIndex = prefs.getInt("contentIndex");


    provider.setContentList(contentList);
    provider.setContentIndex(contentIndex!);
    // print("@@@: ${provider.contentList[2].index}");
    // print("@@@: ${provider.contentList[0].posterPath}");
    print("@@@: ${provider.contentList[0].index}");
    print("@@@: ${provider.contentList[1].index}");
    // print("@@@: ${provider.contentList[4].category}");
    // print("@@@: ${provider.contentList[4].review}");
    // print("@@@: ${provider.contentList[0].watchDate}");
    // print("@@@: ${provider.contentList[0].rating}");
    // print("@@@: ${provider.contentIndex}");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => WriteProvider()),
        ],
        child: SafeArea(
          child: MaterialApp(
              title: 'WIvW',
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: ColorFamily.darkGray, brightness: Brightness.dark),
                  useMaterial3: true
              ),
              home: DoubleBackToExitWrapper(
                child: MainScreen(),
              ),
          ),
        ),
      );
  }
}
