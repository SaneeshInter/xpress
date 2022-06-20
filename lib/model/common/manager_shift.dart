import '../allowance_model.dart';

class Items {
  int? rowId;
  String? type;
  String? userType;
  int? userTypeId;
  String? category;
  int? categoryId;
  String? jobTitle;
  String? hospital;
  int? hospitalId;
  String? date;
  String? unitName;
  int? unitNameId;
  int? shiftTypeId;
  String? shiftType;
  String? timeFrom;
  String? timeTo;
  String? jobDetails;
  int? price;
  List<Allowances>? allowances;
  String? createdDate;
  String? requested_count;
  String? poCode;

  Items(
      {this.rowId,
        this.type,
        this.userType,
        this.userTypeId,
        this.category,
        this.categoryId,
        this.jobTitle,
        this.hospital,
        this.hospitalId,
        this.date,
        this.unitName,
        this.unitNameId,
        this.shiftTypeId,
        this.shiftType,
        this.timeFrom,
        this.timeTo,
        this.jobDetails,
        this.price,
        this.allowances,
        this.createdDate,
        this.requested_count,
        this.poCode,
      });

  Items.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    type = json['type'];
    userType = json['user_type'];
    userTypeId = json['user_type_id'];
    category = json['category'];
    categoryId = json['category_id'];
    jobTitle = json['job_title'];
    hospital = json['hospital'];
    hospitalId = json['hospital_id'];
    date = json['date'];
    unitName = json['unit_name'];
    unitNameId = json['unit_name_id'];
    shiftTypeId = json['shift_type_id'];
    shiftType = json['shift_type'];
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
    requested_count = json['requested_count'];
    poCode = json['po_code'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['type'] = this.type;
    data['user_type'] = this.userType;
    data['user_type_id'] = this.userTypeId;
    data['category'] = this.category;
    data['category_id'] = this.categoryId;
    data['job_title'] = this.jobTitle;
    data['hospital'] = this.hospital;
    data['hospital_id'] = this.hospitalId;
    data['date'] = this.date;
    data['unit_name'] = this.unitName;
    data['unit_name_id'] = this.unitNameId;
    data['shift_type_id'] = this.shiftTypeId;
    data['shift_type'] = this.shiftType;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['job_details'] = this.jobDetails;
    data['price'] = this.price;
    if (this.allowances != null) {
      data['allowances'] = this.allowances!.map((v) => v.toJson()).toList();
    }
    data['created_date'] = this.createdDate;
    data['requested_count'] = this.requested_count;
    data['po_code'] = this.poCode;
    return data;
  }
}
