class VisaTypeList {
  int? rowId;
  String? type;

  VisaTypeList({required this.rowId, required this.type});

  VisaTypeList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    type = json['type'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row_id'] = this.rowId;
    data['type'] = this.type;
    return data;
  }
}
