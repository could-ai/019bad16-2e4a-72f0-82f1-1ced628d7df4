import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../models/transaction_model.dart';

class MockDataService extends ChangeNotifier {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal() {
    _seedData();
  }

  final List<Customer> _customers = [];
  final List<TransactionModel> _transactions = [];

  List<Customer> get customers => List.unmodifiable(_customers);
  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  void _seedData() {
    _customers.add(Customer(id: '1', name: 'أحمد محمد', phone: '0501234567', balance: 1500.0));
    _customers.add(Customer(id: '2', name: 'بقالة السعادة', phone: '0559876543', balance: -200.0));
    _customers.add(Customer(id: '3', name: 'شركة النور', phone: '0541122334', balance: 5000.0));

    _transactions.add(TransactionModel(
      id: 't1',
      customerId: '1',
      amount: 2000.0,
      type: TransactionType.sale,
      date: DateTime.now().subtract(const Duration(days: 5)),
      note: 'فاتورة رقم 101',
    ));
    _transactions.add(TransactionModel(
      id: 't2',
      customerId: '1',
      amount: 500.0,
      type: TransactionType.payment,
      date: DateTime.now().subtract(const Duration(days: 2)),
      note: 'دفعة نقدية',
    ));
  }

  void addCustomer(Customer customer) {
    _customers.add(customer);
    notifyListeners();
  }

  void addTransaction(TransactionModel transaction) {
    _transactions.add(transaction);
    
    // Update customer balance
    final customerIndex = _customers.indexWhere((c) => c.id == transaction.customerId);
    if (customerIndex != -1) {
      if (transaction.type == TransactionType.sale) {
        _customers[customerIndex].balance += transaction.amount;
      } else {
        _customers[customerIndex].balance -= transaction.amount;
      }
    }
    notifyListeners();
  }

  List<TransactionModel> getTransactionsForCustomer(String customerId) {
    return _transactions.where((t) => t.customerId == customerId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
  
  double getTotalReceivables() {
    return _customers.fold(0.0, (sum, customer) => sum + (customer.balance > 0 ? customer.balance : 0));
  }
}
