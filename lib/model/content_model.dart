class ContentModel {
  final int index;
  final String posterPath;
  final String title;
  final int category;
  final String review;
  final String watchDate;
  final double rating;

  ContentModel(this.index, this.posterPath, this.title, this.category, this.review, this.watchDate, this.rating);

  // 데이터 저장
  Map<String, dynamic> toJson() => {
    'index': index,
    'posterPath': posterPath,
    'subtitle': title,
    'category': category,
    'review': review,
    'date': watchDate,
    'rating': rating,
  };

  // 데이터 불러오기
  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(json['index'], json['posterPath'], json['subtitle'], json['category'], json['review'], json['date'], json['rating']);
  }
}
