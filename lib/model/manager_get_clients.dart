class ManagerGetClientsResponse {
  Response? response;

  ManagerGetClientsResponse({this.response});

  ManagerGetClientsResponse.fromJson(Map<String, dynamic> json) {
    response = json['Response'] != null
        ? new Response.fromJson(json['Response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  Data? data;
  Status? status;

  Response({this.data, this.status});

  Response.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class Data {
  List<HospitalListItem>? items;

  Data({this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <HospitalListItem>[];
      json['items'].forEach((v) {
        items!.add(new HospitalListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HospitalListItem {
  int? hospitalRowId;
  String? hospitalName;
  String? email;
  String? address;
  String? phone;
  String? province;
  String? longitude;
  String? latitude;
  String? photo;

  HospitalListItem(
      {this.hospitalRowId,
        this.hospitalName,
        this.email,
        this.address,
        this.phone,
        this.province,
        this.longitude,
        this.latitude,
        this.photo});

  HospitalListItem.fromJson(Map<String, dynamic> json) {
    hospitalRowId = json['hospital_row_id'];
    hospitalName = json['hospital_name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    province = json['province'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_row_id'] = this.hospitalRowId;
    data['hospital_name'] = this.hospitalName;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['province'] = this.province;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['photo'] = this.photo;
    return data;
  }
}

class Status {
  int? count;
  int? statusCode;
  String? statusMessage;

  Status({this.count, this.statusCode, this.statusMessage});

  Status.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    return data;
  }
}

