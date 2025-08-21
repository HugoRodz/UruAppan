class BannerModel {
  String id;
  String title;
  String imageUrl;
  String targetUrl;
  bool premium;

  BannerModel({
    this.id = '',
    this.title = '',
    this.imageUrl = '',
    this.targetUrl = '',
    this.premium = false,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'imageUrl': imageUrl,
        'targetUrl': targetUrl,
        'premium': premium,
      };

  factory BannerModel.fromMap(String id, Map<String, dynamic> map) {
    return BannerModel(
      id: id,
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      targetUrl: map['targetUrl'] ?? '',
      premium: map['premium'] ?? false,
    );
  }
}
