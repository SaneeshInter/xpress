class Allowances {
  String? category;
  int? categoryId;
  String? allowance;
  int? allowanceId;
  String? amount;

  Allowances({
    this.category,
    this.categoryId,
    this.allowance,
    this.allowanceId,
    this.amount,
  });

  Allowances.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        categoryId = json['categoryId'],
        allowance = json['allowance'],
        allowanceId = json['allowanceId'],
        amount = json['amount'];

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'categoryId': categoryId,
      'allowance': allowance,
      'allowanceId': allowanceId,
      'amount': amount,
    };
  }
}
