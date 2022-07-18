class UserNotificationModel {
  Response? response;

  UserNotificationModel({this.response});

  UserNotificationModel.fromJson(Map<String, dynamic> json) {
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
  int? rowId;
  int? notificationType;
  String? notificationTypeName;
  int? userId;
  String? userName;
  int? managerId;
  String? managerName;
  int? shiftId;
  String? shiftTitle;
  String? hospitalImage;
  String? date;

  Items(
      {this.rowId,
        this.notificationType,
        this.notificationTypeName,
        this.userId,
        this.userName,
        this.managerId,
        this.managerName,
        this.shiftId,
        this.shiftTitle,
        this.hospitalImage,
        this.date
      });

  Items.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    notificationType = json['notification_type'];
    notificationTypeName = json['notification_type_name'];
    userId = json['user_id'];
    userName = json['user_name'];
    managerId = json['manager_id'];
    managerName = json['manager_name'];
    shiftId = json['shift_id'];
    shiftTitle = json['shift_title'];
    hospitalImage = json['hospital_image'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['notification_type'] = this.notificationType;
    data['notification_type_name'] = this.notificationTypeName;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['manager_id'] = this.managerId;
    data['manager_name'] = this.managerName;
    data['shift_id'] = this.shiftId;
    data['shift_title'] = this.shiftTitle;
    data['hospital_image'] = this.hospitalImage;
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
