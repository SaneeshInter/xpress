class ShiftTimingList {
  int? rowId;
  String? shift;
  String? startTime;
  String? endTime;

  ShiftTimingList({this.rowId, this.shift, this.startTime, this.endTime});


  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_id'] = this.rowId;
    data['shift'] = this.shift;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}