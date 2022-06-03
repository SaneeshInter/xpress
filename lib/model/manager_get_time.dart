class ManagerTimeDetailsResponse {
  Response? response;

  ManagerTimeDetailsResponse({this.response});

  ManagerTimeDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  List<TimeSheetDetails>? timeSheetDetails;

  Data({this.timeSheetDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['time_sheet_details'] != null) {
      timeSheetDetails = <TimeSheetDetails>[];
      json['time_sheet_details'].forEach((v) {
        timeSheetDetails!.add(new TimeSheetDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeSheetDetails != null) {
      data['time_sheet_details'] =
          this.timeSheetDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSheetDetails {
  int? rowId;
  String? firstName;
  String? lastName;
  String? userType;
  int? shiftRowId;
  String? type;
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
  String? time_sheet_detail_status;
  String? time_sheet_detail_comment;

  TimeSheetDetails(
      {this.rowId,
        this.firstName,
        this.lastName,
        this.userType,
        this.shiftRowId,
        this.type,
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
        this.time_sheet_detail_status,
        this.time_sheet_detail_comment,
        this.createdDate});

  TimeSheetDetails.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userType = json['user_type'];
    shiftRowId = json['shift_row_id'];
    type = json['type'];
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
    time_sheet_detail_status = json['time_sheet_detail_status'];
    price = json['price'];
    if (json['allowances'] != null) {
      allowances = <Allowances>[];
      json['allowances'].forEach((v) {
        allowances!.add(new Allowances.fromJson(v));
      });
    }
    createdDate = json['created_date'];
    time_sheet_detail_comment = json['time_sheet_detail_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_type'] = this.userType;
    data['shift_row_id'] = this.shiftRowId;
    data['type'] = this.type;
    data['user_type_id'] = this.userTypeId;
    data['category'] = this.category;
    data['category_id'] = this.categoryId;
    data['job_title'] = this.jobTitle;
    data['hospital'] = this.hospital;
    data['hospital_id'] = this.hospitalId;
    data['date'] = this.date;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['time_sheet_detail_status'] = this.time_sheet_detail_status;
    data['job_details'] = this.jobDetails;
    data['price'] = this.price;
    if (this.allowances != null) {
      data['allowances'] = this.allowances!.map((v) => v.toJson()).toList();
    }
    data['created_date'] = this.createdDate;
    data['time_sheet_detail_comment'] = this.time_sheet_detail_comment;
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

