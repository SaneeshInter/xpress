import '../viewbooking_response.dart';

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
  List<Allowancess>? allowances;
  String? createdDate;

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
        this.createdDate});

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
      allowances = <Allowancess>[];
      json['allowances'].forEach((v) {
        allowances!.add(new Allowancess.fromJson(v));
      });
    }
    createdDate = json['created_date'];
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
    return data;
  }
}
