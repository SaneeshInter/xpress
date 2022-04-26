class ShiftTypeList {
  final int? rowId;
  final String? type;

  ShiftTypeList({required this.rowId, required this.type});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row_id'] = this.rowId;
    data['type'] = this.type;
    return data;
  }
}

