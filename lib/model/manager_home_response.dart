class ManagerHomeResponse {
  Response? response;

  ManagerHomeResponse({this.response});

  ManagerHomeResponse.fromJson(Map<String, dynamic> json) {
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
  List<ImportantUpdates>? importantUpdates;
  List<Summary>? summary;

  Data({this.importantUpdates, this.summary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['important_updates'] != null) {
      importantUpdates = <ImportantUpdates>[];
      json['important_updates'].forEach((v) {
        importantUpdates!.add(new ImportantUpdates.fromJson(v));
      });
    }
    if (json['summary'] != null) {
      summary = <Summary>[];
      json['summary'].forEach((v) {
        summary!.add(new Summary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.importantUpdates != null) {
      data['important_updates'] =
          this.importantUpdates!.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['summary'] = this.summary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImportantUpdates {
  String? title;
  String? date;
  String? description;

  ImportantUpdates({this.title, this.date, this.description});

  ImportantUpdates.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['description'] = this.description;
    return data;
  }
}

class Summary {
  String? totalShiftCount;
  String? pendingShiftDaily;
  String? pendingShiftWeekly;
  String? pendingShiftMonthly;
  String? approvedShiftDaily;
  String? approvedShiftWeekly;
  String? approvedShiftMonthly;

  Summary(
      {this.totalShiftCount,
        this.pendingShiftDaily,
        this.pendingShiftWeekly,
        this.pendingShiftMonthly,
        this.approvedShiftDaily,
        this.approvedShiftWeekly,
        this.approvedShiftMonthly});

  Summary.fromJson(Map<String, dynamic> json) {
    totalShiftCount = json['total_shift_count'];
    pendingShiftDaily = json['pending_shift_daily'];
    pendingShiftWeekly = json['pending_shift_weekly'];
    pendingShiftMonthly = json['pending_shift_monthly'];
    approvedShiftDaily = json['approved_shift_daily'];
    approvedShiftWeekly = json['approved_shift_weekly'];
    approvedShiftMonthly = json['approved_shift_monthly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_shift_count'] = this.totalShiftCount;
    data['pending_shift_daily'] = this.pendingShiftDaily;
    data['pending_shift_weekly'] = this.pendingShiftWeekly;
    data['pending_shift_monthly'] = this.pendingShiftMonthly;
    data['approved_shift_daily'] = this.approvedShiftDaily;
    data['approved_shift_weekly'] = this.approvedShiftWeekly;
    data['approved_shift_monthly'] = this.approvedShiftMonthly;
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
