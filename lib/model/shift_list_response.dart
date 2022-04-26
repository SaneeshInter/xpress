class SliftListRepso {
  ShiftResponse? response;

  SliftListRepso({this.response});

  SliftListRepso.fromJson(Map<String, dynamic> json) {
    response = json['Response'] != null
        ? new ShiftResponse.fromJson(json['Response'])
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

class ShiftResponse {
  Data? data;
  Status? status;

  ShiftResponse({this.data, this.status});

  ShiftResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class Data {
  List<Category>? category;

  Data({this.category});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? catid;
  String? categoryname;
  String? tagtitle;
  String? categoryimage;

  Category({this.catid, this.categoryname, this.tagtitle, this.categoryimage});

  Category.fromJson(Map<String, dynamic> json) {
    catid = json['catid'];
    categoryname = json['categoryname'];
    tagtitle = json['tagtitle'];
    categoryimage = json['categoryimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catid'] = this.catid;
    data['categoryname'] = this.categoryname;
    data['tagtitle'] = this.tagtitle;
    data['categoryimage'] = this.categoryimage;
    return data;
  }
}

class Status {
  int? count;
  String? statusCode;
  String? statusMessage;

  Status({this.count, this.statusCode, this.statusMessage});

  Status.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    statusCode = json['status_code'].toString();
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
