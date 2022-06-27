class UserGetResponse {
  Response? response;

  UserGetResponse({this.response});

  UserGetResponse.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? employeeNo;
  int? hourlyRate;
  String? dob;
  String? email;
  String? phoneNumber;
  String? nationality;
  int? nationalityId;
  String? gender;
  int? genderId;
  String? visaType;
  String? visaTypeId;
  String? userType;
  int? userTypeId;
  String? homeAddress;
  String? ppsNumber;
  String? bankIban;
  String? bankBic;
  String? profileSrc;
  String? signatureSrc;
  String? phdLink;
  String? phdExpiry;
  String? qqqiLink;
  String? qqqiExpiry;
  String? ipccLink;
  String? ipccExpiry;
  String? ecsLink;
  String? ecsExpiry;
  String? pidLink;
  String? pidExpiry;
  int? permissionToWorkInIreland;
  int? doYouDrive;
  int? haveYouGotCovid19Vaccination;
  int? doYouConsentGardaVettingToBeCompleted;
  int? tuberculosisVaccination;
  int? hepatitisBAntibody;
  String? uniformSize;
  dynamic uniformSizeId;
  dynamic termsAndConditions;
  dynamic uniqueStaffId;
  int? idCardReceived;
  String? location;
  dynamic locationId;

  Items(
      {this.firstName,
        this.lastName,
        this.employeeNo,
        this.hourlyRate,
        this.dob,
        this.email,
        this.phoneNumber,
        this.nationality,
        this.nationalityId,
        this.gender,
        this.genderId,
        this.visaType,
        this.visaTypeId,
        this.userType,
        this.userTypeId,
        this.homeAddress,
        this.ppsNumber,
        this.bankIban,
        this.bankBic,
        this.profileSrc,
        this.signatureSrc,
        this.phdLink,
        this.phdExpiry,
        this.pidLink,
        this.qqqiLink,
        this.qqqiExpiry,
        this.ipccLink,
        this.ipccExpiry,
        this.ecsLink,
        this.ecsExpiry,
        this.pidExpiry,
        this.permissionToWorkInIreland,
        this.doYouDrive,
        this.haveYouGotCovid19Vaccination,
        this.doYouConsentGardaVettingToBeCompleted,
        this.tuberculosisVaccination,
        this.hepatitisBAntibody,
        this.uniformSize,
        this.uniformSizeId,
        this.termsAndConditions,
        this.uniqueStaffId,
        this.idCardReceived,
        this.location,
        this.locationId});

  Items.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    employeeNo = json['employee_no'];
    hourlyRate = json['hourly_rate'];
    dob = json['dob'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    nationality = json['nationality'];
    nationalityId = json['nationality_id'];
    gender = json['gender'];
    genderId = json['gender_id'];
    visaType = json['visa_type'];
    visaTypeId = json['visa_type_id'];
    userType = json['user_type'];
    userTypeId = json['user_type_id'];
    homeAddress = json['home_address'];
    ppsNumber = json['pps_number'];
    bankIban = json['bank_iban'];
    bankBic = json['bank_bic'];
    profileSrc = json['profile_src'];
    signatureSrc = json['signature_src'];
    phdLink = json['phd_link'];
    phdExpiry = json['phd_expiry'];
    qqqiLink = json['qqqi_link'];
    qqqiExpiry = json['qqqi_expiry'];
    ipccLink = json['ipcc_link'];
    ipccExpiry = json['ipcc_expiry'];
    ecsLink = json['ecs_link'];
    ecsExpiry = json['ecs_expiry'];
    pidLink = json['pid_link'];
    pidExpiry = json['pid_expiry'];
    permissionToWorkInIreland = json['permission_to_work_in_ireland'];
    doYouDrive = json['do_you_drive'];
    haveYouGotCovid19Vaccination = json['have_you_got_covid19_vaccination'];
    doYouConsentGardaVettingToBeCompleted =
    json['do_you_consent_garda_vetting_to_be_completed'];
    tuberculosisVaccination = json['tuberculosis_vaccination'];
    hepatitisBAntibody = json['hepatitis_b_antibody'];
    uniformSize = json['uniform_size'];
    uniformSizeId = json['uniform_size_id'];
    termsAndConditions = json['terms_and_conditions'];
    uniqueStaffId = json['unique_staff_id'];
    idCardReceived = json['id_card_received'];
    location = json['location'];
    locationId = json['location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['employee_no'] = this.employeeNo;
    data['hourly_rate'] = this.hourlyRate;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['nationality'] = this.nationality;
    data['nationality_id'] = this.nationalityId;
    data['gender'] = this.gender;
    data['gender_id'] = this.genderId;
    data['visa_type'] = this.visaType;
    data['visa_type_id'] = this.visaTypeId;
    data['user_type'] = this.userType;
    data['user_type_id'] = this.userTypeId;
    data['home_address'] = this.homeAddress;
    data['pps_number'] = this.ppsNumber;
    data['bank_iban'] = this.bankIban;
    data['bank_bic'] = this.bankBic;
    data['profile_src'] = this.profileSrc;
    data['signature_src'] = this.signatureSrc;
    data['phd_link'] = this.phdLink;
    data['phd_expiry'] = this.phdExpiry;
    data['qqqi_link'] = this.qqqiLink;
    data['qqqi_expiry'] = this.qqqiExpiry;
    data['ipcc_link'] = this.ipccLink;
    data['ipcc_expiry'] = this.ipccExpiry;
    data['ecs_link'] = this.ecsLink;
    data['ecs_expiry'] = this.ecsExpiry;
    data['pid_link'] = this.pidLink;
    data['pid_expiry'] = this.pidExpiry;
    data['permission_to_work_in_ireland'] = this.permissionToWorkInIreland;
    data['do_you_drive'] = this.doYouDrive;
    data['have_you_got_covid19_vaccination'] =
        this.haveYouGotCovid19Vaccination;
    data['do_you_consent_garda_vetting_to_be_completed'] =
        this.doYouConsentGardaVettingToBeCompleted;
    data['tuberculosis_vaccination'] = this.tuberculosisVaccination;
    data['hepatitis_b_antibody'] = this.hepatitisBAntibody;
    data['uniform_size'] = this.uniformSize;
    data['uniform_size_id'] = this.uniformSizeId;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['unique_staff_id'] = this.uniqueStaffId;
    data['id_card_received'] = this.idCardReceived;
    data['location'] = this.location;
    data['location_id'] = this.locationId;
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

