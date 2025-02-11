class Withdrawal {
  final int id;
  final double amount;
  final DateTime date;
  final String component;

  Withdrawal({
    required this.id,
    required this.amount,
    required this.date,
    required this.component,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'component': component,
    };
  }

  factory Withdrawal.fromMap(Map<String, dynamic> map) {
    return Withdrawal(
      id: map['id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      component: map['component'],
    );
  }
}