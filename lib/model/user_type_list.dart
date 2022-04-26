class UserTypeList {
  int? rowId;
  String? type;

  UserTypeList({required this.rowId, required this.type});

  UserTypeList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    type = json['type'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['type'] = this.type;
    return data;
  }
}
