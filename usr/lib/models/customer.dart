class Customer {
  final String id;
  final String name;
  final String phone;
  final String address;
  double balance; // Positive means they owe money, Negative means they overpaid (credit)

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.address = '',
    this.balance = 0.0,
  });
}
