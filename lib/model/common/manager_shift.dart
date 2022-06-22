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
    categoryId = -3;
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
    if (json['price'] != null) {
      price = json['price'];

    }
    if (json['po_code'] != null) {
      poCode = json['po_code'];

    }
    if (json['allowances'] != null) {
      allowances = <Allowances>[];
      json['allowances'].forEach((v) {
        allowances!.add( Allowances.fromJson(v));
      });
    }
    createdDate = json['created_date'];
    requested_count = json['requested_count'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['row_id'] = rowId;
    data['type'] = type;
    data['user_type'] = userType;
    data['user_type_id'] = userTypeId;
    data['category'] = category;
    data['category_id'] = categoryId;
    data['job_title'] = jobTitle;
    data['hospital'] = hospital;
    data['hospital_id'] = hospitalId;
    data['date'] = date;
    data['unit_name'] = unitName;
    data['unit_name_id'] = unitNameId;
    data['shift_type_id'] = shiftTypeId;
    data['shift_type'] = shiftType;
    data['time_from'] = timeFrom;
    data['time_to'] = timeTo;
    data['job_details'] = jobDetails;
    if (price != null) {
      data['price'] = price;
    }
    if (poCode != null) {
      data['po_code'] = poCode;
    }

    if (allowances != null) {
      data['allowances'] = allowances!.map((v) => v.toJson()).toList();
    }
    data['created_date'] = createdDate;
    data['requested_count'] = requested_count;

    return data;
  }
}
