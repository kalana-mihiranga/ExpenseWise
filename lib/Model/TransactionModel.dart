class TransactionModel {
  final int? id; // Use int? to allow null for new transactions
  final String name;
  final String place;
  final String totalAmount;
  final String date;
  final String icon;
  final String color;

  TransactionModel({
    this.id,
    required this.name,
    required this.place,
    required this.totalAmount,
    required this.date,
    required this.icon,
    required this.color,
  });

  // Convert a TransactionModel instance into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'place': place,
      'totalAmount': totalAmount,
      'date': date,
      'icon': icon,
      'color': color,
    };
  }

  // Create a TransactionModel instance from a Map object
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      name: map['name'],
      place: map['place'],
      totalAmount: map['totalAmount'],
      date: map['date'],
      icon: map['icon'],
      color: map['color'],
    );
  }

  // Method to create a copy of the transaction with optional new values
  TransactionModel copyWith({
    int? id,
    String? name,
    String? place,
    String? totalAmount,
    String? date,
    String? icon,
    String? color,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      place: place ?? this.place,
      totalAmount: totalAmount ?? this.totalAmount,
      date: date ?? this.date,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}
