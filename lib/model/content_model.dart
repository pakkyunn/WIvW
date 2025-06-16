class ContentModel {
  final int index;
  final DateTime createdAt;
  final String posterPath;
  final String subtitle;
  final int category;
  final String review;
  final String date;
  final double rating;

  ContentModel(this.index, this.createdAt, this.posterPath, this.subtitle, this.category, this.review, this.date, this.rating);

  // 데이터 저장
  Map<String, dynamic> toJson() => {
    'index': index,
    'createdAt': createdAt.toIso8601String(),
    'posterPath': posterPath,
    'subtitle': subtitle,
    'category': category,
    'review': review,
    'date': date,
    'rating': rating,
  };

  // 데이터 불러오기
  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(json['index'], DateTime.parse(json['createdAt']), json['posterPath'], json['subtitle'], json['category'], json['review'], json['date'], json['rating']);
  }
}
