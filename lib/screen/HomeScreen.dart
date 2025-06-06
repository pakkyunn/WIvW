import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SearchAnchor(
            isFullScreen: false,
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
                // trailing:
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
          ),
        ),
        SizedBox(height: 16),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset("lib/asset/poster/hidden_face.png"),
                    title: Text('작품명: 히든페이스'),
                    subtitle: Text('감상평: 갇혔다 지켜봤다 벗겨졌다, 지휘자 성진(송승헌)이 이끄는 오케스트라의 첼리스트이자 약혼녀 수연(조여정)이 어느 날 영상 편지만을 남겨둔 채 자취를 감춘다.'),
                  ),
                  Divider(height: 0.5),
                  ListTile(
                    leading: Image.asset("lib/asset/poster/heart_pairing.png"),
                    title: Text('작품명: 하트페어링'),
                    subtitle: Text('감상평: 연애는 설렘에서 시작된다. 그렇다면 연애가 결혼이 되려면?! 결혼을 꿈꾸는 청춘남녀들이 한 집에 모였다. 이들은 한 달간 이탈리아와 서울을 오가며 운명적 페어링을 통해 자신만의 평생 짝을 찾아간다.'),
                  ),
                  Divider(height: 0.5),
                  ListTile(
                    leading: Image.asset("lib/asset/poster/black_mirror.png"),
                    title: Text('작품명: 블랙미러'),
                    subtitle: Text('미디어와 정보기술의 발달이 인간의 윤리관을 앞서나갔을 때의 부정적인 면을 다룬다. 흔히 미디어는 시대를 비추는 거울이란 표현으로 많이 쓰이는데, 검은 거울이란 전자기기를 껐을 때 검은 화면에 보고 있던 사람 본인의 얼굴이 비친다는 점에서 따왔으며, 드라마의 주제를 잘 함축한 제목이다.'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}