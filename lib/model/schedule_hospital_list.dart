class HospitalList {
  int? rowId;
  String? name;
  String? email;
  String? phone;
  String? address;
  int? province;
  int? city;
  String? longitude;
  String? latitude;
  String? photo;

  HospitalList(
      {this.rowId,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.province,
        this.city,
        this.longitude,
        this.latitude,
        this.photo});



  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['province'] = this.province;
    data['city'] = this.city;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['photo'] = this.photo;
    return data;
  }
}