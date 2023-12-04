class GetdataModal {
  String? message;
  bool? success;
  int? code;
  Data? data;

  GetdataModal({this.message, this.success, this.code, this.data});

  GetdataModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? today;
  int? monthly;
  int? total;

  Data({this.today, this.monthly, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    today = json['today'];
    monthly = json['monthly'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today'] = this.today;
    data['monthly'] = this.monthly;
    data['total'] = this.total;
    return data;
  }
}
