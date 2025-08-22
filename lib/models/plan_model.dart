class PlanModel {
  String id;
  String name;
  String description;
  double pricePerMonth;
  int durationDays; // how long the banner runs

  PlanModel({
    this.id = '',
    required this.name,
    this.description = '',
    this.pricePerMonth = 0.0,
    this.durationDays = 30,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'pricePerMonth': pricePerMonth,
        'durationDays': durationDays,
      };

  factory PlanModel.fromMap(String id, Map<String, dynamic> map) {
    return PlanModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pricePerMonth: (map['pricePerMonth'] ?? 0).toDouble(),
      durationDays: map['durationDays'] ?? 30,
    );
  }
}
