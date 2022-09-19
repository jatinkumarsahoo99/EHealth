class PatientModel {
  List<PatientListBody> body;
  String message;
  String code;
  String total;

  PatientModel({this.body, this.message, this.code, this.total});

  PatientModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = new List<PatientListBody>();
      json['body'].forEach((v) {
        body.add(new PatientListBody.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['total'] = this.total;
    return data;
  }
}

class PatientListBody {
  String vleId;
  String patientId;
  String testId;
  String testName;
  String status;
  String venderId;
  String venderName;
  String patientName;
  String gender;
  String regDate;
  String enterdby;
  String mob;
  String date;
  String age;
  String getvendertestLists;

  PatientListBody(
      {this.vleId,
        this.patientId,
        this.testId,
        this.testName,
        this.status,
        this.venderId,
        this.venderName,
        this.patientName,
        this.gender,
        this.regDate,
        this.enterdby,
        this.mob,
        this.date,
        this.age,
        this.getvendertestLists});

  PatientListBody.fromJson(Map<String, dynamic> json) {
    vleId = json['vleId'];
    patientId = json['patientId'];
    testId = json['testId'];
    testName = json['testName'];
    status = json['status'];
    venderId = json['venderId'];
    venderName = json['venderName'];
    patientName = json['patientName'];
    gender = json['gender'];
    regDate = json['regDate'];
    enterdby = json['enterdby'];
    mob = json['mob'];
    date = json['date'];
    age = json['age'];
    getvendertestLists = json['getvendertestLists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vleId'] = this.vleId;
    data['patientId'] = this.patientId;
    data['testId'] = this.testId;
    data['testName'] = this.testName;
    data['status'] = this.status;
    data['venderId'] = this.venderId;
    data['venderName'] = this.venderName;
    data['patientName'] = this.patientName;
    data['gender'] = this.gender;
    data['regDate'] = this.regDate;
    data['enterdby'] = this.enterdby;
    data['mob'] = this.mob;
    data['date'] = this.date;
    data['age'] = this.age;
    data['getvendertestLists'] = this.getvendertestLists;
    return data;
  }
}
