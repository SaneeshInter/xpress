class AllowanceCategoryList {
  int? rowId;
  String? category;

  AllowanceCategoryList({this.rowId, this.category});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['category'] = this.category;
    return data;
  }
}