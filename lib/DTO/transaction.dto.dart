class TransactionDTO {
  String? name;
  int? amount;
  String? budgetid;

  TransactionDTO({
    this.name,
    this.amount,
    this.budgetid,
  });

  Map<String, dynamic> toJson() {
    return {"name": name, "amount": amount, "budget_id": budgetid};
  }
}
