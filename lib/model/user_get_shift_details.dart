class GetUserShiftDetailsResponse {
  Response? response;

  GetUserShiftDetailsResponse({this.response});

  GetUserShiftDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  List<ShiftDetails>? shiftDetails;
  List<HospitalDetails>? hospitalDetails;

  Data({this.shiftDetails, this.hospitalDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['shift_details'] != null) {
      shiftDetails = <ShiftDetails>[];
      json['shift_details'].forEach((v) {
        shiftDetails!.add(new ShiftDetails.fromJson(v));
      });
    }
    if (json['hospital_details'] != null) {
      hospitalDetails = <HospitalDetails>[];
      json['hospital_details'].forEach((v) {
        hospitalDetails!.add(new HospitalDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shiftDetails != null) {
      data['shift_details'] =
          this.shiftDetails!.map((v) => v.toJson()).toList();
    }
    if (this.hospitalDetails != null) {
      data['hospital_details'] =
          this.hospitalDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShiftDetails {
  int? shiftRowId;
  String? type;
  String? userType;
  int? userTypeId;
  String? category;
  int? categoryId;
  String? jobTitle;
  String? hospital;
  int? hospitalId;
  String? date;
  String? timeFrom;
  String? timeTo;
  String? jobDetails;
  int? price;
  List<Allowances>? allowances;
  String? createdDate;

  ShiftDetails(
      {this.shiftRowId,
        this.type,
        this.userType,
        this.userTypeId,
        this.category,
        this.categoryId,
        this.jobTitle,
        this.hospital,
        this.hospitalId,
        this.date,
        this.timeFrom,
        this.timeTo,
        this.jobDetails,
        this.price,
        this.allowances,
        this.createdDate});

  ShiftDetails.fromJson(Map<String, dynamic> json) {
    shiftRowId = json['shift_row_id'];
    type = json['type'];
    userType = json['user_type'];
    userTypeId = json['user_type_id'];
    category = json['category'];
    categoryId = json['category_id'];
    jobTitle = json['job_title'];
    hospital = json['hospital'];
    hospitalId = json['hospital_id'];
    date = json['date'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    jobDetails = json['job_details'];
    price = json['price'];
    if (json['allowances'] != null) {
      allowances = <Allowances>[];
      json['allowances'].forEach((v) {
        allowances!.add(new Allowances.fromJson(v));
      });
    }
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shift_row_id'] = this.shiftRowId;
    data['type'] = this.type;
    data['user_type'] = this.userType;
    data['user_type_id'] = this.userTypeId;
    data['category'] = this.category;
    data['category_id'] = this.categoryId;
    data['job_title'] = this.jobTitle;
    data['hospital'] = this.hospital;
    data['hospital_id'] = this.hospitalId;
    data['date'] = this.date;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['job_details'] = this.jobDetails;
    data['price'] = this.price;
    if (this.allowances != null) {
      data['allowances'] = this.allowances!.map((v) => v.toJson()).toList();
    }
    data['created_date'] = this.createdDate;
    return data;
  }
}

class Allowances {
  String? category;
  String? allowance;
  String? price;

  Allowances({this.category, this.allowance, this.price});

  Allowances.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    allowance = json['allowance'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['allowance'] = this.allowance;
    data['price'] = this.price;
    return data;
  }
}

class HospitalDetails {
  int? hospitalRowId;
  String? hospitalName;
  String? email;
  String? address;
  String? phone;
  String? province;
  String? longitude;
  String? latitude;
  String? photo;

  HospitalDetails(
      {this.hospitalRowId,
        this.hospitalName,
        this.email,
        this.address,
        this.phone,
        this.province,
        this.longitude,
        this.latitude,
        this.photo});

  HospitalDetails.fromJson(Map<String, dynamic> json) {
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

