class Transaction {
  String content;
  double amount;
  DateTime createdDate;

  Transaction(
      {required this.content, required this.amount, required this.createdDate});

  @override
  String toString() {
    return 'content:$content,amount:$amount';
  }
}
