class LoctionsList {
  final int? rowId;
 final String? location;
  LoctionsList({required this.rowId, required this.location});
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row_id'] = this.rowId;
    data['location'] = this.location;
    return data;
  }
}