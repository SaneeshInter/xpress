class AllowanceList {
  int? rowId;
  int? category;
  String? allowance;
  int? amount;
  int? maxAmount;
  String? comment;

  AllowanceList(
      {this.rowId,
        this.category,
        this.allowance,
        this.amount,
        this.maxAmount,
        this.comment});


  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['category'] = this.category;
    data['allowance'] = this.allowance;
    data['amount'] = this.amount;
    data['max_amount'] = this.maxAmount;
    data['comment'] = this.comment;
    return data;
  }
}