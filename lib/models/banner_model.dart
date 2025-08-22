class BannerModel {
  String id;
  String title;
  String imageUrl;
  String targetUrl;
  bool premium;
  String planId;
  String planName;

  BannerModel({
    this.id = '',
    this.title = '',
    this.imageUrl = '',
    this.targetUrl = '',
    this.premium = false,
  this.planId = '',
  this.planName = '',
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'imageUrl': imageUrl,
        'targetUrl': targetUrl,
        'premium': premium,
    'planId': planId,
    'planName': planName,
      };

  factory BannerModel.fromMap(String id, Map<String, dynamic> map) {
    return BannerModel(
      id: id,
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      targetUrl: map['targetUrl'] ?? '',
      premium: map['premium'] ?? false,
  planId: map['planId'] ?? '',
  planName: map['planName'] ?? '',
    );
  }
}
