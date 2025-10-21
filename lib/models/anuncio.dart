import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio {
	final String id;
	final String title;
	final String content;
	final DateTime createdAt;

	Anuncio({this.id = '', required this.title, required this.content, DateTime? createdAt})
			: createdAt = createdAt ?? DateTime.now();

	Map<String, dynamic> toMap() => {
				'title': title,
				'content': content,
				// store as Firestore Timestamp for consistency with repository
				'createdAt': Timestamp.fromDate(createdAt),
			};

	factory Anuncio.fromMap(String id, Map<String, dynamic> map) {
		final ca = map['createdAt'];
		DateTime created;
		if (ca is Timestamp) {
			created = ca.toDate();
		} else if (ca is DateTime) {
			created = ca;
		} else if (ca is int) {
			created = DateTime.fromMillisecondsSinceEpoch(ca);
		} else {
			created = DateTime.now();
		}
		return Anuncio(
			id: id,
			title: map['title'] as String? ?? '',
			content: map['content'] as String? ?? '',
			createdAt: created,
		);
	}
}

