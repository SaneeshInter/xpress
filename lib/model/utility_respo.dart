class UtilityResop {
  Response? response;

  UtilityResop({this.response});

  UtilityResop.fromJson(Map<String, dynamic> json) {
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
  List<GenderList>? genderList;
  List<CountryList>? countryList;
  List<UserTypeList>? userTypeList;
  List<VisaTypeList>? visaTypeList;
  List<LoctionsList>? loctionsList;
  List<AllowanceCategoryList>? allowanceCategoryList;
  List<AllowanceList>? allowanceList;
  List<ScheduleCategoryList>? scheduleCategoryList;
  List<HospitalList>? hospitalList;
  List<ProvincesList>? provincesList;
  List<CityList>? cityList;
  List<ShiftTimingList>? shiftTimingList;
  String? timeZone;

  Data(
      {this.genderList,
        this.countryList,
        this.userTypeList,
        this.visaTypeList,
        this.loctionsList,
        this.allowanceCategoryList,
        this.allowanceList,
        this.scheduleCategoryList,
        this.hospitalList,
        this.provincesList,
        this.cityList,
        this.shiftTimingList,
        this.timeZone});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['gender_list'] != null) {
      genderList = <GenderList>[];
      json['gender_list'].forEach((v) {
        genderList!.add(new GenderList.fromJson(v));
      });
    }
    if (json['country_list'] != null) {
      countryList = <CountryList>[];
      json['country_list'].forEach((v) {
        countryList!.add(new CountryList.fromJson(v));
      });
    }
    if (json['user_type_list'] != null) {
      userTypeList = <UserTypeList>[];
      json['user_type_list'].forEach((v) {
        userTypeList!.add(new UserTypeList.fromJson(v));
      });
    }
    if (json['visa_type_list'] != null) {
      visaTypeList = <VisaTypeList>[];
      json['visa_type_list'].forEach((v) {
        visaTypeList!.add(new VisaTypeList.fromJson(v));
      });
    }
    if (json['loctions_list'] != null) {
      loctionsList = <LoctionsList>[];
      json['loctions_list'].forEach((v) {
        loctionsList!.add(new LoctionsList.fromJson(v));
      });
    }
    if (json['allowance_category_list'] != null) {
      allowanceCategoryList = <AllowanceCategoryList>[];
      json['allowance_category_list'].forEach((v) {
        allowanceCategoryList!.add(new AllowanceCategoryList.fromJson(v));
      });
    }
    if (json['allowance_list'] != null) {
      allowanceList = <AllowanceList>[];
      json['allowance_list'].forEach((v) {
        allowanceList!.add(new AllowanceList.fromJson(v));
      });
    }
    if (json['schedule_category_list'] != null) {
      scheduleCategoryList = <ScheduleCategoryList>[];
      json['schedule_category_list'].forEach((v) {
        scheduleCategoryList!.add(new ScheduleCategoryList.fromJson(v));
      });
    }
    if (json['hospital_list'] != null) {
      hospitalList = <HospitalList>[];
      json['hospital_list'].forEach((v) {
        hospitalList!.add(new HospitalList.fromJson(v));
      });
    }
    if (json['provinces_list'] != null) {
      provincesList = <ProvincesList>[];
      json['provinces_list'].forEach((v) {
        provincesList!.add(new ProvincesList.fromJson(v));
      });
    }
    if (json['city_list'] != null) {
      cityList = <CityList>[];
      json['city_list'].forEach((v) {
        cityList!.add(new CityList.fromJson(v));
      });
    }

    if (json['shift_timing_list'] != null) {
      shiftTimingList = <ShiftTimingList>[];
      json['shift_timing_list'].forEach((v) {
        shiftTimingList!.add(new ShiftTimingList.fromJson(v));
      });
    }
    timeZone = json['time_zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genderList != null) {
      data['gender_list'] = this.genderList!.map((v) => v.toJson()).toList();
    }
    if (this.countryList != null) {
      data['country_list'] = this.countryList!.map((v) => v.toJson()).toList();
    }
    if (this.userTypeList != null) {
      data['user_type_list'] =
          this.userTypeList!.map((v) => v.toJson()).toList();
    }
    if (this.visaTypeList != null) {
      data['visa_type_list'] =
          this.visaTypeList!.map((v) => v.toJson()).toList();
    }
    if (this.loctionsList != null) {
      data['loctions_list'] =
          this.loctionsList!.map((v) => v.toJson()).toList();
    }
    if (this.allowanceCategoryList != null) {
      data['allowance_category_list'] =
          this.allowanceCategoryList!.map((v) => v.toJson()).toList();
    }
    if (this.allowanceList != null) {
      data['allowance_list'] =
          this.allowanceList!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleCategoryList != null) {
      data['schedule_category_list'] =
          this.scheduleCategoryList!.map((v) => v.toJson()).toList();
    }
    if (this.hospitalList != null) {
      data['hospital_list'] =
          this.hospitalList!.map((v) => v.toJson()).toList();
    }
    if (this.provincesList != null) {
      data['provinces_list'] =
          this.provincesList!.map((v) => v.toJson()).toList();
    }
    if (this.cityList != null) {
      data['city_list'] = this.cityList!.map((v) => v.toJson()).toList();
    }
    if (this.shiftTimingList != null) {
      data['shift_timing_list'] =
          this.shiftTimingList!.map((v) => v.toJson()).toList();
    }
    data['time_zone'] = this.timeZone;
    return data;
  }
}

class GenderList {
  int? rowId;
  String? gender;

  GenderList({this.rowId, this.gender});

  GenderList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['gender'] = this.gender;
    return data;
  }
}

class CountryList {
  int? rowId;
  String? countryName;

  CountryList({this.rowId, this.countryName});

  CountryList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['country_name'] = this.countryName;
    return data;
  }
}

class VisaTypeList {
  int? rowId;
  String? type;

  VisaTypeList({required this.rowId, required this.type});

  VisaTypeList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row_id'] = this.rowId;
    data['type'] = this.type;
    return data;
  }
}




class UserTypeList {
  int? rowId;
  String? type;

  UserTypeList({this.rowId, this.type});

  UserTypeList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['type'] = this.type;
    return data;
  }
}

class LoctionsList {
  int? rowId;
  String? location;

  LoctionsList({this.rowId, this.location});

  LoctionsList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['location'] = this.location;
    return data;
  }
}

class AllowanceCategoryList {
  int? rowId;
  String? category;

  AllowanceCategoryList({this.rowId, this.category});

  AllowanceCategoryList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['category'] = this.category;
    return data;
  }
}

class AllowanceList {
  int? rowId;
  int? category;
  String? allowance;
  int? amount;
  int? maxAmount;
  String? comment;

  AllowanceList(
      {this.rowId,
        this.category,
        this.allowance,
        this.amount,
        this.maxAmount,
        this.comment});

  AllowanceList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    category = json['category'];
    allowance = json['allowance'];
    amount = json['amount'];
    maxAmount = json['max_amount'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['category'] = this.category;
    data['allowance'] = this.allowance;
    data['amount'] = this.amount;
    data['max_amount'] = this.maxAmount;
    data['comment'] = this.comment;
    return data;
  }
}

class ScheduleCategoryList {
  int? rowId;
  int? userType;
  String? category;

  ScheduleCategoryList({this.rowId, this.userType, this.category});

  ScheduleCategoryList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    userType = json['user_type'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['user_type'] = this.userType;
    data['category'] = this.category;
    return data;
  }
}

class HospitalList {
  int? rowId;
  String? name;
  String? email;
  String? phone;
  String? address;
  int? province;
  int? city;
  String? longitude;
  String? latitude;
  String? photo;

  HospitalList(
      {this.rowId,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.province,
        this.city,
        this.longitude,
        this.latitude,
        this.photo});

  HospitalList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    province = json['province'];
    city = json['city'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['province'] = this.province;
    data['city'] = this.city;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['photo'] = this.photo;
    return data;
  }
}

class ProvincesList {
  int? rowId;
  String? province;

  ProvincesList({this.rowId, this.province});

  ProvincesList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['province'] = this.province;
    return data;
  }
}

class CityList {
  int? rowId;
  int? province;
  String? city;

  CityList({this.rowId, this.province, this.city});

  CityList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    province = json['province'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['province'] = this.province;
    data['city'] = this.city;
    return data;
  }
}
class ShiftTimingList {
  int? rowId;
  String? shift;
  String? startTime;
  String? endTime;

  ShiftTimingList({this.rowId, this.shift, this.startTime, this.endTime});

  ShiftTimingList.fromJson(Map<String, dynamic> json) {
    rowId = json['row_id'];
    shift = json['shift'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['shift'] = this.shift;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
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

