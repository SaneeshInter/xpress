class CountryList {
  final int? rowId;
  final String? countryName;

  CountryList({required this.rowId, required this.countryName});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row_id'] = this.rowId;
    data['country_name'] = this.countryName;
    return data;
  }
}
