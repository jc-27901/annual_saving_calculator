class Savings {
  final int id;
  final double amount;
  final DateTime date;
  final double compA;
  final double compB;

  Savings({
    required this.id,
    required this.amount,
    required this.date,
    required this.compA,
    required this.compB,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'compA': compA,
      'compB': compB,
    };
  }

  factory Savings.fromMap(Map<String, dynamic> map) {
    return Savings(
      id: map['id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      compA: map['compA'],
      compB: map['compB'],
    );
  }
}