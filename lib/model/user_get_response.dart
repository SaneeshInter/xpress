class UserGetResponse {
  UserResponse? userResponse;

  UserGetResponse({this.userResponse});

  UserGetResponse.fromJson(Map<String, dynamic> json) {
    userResponse = json['Response'] != null
        ? new UserResponse.fromJson(json['Response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userResponse != null) {
      data['Response'] = this.userResponse!.toJson();
    }
    return data;
  }
}

class UserResponse {
  Data? data;
  Status? status;

  UserResponse({this.data, this.status});

  UserResponse.fromJson(Map<String, dynamic> json) {
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
  List<Items>? items;

  Data({this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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

class Items {
  String? firstName;
  String? lastName;
  String? employeeNo;
  int? hourlyRate;
  String? dob;
  String? email;
  String? phoneNumber;
  String? nationality;
  int? nationalityId;
  String? gender;
  int? genderId;
  String? visaType;
  int? visaTypeId;
  String? userType;
  int? userTypeId;
  String? homeAddress;
  String? ppsNumber;
  String? bankIban;
  String? bankBic;

  Items(
      {this.firstName,
        this.lastName,
        this.employeeNo,
        this.hourlyRate,
        this.dob,
        this.email,
        this.phoneNumber,
        this.nationality,
        this.nationalityId,
        this.gender,
        this.genderId,
        this.visaType,
        this.visaTypeId,
        this.userType,
        this.userTypeId,
        this.homeAddress,
        this.ppsNumber,
        this.bankIban,
        this.bankBic});

  Items.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    employeeNo = json['employee_no'];
    hourlyRate = json['hourly_rate'];
    dob = json['dob'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    nationality = json['nationality'];
    nationalityId = json['nationality_id'];
    gender = json['gender'];
    genderId = json['gender_id'];
    visaType = json['visa_type'];
    visaTypeId = json['visa_type_id'];
    userType = json['user_type'];
    userTypeId = json['user_type_id'];
    homeAddress = json['home_address'];
    ppsNumber = json['pps_number'];
    bankIban = json['bank_iban'];
    bankBic = json['bank_bic'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['employee_no'] = this.employeeNo;
    data['hourly_rate'] = this.hourlyRate;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['nationality'] = this.nationality;
    data['nationality_id'] = this.nationalityId;
    data['gender'] = this.gender;
    data['gender_id'] = this.genderId;
    data['visa_type'] = this.visaType;
    data['visa_type_id'] = this.visaTypeId;
    data['user_type'] = this.userType;
    data['user_type_id'] = this.userTypeId;
    data['home_address'] = this.homeAddress;
    data['pps_number'] = this.ppsNumber;
    data['bank_iban'] = this.bankIban;
    data['bank_bic'] = this.bankBic;

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

