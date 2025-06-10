import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../style/color.dart';
import '../style/font.dart';
import '../style/textStyle.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  bool isUploaded = false;
  double _value = 2.5;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    // var deviceHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              color: ColorFamily.deepGreen,
              width: deviceWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 포스터 이미지
                  SizedBox(
                    width: 150,
                    height: 230,
                    child: Card(
                      color: Colors.white,
                      elevation: 1,
                      child: Container(
                        child: isUploaded
                            ? Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'lib/asset/poster/black_mirror.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    // widget.provider.setImage(null);
                                  });
                                },
                                child: SvgPicture.asset(
                                  'lib/icons/write.svg',
                                ),
                              ),
                            ),
                          ],
                        )
                            : IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            // getImage(widget.provider, ImageSource.gallery);
                          },
                          icon: SvgPicture.asset(
                            'lib/icons/write.svg',
                            width: 40,
                            height: 40,
                            colorFilter: const ColorFilter.mode(
                              ColorFamily.gray,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  /// 작품명
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("작품명",
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          cursorColor: ColorFamily.black,
                          autofocus: false,
                          // focusNode: _nickNameFocusNode,
                          maxLength: 10,
                          // initialValue: tempUserNickname,
                          onChanged: (value) {
                            // tempUserNickname = value;
                          },
                          onFieldSubmitted: (value) {
                            // tempUserNickname = value;
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,5,10,5),
                        child: TextFormField(
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
                            // onConfirm: (date) {
                            //   setState(() {
                            //     _selectedDate = date;
                            //     tempUserBirth = dateToString(_selectedDate);
                            //   });
                            //   _nickNameFocusNode.unfocus();
                            //   _profileMessageFocusNode.unfocus();
                            // },
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
                              // style: TextStyleFamily.smallTitleTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  /// 나의 평점
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("나의 평점",
                        // style: TextStyleFamily.normalTextStyle,
                      ),
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
                      enableTooltip: true,
                      thumbShape: MyThumbShape(),
                      thumbIcon: Icon(Icons.favorite, color: Colors.pink), // 하트 아이콘
                      onChanged: (dynamic value){
                        setState(() {
                          _value = value;
                        });
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
                        onTap: () {},
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
          ),
        ),
      ],
    );
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