  enum CategoryType {
    /// 0은 전체
  Entertainment(1, "예능"),
  Romance(2, "로맨스"),
  Thriller(3, "스릴러"),
  SF(4, "SF"),
  Action(5, "액션"),
  Horror(6, "공포"),
  Mistery(7, "추리"),
  Music(8, "음악"),
  Survival(9, "서바이벌"),
  Animation(10, "애니메이션"),
  Comedy(11, "코미디"),
  Documentary(12, "다큐멘터리");


  const CategoryType(this.number, this.name);
  final int number;
  final String name;

  static int? getNumberByName(String name) {
    for (final e in CategoryType.values) {
      if (e.name == name) return e.number;
    }
    return null;
  }

  static String? getNameByNumber(int number) {
    for (final e in CategoryType.values) {
      if (e.number == number) return e.name;
    }
    return null;
  }
}
