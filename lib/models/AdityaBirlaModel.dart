class AdityaBirlaModel {
  Ns0GFBRes ns0GFBRes;

  AdityaBirlaModel({this.ns0GFBRes});

  AdityaBirlaModel.fromJson(Map<String, dynamic> json) {
    ns0GFBRes = json['ns0:GFB_Res'] != null
        ? new Ns0GFBRes.fromJson(json['ns0:GFB_Res'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ns0GFBRes != null) {
      data['ns0:GFB_Res'] = this.ns0GFBRes.toJson();
    }
    return data;
  }
}

class Ns0GFBRes {
  ErrorObj errorObj;
  PolicyDtls policyDtls;
  Premium premium;
  ReceiptObj receiptObj;

  Ns0GFBRes({this.errorObj, this.policyDtls, this.premium, this.receiptObj});

  Ns0GFBRes.fromJson(Map<String, dynamic> json) {
    errorObj = json['errorObj'] != null
        ? new ErrorObj.fromJson(json['errorObj'])
        : null;
    policyDtls = json['policyDtls'] != null
        ? new PolicyDtls.fromJson(json['policyDtls'])
        : null;
    premium =
        json['premium'] != null ? new Premium.fromJson(json['premium']) : null;
    receiptObj = json['receiptObj'] != null
        ? new ReceiptObj.fromJson(json['receiptObj'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.errorObj != null) {
      data['errorObj'] = this.errorObj.toJson();
    }
    if (this.policyDtls != null) {
      data['policyDtls'] = this.policyDtls.toJson();
    }
    if (this.premium != null) {
      data['premium'] = this.premium.toJson();
    }
    if (this.receiptObj != null) {
      data['receiptObj'] = this.receiptObj.toJson();
    }
    return data;
  }
}

class ErrorObj {
  String errorNumber;
  String errorMessage;

  ErrorObj({this.errorNumber, this.errorMessage});

  ErrorObj.fromJson(Map<String, dynamic> json) {
    errorNumber = json['ErrorNumber'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorNumber'] = this.errorNumber;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class PolicyDtls {
  String transactionReferenceNumber;
  String quotationNumber;
  String certificateNumber;
  String letterURL;
  String clientID;
  String productName;
  String productCode;
  String lineOfBusiness;
  String startDate;
  String endDate;
  String policyNumber;
  String proposalNumber;
  String policyStatus;
  String tenure;
  String stpFlag;
  String memberCustomerID;

  PolicyDtls(
      {this.transactionReferenceNumber,
      this.quotationNumber,
      this.certificateNumber,
      this.letterURL,
      this.clientID,
      this.productName,
      this.productCode,
      this.lineOfBusiness,
      this.startDate,
      this.endDate,
      this.policyNumber,
      this.proposalNumber,
      this.policyStatus,
      this.tenure,
      this.stpFlag,
      this.memberCustomerID});

  PolicyDtls.fromJson(Map<String, dynamic> json) {
    transactionReferenceNumber = json['TransactionReferenceNumber'];
    quotationNumber = json['QuotationNumber'];
    certificateNumber = json['CertificateNumber'];
    letterURL = json['LetterURL'];
    clientID = json['ClientID'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    lineOfBusiness = json['LineOfBusiness'];
    startDate = json['startDate'];
    endDate = json['EndDate'];
    policyNumber = json['PolicyNumber'];
    proposalNumber = json['ProposalNumber'];
    policyStatus = json['PolicyStatus'];
    tenure = json['Tenure'];
    stpFlag = json['stpFlag'];
    memberCustomerID = json['MemberCustomerID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TransactionReferenceNumber'] = this.transactionReferenceNumber;
    data['QuotationNumber'] = this.quotationNumber;
    data['CertificateNumber'] = this.certificateNumber;
    data['LetterURL'] = this.letterURL;
    data['ClientID'] = this.clientID;
    data['ProductName'] = this.productName;
    data['ProductCode'] = this.productCode;
    data['LineOfBusiness'] = this.lineOfBusiness;
    data['startDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['PolicyNumber'] = this.policyNumber;
    data['ProposalNumber'] = this.proposalNumber;
    data['PolicyStatus'] = this.policyStatus;
    data['Tenure'] = this.tenure;
    data['stpFlag'] = this.stpFlag;
    data['MemberCustomerID'] = this.memberCustomerID;
    return data;
  }
}

class Premium {
  String basePremium;
  String netPremium;
  String gST;
  String grossPremium;

  Premium({this.basePremium, this.netPremium, this.gST, this.grossPremium});

  Premium.fromJson(Map<String, dynamic> json) {
    basePremium = json['BasePremium'];
    netPremium = json['NetPremium'];
    gST = json['GST'];
    grossPremium = json['GrossPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BasePremium'] = this.basePremium;
    data['NetPremium'] = this.netPremium;
    data['GST'] = this.gST;
    data['GrossPremium'] = this.grossPremium;
    return data;
  }
}

class ReceiptObj {
  String receiptNumber;
  String receiptAmount;
  String excessAmount;

  ReceiptObj({this.receiptNumber, this.receiptAmount, this.excessAmount});

  ReceiptObj.fromJson(Map<String, dynamic> json) {
    receiptNumber = json['ReceiptNumber'];
    receiptAmount = json['ReceiptAmount'];
    excessAmount = json['ExcessAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ReceiptNumber'] = this.receiptNumber;
    data['ReceiptAmount'] = this.receiptAmount;
    data['ExcessAmount'] = this.excessAmount;
    return data;
  }
}