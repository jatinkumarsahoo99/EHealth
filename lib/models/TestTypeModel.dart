class TestTypeModel {
  List<Body> body;
  String message;
  String code;
  String total;

  TestTypeModel({this.body, this.message, this.code, this.total});

  TestTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = new List<Body>();
      json['body'].forEach((v) {
        body.add(new Body.fromJson(v));
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

class Body {
  String vleId;
  String patientId;
  String testId;
  String testName;
  String status;
  String venderId;
  String venderName;
  List<GetvendertestLists> getvendertestLists;

  Body(
      {this.vleId,
        this.patientId,
        this.testId,
        this.testName,
        this.status,
        this.venderId,
        this.venderName,
        this.getvendertestLists});

  Body.fromJson(Map<String, dynamic> json) {
    vleId = json['vleId'];
    patientId = json['patientId'];
    testId = json['testId'];
    testName = json['testName'];
    status = json['status'];
    venderId = json['venderId'];
    venderName = json['venderName'];
    if (json['getvendertestLists'] != null) {
      getvendertestLists = new List<GetvendertestLists>();
      json['getvendertestLists'].forEach((v) {
        getvendertestLists.add(new GetvendertestLists.fromJson(v));
      });
    }
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
    if (this.getvendertestLists != null) {
      data['getvendertestLists'] =
          this.getvendertestLists.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetvendertestLists {
  String vleId;
  String patientId;
  String testId;
  String testName;
  String status;
  String venderId;
  String venderName;

  GetvendertestLists(
      {this.vleId,
        this.patientId,
        this.testId,
        this.testName,
        this.status,
        this.venderId,
        this.venderName});

  GetvendertestLists.fromJson(Map<String, dynamic> json) {
    vleId = json['vleId'];
    patientId = json['patientId'];
    testId = json['testId'];
    testName = json['testName'];
    status = json['status'];
    venderId = json['venderId'];
    venderName = json['venderName'];
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
    return data;
  }
}
