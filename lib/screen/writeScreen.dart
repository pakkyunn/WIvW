import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../provider/providers.dart';
import '../style/color.dart';
import '../style/font.dart';
import '../style/textStyle.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key, required this.onChange});
  final void Function(int) onChange;

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  String posterImagePath = "";
  XFile? posterImage;
  double _value = 0.0;

  bool _isKeyboardOpen = false;

  void _closeKeyboardAndPop(BuildContext context) async {
    // 키보드 닫기
    FocusScope.of(context).unfocus();

    // 키보드 닫힘 애니메이션을 기다린 후 pop 호출
    await Future.delayed(Duration(milliseconds: 100));

    // 이제 Navigator.pop 호출
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    // var deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<WriteProvider>(builder: (context, provider, child) {
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
                        final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
                        final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                        if(pickedFile != null) {
                          provider.setEditState(true);
                          setState(() {
                            posterImagePath = pickedFile.path;
                            // posterImage = pickedFile;
                          });
                          // provider.setImage(XFile(pickedFile.path));
                          // provider.setMemoryBannerImage(
                          //     Image.file(File(pickedFile.path), fit: BoxFit.cover));
                          // var imageName =
                          //     "${provider.userIdx}_memory_banner_${DateTime.now()}";
                          // provider.setMemoryBannerImagePath(imageName);
                          // updateSpecificUserData(provider.userIdx,
                          //     "memory_banner_image", provider.memoryBannerImagePath);
                          // updateSpecificUserData(provider.loverIdx,
                          //     "memory_banner_image", provider.memoryBannerImagePath);
                          // uploadMemoryBannerImage(provider.image!, imageName);
                        }
                      },
                      child: posterImagePath == ""
                          ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: null),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'lib/icons/write.svg',
                                    width: 40,
                                    height: 40),
                              ],
                            ),
                          ))
                          : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: FileImage(File(posterImagePath)),
                                  fit: BoxFit.cover))),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                /// 작품명
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("작품명",
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
                        // focusNode: _nickNameFocusNode,
                        maxLength: 10,
                        // initialValue: tempUserNickname,
                        onChanged: (value) {
                          Provider.of<WriteProvider>(context, listen: false).setEditState(true);
                        },
                        onFieldSubmitted: (value) {
                          // Provider.of<WriteProvider>(context, listen: false).setEditState(true);
                        },
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        // style: TextStyleFamily.smallTitleTextStyle,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            counter: SizedBox()),
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
                    child: Text("카테고리",
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
                      onTap: () {
                        //TODO 다이얼로그 등으로 카테고리 선택할 수 있도록 창 띄우기
                        Provider.of<WriteProvider>(context, listen: false).setEditState(true); //TODO 추후 카테고리를 선택이 되면 변경하도록 수정
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("선택된 카테고리 표시",
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
                    child: Text("감상평",
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
                    child: TextFormField(
                      style: TextStyleFamily.buttonTextStyle,
                      cursorColor: ColorFamily.black,
                      // focusNode: _profileMessageFocusNode,
                      // initialValue: tempProfileMessage,
                      inputFormatters: [
                        // LengthLimitingTextInputFormatter(50), // 글자 수 제한
                        // FilteringTextInputFormatter.deny(RegExp(r'\n')), // 줄바꿈 입력 제한
                      ],
                      onChanged: (value) {
                        setState(() {
                          // tempProfileMessage = value;
                        });
                      },
                      onFieldSubmitted: (value) {
                        Provider.of<WriteProvider>(context, listen: false).setEditState(true);
                      },
                      maxLength: 60,
                      maxLines: null,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      // style: TextStyleFamily.smallTitleTextStyle,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: "", // 글자 수 카운터 숨김
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
                    child: Text("시청 날짜",
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
                          // currentTime: _selectedDate,
                          onConfirm: (date) {
                            setState(() {
                            //   _selectedDate = date;
                            //   tempUserBirth = dateToString(_selectedDate);
                            // });
                            // _nickNameFocusNode.unfocus();
                            // _profileMessageFocusNode.unfocus();
                              Provider.of<WriteProvider>(context, listen: false).setEditState(true);
                            });},
                          // onCancel: () {
                          //   _nickNameFocusNode.unfocus();
                          //   _profileMessageFocusNode.unfocus();
                          // },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("선택된 날짜 표시",
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
                      Text("나의 평점",
                        style: TextStyleFamily.normalTextStyle,
                      ),
                      const SizedBox(width: 30),
                      Text(_value.toStringAsFixed(1), style: TextStyleFamily.impactTextStyle)
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
                    value: _value,
                    interval: 0.5,
                    enableTooltip: false,
                    thumbShape: MyThumbShape(),
                    thumbIcon: Icon(Icons.favorite, color: Colors.pink), // 하트 아이콘
                    onChanged: (dynamic value){
                      setState(() {
                        _value = value;
                      });
                      Provider.of<WriteProvider>(context, listen: false).setEditState(true);
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
                      onTap: () {
                        //TODO 모든 필드가 작성이 되었는지 검사
                        //TODO 작성완료시 작성된 데이터 외에 추가로 저장되어야 하는 값 1.작성일시 2.index값
                        widget.onChange(0); //작성완료 후 메인화면으로 이동
                        //TODO 스낵바 띄우기
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: SizedBox(
                          height: 40,
                          width: deviceWidth * 0.6,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("작성하기", style: TextStyleFamily.buttonTextStyle),
                          ))),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      );
    });
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