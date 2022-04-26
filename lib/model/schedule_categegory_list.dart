class ScheduleCategoryList {
  int? rowId;
  int? userType;
  String? category;

  ScheduleCategoryList({this.rowId, this.userType, this.category});


  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['user_type'] = this.userType;
    data['category'] = this.category;
    return data;
  }
}