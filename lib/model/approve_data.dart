class ApproveData {
  String? scheduleId;
  String? timesheetId;
  String? status;
  String? comment;

  ApproveData({this.scheduleId, this.timesheetId, this.status, this.comment});

  ApproveData.fromJson(Map<String, dynamic> json) {
    scheduleId = json['schedule_id'];
    timesheetId = json['timesheet_id'];
    status = json['status'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schedule_id'] = this.scheduleId;
    data['timesheet_id'] = this.timesheetId;
    data['status'] = this.status;
    data['comment'] = this.comment;
    return data;
  }
}
