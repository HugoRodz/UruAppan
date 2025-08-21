class Anuncio {
  String id;
  String title;
  String content;
  String authorId;
  DateTime createdAt;

  Anuncio({
    this.id = '',
    this.title = '',
    this.content = '',
    this.authorId = '',
    DateTime? createdAt,
  }) : this.createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'title': title,
        'content': content,
        'authorId': authorId,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Anuncio.fromMap(String id, Map<String, dynamic> map) {
    return Anuncio(
      id: id,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      authorId: map['authorId'] ?? '',
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
    );
  }
}
