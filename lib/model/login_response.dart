class LoginUserRespo {
  Response? response;

  LoginUserRespo({this.response});

  LoginUserRespo.fromJson(Map<String, dynamic> json) {
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
  String? token;
  int? role;
  String? firstName;
  String? lastName;
  String? employeeNo;
  int? hourlyRate;
  String? userType;
  int? userTypeId;
  String? profileSrc;

  Data(
      {this.token,
        this.role,
        this.firstName,
        this.lastName,
        this.employeeNo,
        this.hourlyRate,
        this.userType,
        this.userTypeId,
        this.profileSrc});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    employeeNo = json['employee_no'];
    hourlyRate = json['hourly_rate'];
    userType = json['user_type'];
    userTypeId = json['user_type_id'];
    profileSrc = json['profile_src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['role'] = this.role;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['employee_no'] = this.employeeNo;
    data['hourly_rate'] = this.hourlyRate;
    data['user_type'] = this.userType;
    data['user_type_id'] = this.userTypeId;
    data['profile_src'] = this.profileSrc;
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

