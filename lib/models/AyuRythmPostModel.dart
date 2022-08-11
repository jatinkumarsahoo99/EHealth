import 'package:flutter/cupertino.dart';

class AyuRythmPostModel {
  Data data;
  Sparshna sparshna;
  Vikriti vikriti;
  Vikriti prakriti;

  AyuRythmPostModel({this.data, this.sparshna, this.vikriti, this.prakriti});

  AyuRythmPostModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    sparshna = json['Sparshna'] != null
        ? new Sparshna.fromJson(json['Sparshna'])
        : null;
    vikriti =
    json['Vikriti'] != null ? new Vikriti.fromJson(json['Vikriti']) : null;
    prakriti = json['Prakriti'] != null
        ? new Vikriti.fromJson(json['Prakriti'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.sparshna != null) {
      data['sparshna'] = this.sparshna.toJson();
    }
    if (this.vikriti != null) {
      data['vikriti'] = this.vikriti.toJson();
    }
    if (this.prakriti != null) {
      data['prakriti'] = this.prakriti.toJson();
    }
    return  data;
  }
}

class Data {
  String userId;
  String type;
  List<SparshnaResultDesc> sparshnaResultDesc;
  SparshnaMaster sparshnaMaster;
  List<FoodTypes> foodTypes;
  List<Herbs> herbs;
  List<Kriya> kriya;
  List<Kriya> mudra;
  List<Kriya> meditation;
  List<Kriya> pranayama;
  List<Kriya> yogasana;

  Data(
      {this.userId,
        this.type,
        this.sparshnaResultDesc,
        this.sparshnaMaster,
        this.foodTypes,
        this.herbs,
        this.kriya,
        this.mudra,
        this.meditation,
        this.pranayama,
        this.yogasana});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    type = json['type'];
    if (json['sparshna_result_desc'] != null) {
      sparshnaResultDesc = new List<SparshnaResultDesc>();
      json['sparshna_result_desc'].forEach((v) {
        sparshnaResultDesc.add(new SparshnaResultDesc.fromJson(v));
      });
    }
    sparshnaMaster = json['sparshna_master'] != null
        ? new SparshnaMaster.fromJson(json['sparshna_master'])
        : null;
    if (json['food_types'] != null) {
      foodTypes = new List<FoodTypes>();
      json['food_types'].forEach((v) {
        foodTypes.add(new FoodTypes.fromJson(v));
      });
    }
    if (json['herbs'] != null) {
      herbs = new List<Herbs>();
      json['herbs'].forEach((v) {
        herbs.add(new Herbs.fromJson(v));
      });
    }
    if (json['kriya'] != null) {
      kriya = new List<Kriya>();
      json['kriya'].forEach((v) {
        kriya.add(new Kriya.fromJson(v));
      });
    }
    if (json['mudra'] != null) {
      mudra = new List<Kriya>();
      json['mudra'].forEach((v) {
        mudra.add(new Kriya.fromJson(v));
      });
    }
    if (json['meditation'] != null) {
      meditation = new List<Kriya>();
      json['meditation'].forEach((v) {
        meditation.add(new Kriya.fromJson(v));
      });
    }
    if (json['pranayama'] != null) {
      pranayama = new List<Kriya>();
      json['pranayama'].forEach((v) {
        pranayama.add(new Kriya.fromJson(v));
      });
    }
    if (json['yogasana'] != null) {
      yogasana = new List<Kriya>();
      json['yogasana'].forEach((v) {
        yogasana.add(new Kriya.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['type'] = this.type;
    if (this.sparshnaResultDesc != null) {
      data['sparshna_result_desc'] =
          this.sparshnaResultDesc.map((v) => v.toJson()).toList();
    }
    if (this.sparshnaMaster != null) {
      data['sparshna_master'] = this.sparshnaMaster.toJson();
    }
    if (this.foodTypes != null) {
      data['food_types'] = this.foodTypes.map((v) => v.toJson()).toList();
    }
    if (this.herbs != null) {
      data['herbs'] = this.herbs.map((v) => v.toJson()).toList();
    }
    if (this.kriya != null) {
      data['kriya'] = this.kriya.map((v) => v.toJson()).toList();
    }
    if (this.mudra != null) {
      data['mudra'] = this.mudra.map((v) => v.toJson()).toList();
    }
    if (this.meditation != null) {
      data['meditation'] = this.meditation.map((v) => v.toJson()).toList();
    }
    if (this.pranayama != null) {
      data['pranayama'] = this.pranayama.map((v) => v.toJson()).toList();
    }
    if (this.yogasana != null) {
      data['yogasana'] = this.yogasana.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




class SparshnaResultDesc {
  String title;
  String shortDescription;
  String whatItMeans;

  SparshnaResultDesc({this.title, this.shortDescription, this.whatItMeans});

  SparshnaResultDesc.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortDescription = json['short_description'];
    whatItMeans = json['what_it_means'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title.replaceAll("\"", "");
    data['short_description'] = this.shortDescription.replaceAll("\"", "");
    data['what_it_means'] = this.whatItMeans.replaceAll("\"", "");
    return data;
  }
}

class SparshnaMaster {
  String title;
  String whatItMeans;
  String whatToDo;

  SparshnaMaster({this.title, this.whatItMeans, this.whatToDo});

  SparshnaMaster.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    whatItMeans = json['what_it_means'];
    whatToDo = json['what_to_do'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = (this.title != null)? this.title.replaceAll("\"", ""): this.title;
    data['what_it_means'] = (this.whatItMeans != null)? this.whatItMeans.replaceAll("\"", ""):this.whatItMeans;
    data['what_to_do'] =(this.whatToDo != null)? this.whatToDo.replaceAll("\"", ""):this.whatToDo;
    return data;
  }
}

class FoodTypes {
  String foodType;
  String favourFoods;
  String avoidFoods;

  FoodTypes({this.foodType, this.favourFoods, this.avoidFoods});

  FoodTypes.fromJson(Map<String, dynamic> json) {
    foodType = json['food_type'];
    favourFoods = json['favour_foods'];
    avoidFoods = json['avoid_foods'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_type'] =(this.foodType !=null)? this.foodType.replaceAll("\"", ""):this.foodType;
    data['favour_foods'] =(this.favourFoods != null)? this.favourFoods.replaceAll("\"", ""):this.favourFoods;
    data['avoid_foods'] =(this.avoidFoods != null)? this.avoidFoods.replaceAll("\"", ""):this.avoidFoods;
    return data;
  }
}

class Herbs {
  String herbType;
  String herbsList;

  Herbs({this.herbType, this.herbsList});

  Herbs.fromJson(Map<String, dynamic> json) {
    herbType = json['herb_type'];
    herbsList = json['herbs_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['herb_type'] =(this.herbType != null)? this.herbType.replaceAll("\"", ""):this.herbType;
    data['herbs_list'] =(this.herbsList !=null)? this.herbsList.replaceAll("\"", ""):this.herbsList;
    return data;
  }
}

class Kriya {
  String type;
  String name;
  String shortdescription;
  String steps;
  String benefitDescription;
  String precautions;

  Kriya(
      {this.type,
        this.name,
        this.shortdescription,
        this.steps,
        this.benefitDescription,
        this.precautions});

  Kriya.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    shortdescription = json['shortdescription']
    /*"some problem here ***** Missing"*/;
    steps = json['steps'];
    benefitDescription = json['benefit_description'];
    precautions = json['precautions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] =(this.type != null)? this.type.replaceAll("\"", ""):this.type;
    data['name'] =(this.name != null)? this.name.replaceAll("\"", ""):this.name;
    data['shortdescription'] = /*"some problem here ***** Missing"*/
    (this.shortdescription != null)?  this.shortdescription.replaceAll("\"", ""):this.shortdescription;
    data['steps'] =(this.steps != null)? this.steps.replaceAll("\"", ""):this.steps ;
    data['benefit_description'] =(this.benefitDescription != null)? this.benefitDescription.replaceAll("\"", ""):this.benefitDescription;
    data['precautions'] = (this.precautions != null)?this.precautions.replaceAll("\"", ""):this.precautions ;
    return data;
  }
}

class Sparshna {
  double bmr;
  double dp;
  double rythm;
  double o2r;
  double pitta2;
  double vata2;
  double kath;
  double pbreath;
  double bala;
  double tbpm;
  double sp;
  double bpm;
  double kapha2;
  double bmi;
  String gati;

  Sparshna(
      {this.bmr,
        this.dp,
        this.rythm,
        this.o2r,
        this.pitta2,
        this.vata2,
        this.kath,
        this.pbreath,
        this.bala,
        this.tbpm,
        this.sp,
        this.bpm,
        this.kapha2,
        this.bmi,
        this.gati});

  Sparshna.fromJson(Map<String, dynamic> json) {
    bmr = double.parse(json['bmr'].toString()) ;
    dp =double.parse( json['dp'].toString());
    rythm = double.parse(json['rythm'].toString());
    o2r =double.parse( json['o2r'].toString());
    pitta2 = double.parse(json['pitta2'].toString());
    vata2 =double.parse( json['vata2'].toString());
    kath =double.parse( json['kath'].toString());
    pbreath = double.parse(json['pbreath'].toString());
    bala = double.parse(json['bala'].toString());
    tbpm = double.parse(json['tbpm'].toString());
    sp = double.parse(json['sp'].toString());
    bpm = double.parse(json['bpm'].toString());
    kapha2 =double.parse( json['kapha2'].toString());
    bmi = double.parse(json['bmi'].toString());
    gati = json['gati'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bmr'] = this.bmr;
    data['dp'] = this.dp;
    data['rythm'] = this.rythm;
    data['o2r'] = this.o2r;
    data['pitta2'] = this.pitta2;
    data['vata2'] = this.vata2;
    data['kath'] = this.kath;
    data['pbreath'] = this.pbreath;
    data['bala'] = this.bala;
    data['tbpm'] = this.tbpm;
    data['sp'] = this.sp;
    data['bpm'] = this.bpm;
    data['kapha2'] = this.kapha2;
    data['bmi'] = this.bmi;
    data['gati'] = this.gati;
    return data;
  }
}

class Vikriti {
  String kapha;
  String pitta;
  String vata;

  Vikriti({this.kapha, this.pitta, this.vata});

  Vikriti.fromJson(Map<String, dynamic> json) {
    kapha = json['kapha'].toString();
    pitta = json['pitta'].toString();
    vata = json['vata'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kapha'] = this.kapha;
    data['pitta'] = this.pitta;
    data['vata'] = this.vata;
    return data;
  }
}
