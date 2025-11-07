class FeeDetails {
  final String id;
  final String category;
  final double amount;
  final String description;
  final DateTime dueDate;
  final bool isPaid;

  FeeDetails({
    required this.id,
    required this.category,
    required this.amount,
    required this.description,
    required this.dueDate,
    this.isPaid = false,
  });
}

class Payment {
  final String id;
  final String feeId;
  final double amount;
  final DateTime date;
  final String transactionId;
  final String paymentMethod;
  final String status;

  Payment({
    required this.id,
    required this.feeId,
    required this.amount,
    required this.date,
    required this.transactionId,
    required this.paymentMethod,
    required this.status,
  });
}
