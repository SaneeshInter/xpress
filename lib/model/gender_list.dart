class GenderList {
  final int? rowId;
  final String? gender;

  GenderList({required this.rowId, required this.gender});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row_id'] = this.rowId;
    data['gender'] = this.gender;
    return data;
  }
}

