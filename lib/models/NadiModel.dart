class NadiModel {
  EhsJsonReport ehsJsonReport;

  NadiModel({this.ehsJsonReport});

  NadiModel.fromJson(Map<String, dynamic> json) {
    ehsJsonReport = json['ehsJsonReport'] != null
        ? new EhsJsonReport.fromJson(json['ehsJsonReport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ehsJsonReport != null) {
      data['ehsJsonReport'] = this.ehsJsonReport.toJson();
    }
    return data;
  }
}

class EhsJsonReport {
  String uHId;
  String prakrutiType;
  String prakrutiDetail;
  String prakrutiVata;
  String prakrutiPitta;
  String prakrutiKapha;
  String dosha;
  String pulseRate;
  String rhythm;
  String digestionScore;
  String stressScore;
  String toxinsScore;
  String bodyImmunity;
  String hydrationScore;
  String bala;
  String agni;
  String balaDescription;
  String agniDescription;
  String laghu;
  String guru;
  String laghuGuruDescription;
  String kathina;
  String mrudu;
  String kathinaMruduDescription;
  String sthula;
  String sukshma;
  String sthulaSukshmaDescription;
  String tikshna;
  String manda;
  String tikshnaMandaDescription;
  String snigdha;
  String ruksha;
  String snigdhaRukshaDescription;
  String wellnessParameterDescription;
  String thoughts;
  String thoughtDescription;
  String stress;
  String stressDescription;
  String summary;

  EhsJsonReport(
      {this.uHId,
        this.prakrutiType,
        this.prakrutiDetail,
        this.prakrutiVata,
        this.prakrutiPitta,
        this.prakrutiKapha,
        this.dosha,
        this.pulseRate,
        this.rhythm,
        this.digestionScore,
        this.stressScore,
        this.toxinsScore,
        this.bodyImmunity,
        this.hydrationScore,
        this.bala,
        this.agni,
        this.balaDescription,
        this.agniDescription,
        this.laghu,
        this.guru,
        this.laghuGuruDescription,
        this.kathina,
        this.mrudu,
        this.kathinaMruduDescription,
        this.sthula,
        this.sukshma,
        this.sthulaSukshmaDescription,
        this.tikshna,
        this.manda,
        this.tikshnaMandaDescription,
        this.snigdha,
        this.ruksha,
        this.snigdhaRukshaDescription,
        this.wellnessParameterDescription,
        this.thoughts,
        this.thoughtDescription,
        this.stress,
        this.stressDescription,
        this.summary});

  EhsJsonReport.fromJson(Map<String, dynamic> json) {
    uHId = json['UH_Id'];
    prakrutiType = json['Prakruti_Type'];
    prakrutiDetail = json['Prakruti_Detail'];
    prakrutiVata = json['Prakruti_Vata'];
    prakrutiPitta = json['Prakruti_Pitta'];
    prakrutiKapha = json['Prakruti_Kapha'];
    dosha = json['Dosha'];
    pulseRate = json['Pulse_Rate'];
    rhythm = json['Rhythm'];
    digestionScore = json['Digestion_Score'];
    stressScore = json['Stress_Score'];
    toxinsScore = json['Toxins_Score'];
    bodyImmunity = json['Body_Immunity'];
    hydrationScore = json['Hydration_Score'];
    bala = json['Bala'];
    agni = json['Agni'];
    balaDescription = json['Bala_Description'];
    agniDescription = json['Agni_Description'];
    laghu = json['Laghu'];
    guru = json['Guru'];
    laghuGuruDescription = json['Laghu_Guru_Description'];
    kathina = json['Kathina'];
    mrudu = json['Mrudu'];
    kathinaMruduDescription = json['Kathina_Mrudu_Description'];
    sthula = json['Sthula'];
    sukshma = json['Sukshma'];
    sthulaSukshmaDescription = json['Sthula_Sukshma_Description'];
    tikshna = json['Tikshna'];
    manda = json['Manda'];
    tikshnaMandaDescription = json['Tikshna_Manda_Description'];
    snigdha = json['Snigdha'];
    ruksha = json['Ruksha'];
    snigdhaRukshaDescription = json['Snigdha_Ruksha_Description'];
    wellnessParameterDescription = json['WellnessParameter_Description'];
    thoughts = json['Thoughts'];
    thoughtDescription = json['Thought_Description'];
    stress = json['Stress'];
    stressDescription = json['Stress_Description'];
    summary = json['Summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uh_Id'] = this.uHId;
    data['prakruti_Type'] = this.prakrutiType;
    data['prakruti_Detail'] = this.prakrutiDetail;
    data['prakruti_Vata'] = this.prakrutiVata;
    data['prakruti_Pitta'] = this.prakrutiPitta;
    data['prakruti_Kapha'] = this.prakrutiKapha;
    data['dosha'] = this.dosha;
    data['pulse_Rate'] = this.pulseRate;
    data['rhythm'] = this.rhythm;
    data['digestion_Score'] = this.digestionScore;
    data['stress_Score'] = this.stressScore;
    data['toxins_Score'] = this.toxinsScore;
    data['body_Immunity'] = this.bodyImmunity;
    data['hydration_Score'] = this.hydrationScore;
    data['bala'] = this.bala;
    data['agni'] = this.agni;
    data['bala_Description'] = this.balaDescription;
    data['agni_Description'] = this.agniDescription;
    data['laghu'] = this.laghu;
    data['guru'] = this.guru;
    data['laghu_Guru_Description'] = this.laghuGuruDescription;
    data['kathina'] = this.kathina;
    data['mrudu'] = this.mrudu;
    data['kathina_Mrudu_Description'] = this.kathinaMruduDescription;
    data['sthula'] = this.sthula;
    data['sukshma'] = this.sukshma;
    data['sthula_Sukshma_Description'] = this.sthulaSukshmaDescription;
    data['tikshna'] = this.tikshna;
    data['manda'] = this.manda;
    data['tikshna_Manda_Description'] = this.tikshnaMandaDescription;
    data['snigdha'] = this.snigdha;
    data['ruksha'] = this.ruksha;
    data['snigdha_Ruksha_Description'] = this.snigdhaRukshaDescription;
    data['wellnessParameter_Description'] = this.wellnessParameterDescription;
    data['thoughts'] = this.thoughts;
    data['thought_Description'] = this.thoughtDescription;
    data['stress'] = this.stress;
    data['stress_Description'] = this.stressDescription;
    data['summary'] = this.summary;
    return data;
  }
}
