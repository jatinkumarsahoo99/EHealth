import 'AyuRythmPostModel.dart';

class AyuRythmDataModel {
  List<Kriya> yogasana;
  List<Kriya> pranayama;
  List<Kriya> meditation;
  List<Kriya> mudra;
  List<Kriya> kriya;
  List<FoodTypes> foodTypes;
  List<Herbs> herbs;
  SparshnaMaster sparshnaMaster;
  List<SparshnaResultDesc> sparshnaResultDesc;
  String type;

  AyuRythmDataModel({this.yogasana, this.pranayama, this.meditation, this.mudra, this.kriya, this.foodTypes, this.sparshnaMaster, this.sparshnaResultDesc, this.type});

  AyuRythmDataModel.fromJson(Map<String, dynamic> json) {
    if (json['yogasana'] != null) {
      yogasana = new List<Kriya>();
      json['yogasana'].forEach((v) { yogasana.add(new Kriya.fromJson(v)); });
    }
    if (json['pranayama'] != null) {
      pranayama = new List<Kriya>();
      json['pranayama'].forEach((v) { pranayama.add(new Kriya.fromJson(v)); });
    }
    if (json['meditation'] != null) {
      meditation = new List<Kriya>();
      json['meditation'].forEach((v) { meditation.add(new Kriya.fromJson(v)); });
    }
    if (json['mudra'] != null) {
      mudra = new List<Kriya>();
      json['mudra'].forEach((v) { mudra.add(new Kriya.fromJson(v)); });
    }
    if (json['kriya'] != null) {
      kriya = new List<Kriya>();
      json['kriya'].forEach((v) { kriya.add(new Kriya.fromJson(v)); });
    }
    if (json['food_types'] != null) {
      foodTypes = new List<FoodTypes>();
      json['food_types'].forEach((v) { foodTypes.add(new FoodTypes.fromJson(v)); });
    }
    sparshnaMaster = json['sparshna_master'] != null ? new SparshnaMaster.fromJson(json['sparshna_master']) : null;
    if (json['sparshna_result_desc'] != null) {
      sparshnaResultDesc = new List<SparshnaResultDesc>();
      json['sparshna_result_desc'].forEach((v) { sparshnaResultDesc.add(new SparshnaResultDesc.fromJson(v)); });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.yogasana != null) {
      data['yogasana'] = this.yogasana.map((v) => v.toJson()).toList();
    }
    if (this.pranayama != null) {
      data['pranayama'] = this.pranayama.map((v) => v.toJson()).toList();
    }
    if (this.meditation != null) {
      data['meditation'] = this.meditation.map((v) => v.toJson()).toList();
    }
    if (this.mudra != null) {
      data['mudra'] = this.mudra.map((v) => v.toJson()).toList();
    }
    if (this.kriya != null) {
      data['kriya'] = this.kriya.map((v) => v.toJson()).toList();
    }
    if (this.foodTypes != null) {
      data['food_types'] = this.foodTypes.map((v) => v.toJson()).toList();
    }
    if (this.sparshnaMaster != null) {
      data['sparshna_master'] = this.sparshnaMaster.toJson();
    }
    if (this.sparshnaResultDesc != null) {
      data['sparshna_result_desc'] = this.sparshnaResultDesc.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Yogasana {
  String type;
  String name;
  String shortdescription;
  String steps;
  String benefitDescription;
  String precautions;

  Yogasana({this.type, this.name, this.shortdescription, this.steps, this.benefitDescription, this.precautions});

  Yogasana.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    shortdescription =
    json['shortdescription'];
    print("shortdescription>>>>>>>"+json['shortdescription']);
    steps = json['steps'];
    benefitDescription = json['benefit_description'];
    precautions = json['precautions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type.replaceAll("\"", "");
    data['name'] = this.name.replaceAll("\"", "");
    data['shortdescription'] =
        this.shortdescription.replaceAll("\"", "");
    data['steps'] = this.steps.replaceAll("\"", "");
    data['benefit_description'] = this.benefitDescription.replaceAll("\"", "");
    data['precautions'] = this.precautions.replaceAll("\"", "");
    return data;
  }
}




