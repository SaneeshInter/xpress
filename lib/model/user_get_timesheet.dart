class UserTimeSheetRespo {
  Response? response;

  UserTimeSheetRespo({this.response});

  UserTimeSheetRespo.fromJson(Map<String, dynamic> json) {
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
  List<TimeSheetInfo>? timeSheetInfo;

  Data({this.timeSheetInfo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['time_sheet_info'] != null) {
      timeSheetInfo = <TimeSheetInfo>[];
      json['time_sheet_info'].forEach((v) {
        timeSheetInfo!.add(new TimeSheetInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeSheetInfo != null) {
      data['time_sheet_info'] =
          this.timeSheetInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSheetInfo {
  int? timeSheetId;
  String? firstName;
  String? lastName;
  String? userType;
  String? timeSheetLink;
  String? date;

  TimeSheetInfo(
      {this.timeSheetId,
        this.firstName,
        this.lastName,
        this.userType,
        this.timeSheetLink,
        this.date});

  TimeSheetInfo.fromJson(Map<String, dynamic> json) {
    timeSheetId = json['time_sheet_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userType = json['user_type'];
    timeSheetLink = json['time_sheet_link'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_sheet_id'] = this.timeSheetId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_type'] = this.userType;
    data['time_sheet_link'] = this.timeSheetLink;
    data['date'] = this.date;
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

