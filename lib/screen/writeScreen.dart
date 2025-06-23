import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wivw/enums.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../model/content_model.dart';
import '../provider/providers.dart';
import '../style/color.dart';
import '../style/font.dart';
import '../style/textStyle.dart';
import '../utils.dart';
import '../widget/categoryOptionDialog.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  String _tempPosterImagePath = "";
  String _tempTitle = "";
  int _tempCategory = 0;
  String _tempCategoryText = "카테고리를 선택해주세요";
  String _tempReview = "";
  String _tempWatchDate = "날짜를 선택해주세요";
  double _tempRating = 0.0;

  final FocusNode _tempTitleFocusNode = FocusNode();
  final FocusNode _tempReviewFocusNode = FocusNode();

  bool _isKeyboardOpen = false;

  void _closeKeyboardAndPop(BuildContext context) async {
    // 키보드 닫기
    FocusScope.of(context).unfocus();

    // 키보드 닫힘 애니메이션을 기다린 후 pop 호출
    await Future.delayed(Duration(milliseconds: 100));

    // 이제 Navigator.pop 호출
    Navigator.pop(context);
  }

  late int contentIndex;
  @override
  void initState() {
    super.initState();
    setState(() {
      contentIndex = Provider.of<MainProvider>(context, listen: false).contentIndex;
    });
  }

  @override
  void dispose() {
    _deleteCache(_tempPosterImagePath);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    // var deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<WriteProvider>(
      builder: (context, provider, child) {
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(
              // padding: const EdgeInsets.symmetric(vertical: 8.0),
              // color: ColorFamily.deepGreen,
              width: deviceWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 포스터 이미지
                  SizedBox(
                    width: 150,
                    height: 230,
                    child: Card(
                      // color: Colors.white,
                      elevation: 1,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () async {
                          final ImagePicker picker =
                              ImagePicker(); //ImagePicker 초기화
                          final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (pickedFile != null) {
                            provider.setEditState(true);
                            setState(() {
                              _tempPosterImagePath = pickedFile.path;
                              // posterImage = pickedFile;
                            });
                          }
                        },
                        child: _tempPosterImagePath == ""
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: null,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'lib/icons/write.svg',
                                        width: 40,
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(_tempPosterImagePath),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// 작품명
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "작품명",
                        style: TextStyleFamily.normalTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: deviceWidth - 60,
                    child: Material(
                      elevation: 0.5,
                      color: ColorFamily.white,
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          style: TextStyleFamily.buttonTextStyle,
                          cursorColor: ColorFamily.black,
                          autofocus: false,
                          focusNode: _tempTitleFocusNode,
                          maxLength: 50,
                          // initialValue: tempUserNickname,
                          onChanged: (value) {
                            setState(() {
                              _tempTitle = value;
                            });
                            provider.setEditState(true);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _tempTitleFocusNode.unfocus();
                            },
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                            _tempTitleFocusNode.unfocus();
                          },
                          // style: TextStyleFamily.smallTitleTextStyle,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counter: SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// 카테고리
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "카테고리",
                        style: TextStyleFamily.normalTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: deviceWidth - 60,
                    child: Material(
                      elevation: 0.5,
                      color: ColorFamily.white,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: CategoryOptionDialog()
                            ),
                          );
                          setState(() {
                            _tempCategory = provider.selectedCategoryType;
                          });
                          
                          if(_tempCategory != 0) {
                            _tempCategoryText = "${CategoryType.getNameByNumber(_tempCategory)}";
                            provider.setEditState(
                              true,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _tempCategoryText,
                              style: TextStyleFamily.buttonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// 감상평
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "감상평",
                        // style: TextStyleFamily.normalTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: deviceWidth - 60,
                    child: Material(
                      elevation: 0.5,
                      color: ColorFamily.white,
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          style: TextStyleFamily.buttonTextStyle,
                          cursorColor: ColorFamily.black,
                          focusNode: _tempReviewFocusNode,
                          // initialValue: tempProfileMessage,
                          inputFormatters: [
                            // LengthLimitingTextInputFormatter(50), // 글자 수 제한
                            // FilteringTextInputFormatter.deny(RegExp(r'\n')), // 줄바꿈 입력 제한
                          ],
                          onChanged: (value) {
                            setState(() {
                              _tempReview = value;
                            });
                            provider.setEditState(true);
                          },
                          // onFieldSubmitted: (value) {
                          //   provider.setEditState(true);
                          // },
                          maxLength: 500,
                          maxLines: null,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                            _tempReviewFocusNode.unfocus();
                          },
                          // style: TextStyleFamily.smallTitleTextStyle,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: "", // 글자 수 카운터 숨김
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// 시청 날짜
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "시청 날짜",
                        // style: TextStyleFamily.normalTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: deviceWidth - 60,
                    child: Material(
                      elevation: 0.5,
                      color: ColorFamily.white,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          picker.DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1900, 1, 1),
                            maxTime: DateTime.now(),
                            theme: const picker.DatePickerTheme(
                              titleHeight: 60,
                              containerHeight: 300,
                              itemHeight: 50,
                              headerColor: ColorFamily.white,
                              backgroundColor: ColorFamily.white,
                              // itemStyle: TextStyleFamily.smallTitleTextStyle,
                              cancelStyle: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 18,
                                fontFamily: FontFamily.mapleStoryLight,
                              ),
                              doneStyle: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 18,
                                fontFamily: FontFamily.mapleStoryLight,
                              ),
                            ),
                            locale: picker.LocaleType.ko,
                            currentTime: _tempWatchDate == "날짜를 선택해주세요"
                            ? DateTime.now()
                            : stringToDate(_tempWatchDate),
                            onConfirm: (date) {
                              setState(() {
                                // _nickNameFocusNode.unfocus();
                                // _profileMessageFocusNode.unfocus();
                                _tempWatchDate = dateToStringFull(date);
                              });
                              provider.setEditState(true);
                            },
                            onCancel: () {
                            //   _nickNameFocusNode.unfocus();
                            //   _profileMessageFocusNode.unfocus();
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _tempWatchDate,
                              style: TextStyleFamily.buttonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// 나의 평점
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("나의 평점", style: TextStyleFamily.normalTextStyle),
                        const SizedBox(width: 30),
                        Text(
                          "$_tempRating",
                          style: TextStyleFamily.impactTextStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SfSliderTheme(
                    data: SfSliderThemeData(
                      activeTrackColor: Colors.pink,
                      inactiveTrackColor: Colors.pink[100],
                    ),
                    child: SfSlider(
                      min: 0.0,
                      max: 5.0,
                      stepSize: 0.1,
                      value: _tempRating,
                      enableTooltip: false,
                      thumbShape: MyThumbShape(),
                      thumbIcon: Icon(Icons.favorite, color: Colors.pink),
                      // 하트 아이콘
                      onChanged: (dynamic value) {
                        setState(() {
                          _tempRating = double.parse(value.toStringAsFixed(1));
                        });
                        provider.setEditState(true);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  /// 작성하기 버튼
                  Material(
                    color: ColorFamily.skyBlue,
                    elevation: 1,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      splashColor: ColorFamily.gray,
                      onTap: () async {
                        _isAllSubmitted(
                              _tempPosterImagePath,
                              _tempTitle,
                              _tempCategory,
                              _tempReview,
                              _tempWatchDate,
                            )
                            ? {
                                _saveData(context, contentIndex, await _cacheToAppStorage(_tempPosterImagePath, _tempTitle), _tempTitle, _tempCategory, _tempReview, _tempWatchDate, _tempRating),
                                Provider.of<MainProvider>(context, listen: false).showBodyScreen(0),
                                Provider.of<MainProvider>(context, listen: false).setBottomNavigationIdx(0),
                                //작성완료 후 메인화면으로 이동
                                showSnackBar(context, "감상평이 작성되었습니다!"),
                                provider.setEditState(false),
                              }
                            : Fluttertoast.showToast(
                                msg: "모든 항목을 작성해주세요",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: SizedBox(
                        height: 40,
                        width: deviceWidth * 0.6,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "작성하기",
                            style: TextStyleFamily.buttonTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

bool _isAllSubmitted(
  String path,
  String name,
  int category,
  String review,
  String date,
) {
  if (path != "" && name != "" && category != 0 && review != "" && date != "") {
    return true;
  } else {
    return false;
  }
}

Future<String> _cacheToAppStorage(String imagePath, String name) async {
  final appDir = await getApplicationDocumentsDirectory();

  // final fileName = '$name.webp'; //데이터 저장을 위한 임시 파일명
  final fileName = '${DateTime.now().millisecondsSinceEpoch}_$name.webp';
  final targetPath = '${appDir.path}/$fileName';

  final compressedFile = await FlutterImageCompress.compressAndGetFile(
    imagePath, // 원본 파일 경로
    targetPath,
    quality: 80,
    minWidth: 300,
    minHeight: 300,
    format: CompressFormat.webp,
  );

  return compressedFile!.path;
}

Future<void> _saveData(
    BuildContext context,
    int index,
    String posterPath,
    String title,
    int category,
    String review,
    String watchDate,
    double rating
    ) async {
  var model = ContentModel(index, posterPath, title, category, review, watchDate, rating);
  var provider = Provider.of<MainProvider>(context, listen: false);
  var oldList = provider.contentList;
  var newList = List<ContentModel>.from(oldList)..insert(0, model);

  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(newList.map((e) => e.toJson()).toList());
  await prefs.setString('contentList', jsonString);
  await prefs.setInt('contentIndex', model.index+1);
  provider.setContentList(newList);
}

Future<void> _deleteCache(String cachePath) async {
  if (cachePath != "") {
    final cacheFile = File(cachePath);
    final parentDir = cacheFile.parent;
    try {
      await cacheFile.delete();
      print('캐시 파일 삭제 완료: $cachePath');

      final contents = parentDir.listSync();
      if (contents.isEmpty) {
        await parentDir.delete();
        print('빈 폴더 삭제 완료: ${parentDir.path}');
      }
    } catch (e) {
      print('파일 삭제 실패: $e');
    }
  }
}

class MyThumbShape extends SfThumbShape {
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required RenderBox? child,
    required SfSliderThemeData themeData,
    SfRangeValues? currentValues,
    dynamic currentValue,
    required Paint? paint,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required SfThumb? thumb,
  }) {
    // 하트 아이콘을 직접 그리기
    const double iconSize = 32.0;
    final icon = Icons.favorite;
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: iconSize,
          fontFamily: icon.fontFamily,
          color: Colors.pink,
          package: icon.fontPackage,
        ),
      ),
      textDirection: textDirection,
    );
    textPainter.layout();
    textPainter.paint(
      context.canvas,
      Offset(center.dx - iconSize / 2, center.dy - iconSize / 2),
    );
  }
}


// 테스트 데이터 생성을 위한 메서드
Future<void> _saveTestData(BuildContext context) async {
  final List<ContentModel> newList = [
    ContentModel(0, "/data/user/0/com.pakk.wivw.wivw/app_flutter/놀면 뭐하니?.webp", "놀면 뭐하니?", 1, "유쾌하면서도 실험적인 포맷이 계속 새로워서 보는 재미가 있다.", "2024-06-10", 4.5),
    ContentModel(1, "/data/user/0/com.pakk.wivw.wivw/app_flutter/피지컬: 100 시즌2.webp", "피지컬: 100 시즌2", 1, "실제 경기처럼 몰입감이 엄청났고, 참가자들의 인간미도 인상 깊었다.", "2023-12-28", 4.0),
    ContentModel(2, "/data/user/0/com.pakk.wivw.wivw/app_flutter/너의 시간 속으로.webp", "너의 시간 속으로", 2, "과거와 현재를 오가는 스토리가 복잡하지만 애틋함이 잘 전해졌다.", "2020-04-12", 4.2),
    ContentModel(3, "/data/user/0/com.pakk.wivw.wivw/app_flutter/브리저튼.webp", "브리저튼", 2, "화려한 시대극 배경에 현대적인 로맨스를 녹여낸 감각이 돋보인다.", "2022-01-03", 3.8),
    ContentModel(4, "/data/user/0/com.pakk.wivw.wivw/app_flutter/클로저.webp", "클로저", 2, "인간관계의 이면과 사랑의 복잡함을 날카롭게 표현한 수작.", "2018-10-16", 4.0),
    ContentModel(5, "/data/user/0/com.pakk.wivw.wivw/app_flutter/더 나이트 에이전트.webp", "더 나이트 에이전트", 3, "한순간도 긴장을 놓을 수 없는 전개가 몰입도를 극대화한다.", "2019-02-11", 4.3),
    ContentModel(6, "/data/user/0/com.pakk.wivw.wivw/app_flutter/파운데이션.webp", "파운데이션", 4, "방대한 세계관과 철학적 질문이 돋보이지만 집중이 필요하다.", "2014-07-01", 4.1),
    ContentModel(7, "/data/user/0/com.pakk.wivw.wivw/app_flutter/리얼스틸.webp", "리얼스틸", 4, "치열한 로봇 파이터들의 세계를 그려낸 블록버스터. 로봇 파이터의 불가능한 도전이 시작된다!", "2011-03-19", 3.7),
    ContentModel(8, "/data/user/0/com.pakk.wivw.wivw/app_flutter/존 윅 4.webp", "존 윅 4", 5, "시리즈 중 가장 화려한 액션과 감정선이 균형을 이룬 작품.", "2025-04-04", 4.6),
    ContentModel(9, "/data/user/0/com.pakk.wivw.wivw/app_flutter/익스트랙션 2.webp", "익스트랙션 2", 5, "현실감 있는 전투 장면과 거침없는 액션이 인상 깊다.", "2020-08-30", 4.0),
    ContentModel(10, "/data/user/0/com.pakk.wivw.wivw/app_flutter/베를린.webp", "베를린", 5, "한국형 첩보물의 긴장감과 캐릭터간 심리전이 흥미롭다.", "2015-06-05", 3.9),
    ContentModel(11, "/data/user/0/com.pakk.wivw.wivw/app_flutter/인시디어스: 더 레드 도어.webp", "인시디어스: 더 레드 도어", 6, "갑작스러운 공포보단 서서히 쌓이는 긴장감이 매력적이다.", "2015-06-19", 3.6),
    ContentModel(12, "/data/user/0/com.pakk.wivw.wivw/app_flutter/셜록.webp", "셜록", 7, "캐릭터와 대사의 센스가 넘치고 사건 전개도 탁월하다.", "2011-01-28", 4.8),
    ContentModel(13, "/data/user/0/com.pakk.wivw.wivw/app_flutter/더 글로리.webp", "더 글로리", 7, "복수극이지만 치밀한 구조 덕분에 추리적 재미도 충분했다.", "2023-05-30", 4.5),
    ContentModel(14, "/data/user/0/com.pakk.wivw.wivw/app_flutter/위대한 쇼맨.webp", "위대한 쇼맨", 8, "눈과 귀를 사로잡는 뮤지컬 넘버들이 감동을 배가시킨다.", "2022-02-22", 4.7),
    ContentModel(15, "/data/user/0/com.pakk.wivw.wivw/app_flutter/솔로지옥 시즌3.webp", "솔로지옥 시즌3", 9, "연애와 심리 게임이 절묘하게 얽혀 재미와 긴장감이 공존했다.", "2024-03-16", 4.0),
    ContentModel(16, "/data/user/0/com.pakk.wivw.wivw/app_flutter/스파이 패밀리.webp", "스파이 패밀리", 10, "유쾌한 가족 코미디와 첩보물이 자연스럽게 어우러진다.", "2022-11-13", 4.3),
    ContentModel(17, "/data/user/0/com.pakk.wivw.wivw/app_flutter/너의 이름은.webp", "너의 이름은", 10, "아름다운 작화와 감성적인 스토리가 인상 깊은 작품.", "2019-07-04", 4.9),
    ContentModel(18, "/data/user/0/com.pakk.wivw.wivw/app_flutter/프렌즈.webp", "프렌즈", 11, "시대를 초월하는 웃음과 캐릭터의 매력이 여전히 유효하다.", "2011-04-30", 4.5),
    ContentModel(19, "/data/user/0/com.pakk.wivw.wivw/app_flutter/진격의 거인.webp", "진격의 거인", 10, "갓 띵작", "2025-01-22", 5.0),
  ];
  var provider = Provider.of<MainProvider>(context, listen: false);

  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(newList.map((e) => e.toJson()).toList());
  await prefs.setString('contentList', jsonString);
  await prefs.setInt('contentIndex', 20);
  provider.setContentList(newList);
}
