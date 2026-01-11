enum TransactionType {
  sale,    // Adding debt (Customer bought something)
  payment, // Reducing debt (Customer paid)
}

class TransactionModel {
  final String id;
  final String customerId;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String? note;

  TransactionModel({
    required this.id,
    required this.customerId,
    required this.amount,
    required this.type,
    required this.date,
    this.note,
  });
}
