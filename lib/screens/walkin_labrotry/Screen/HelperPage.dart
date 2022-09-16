import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class HelperPage extends StatefulWidget {
  MainModel model;
  HelperPage({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  State<HelperPage> createState() => _HelperPageState();
}

class _HelperPageState extends State<HelperPage> {
  bool viewcustomer = false;
  bool viewinventory = false;
  bool viewvehicle = false;
  bool viewcomplaint = false;
  bool viewtester = false;
  bool viewbody = false;
  bool salesexecutive = false;
  CustVehicleModel custVehicleModel;
  List<CustVehBody> body=[
    new CustVehBody(
        userId: "",
        year: "2uyhr2eh",
        state: "sdcndscn",
        engineNo: "fvkmfv",
        district: "scvsdv",
        country: "vfdv",
        address2: "dcnf"
    )
  ];
  List<String>data=[
    'Inhouse','Writzo','Spiro','Ayruthm'
  ];
  List<bool>viewStatus=[];
  @override
  void initState() {
    data.forEach((element) {
      viewStatus.add(false);
    });
    custVehicleModel = new CustVehicleModel(
        userId: "JKs",
        status: "jkj",
        message: "vcnanv",
        body: body
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          InkWell(
            onTap: () {
              setState(() {
                viewcustomer = !viewcustomer;
                // callCustomerApi();
              });
            },
            child: Container(
              color: Colors.blue,
              height: size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Customer Details'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                        viewcustomer == false
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: viewcustomer,
            child: (custVehicleModel == null || custVehicleModel == "")
                ? Container(
              height: size.height * 0.1,
              child: Center(child: Text('No Data')),
            )
                : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: custVehicleModel.body.length,
                itemBuilder: (context, i) {
                  return Container(
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text('Name : ')),
                                Expanded(
                                    child: Text(
                                        custVehicleModel.body[i].address ??"")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Mobile No. : ')),
                                Expanded(
                                    child: Text(
                                        custVehicleModel.body[i].address ??
                                            "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Alt Mobile No : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]?.address ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Whatsapp No : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]?.address ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Email : ')),
                                Expanded(
                                    child: Text(
                                        custVehicleModel?.body[i]?.address ??
                                            "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Address : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]?.address ??
                                        "")),
                                // Expanded(child: Text(custVehicleModel?.body[i]?.address2??"")),
                                // Expanded(child: Text(custVehicleModel?.body[i]?.address3??"")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('State : ')),
                                Expanded(
                                    child: Text(
                                        custVehicleModel?.body[i]?.address ??
                                            "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('City : ')),
                                Expanded(
                                    child: Text(
                                        custVehicleModel?.body[i]?.address ??
                                            "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Pin : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]?.address ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('GSTIN : ')),
                                Expanded(
                                    child: Text(
                                        custVehicleModel?.body[i]?.address ??
                                            "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('PAN : ')),
                                Expanded(
                                    child: Text(
                                        custVehicleModel?.body[i]?.address ??
                                            "")),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ));
                }),
          ),
          SizedBox(
            height: size.height * 0.002,
          ),

          //VEHICLE
          InkWell(
            onTap: () {
              setState(() {
                viewvehicle = !viewvehicle;
                // callCustomerApi();
              });
            },
            child: Container(
              color:Colors.blue,
              height: size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vehicle'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                        viewvehicle == false
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
          (custVehicleModel == null || custVehicleModel == "")
              ? Container()
              : Visibility(
            visible: viewvehicle,
            child: (custVehicleModel == null || custVehicleModel == "")
                ? Container(
              height: size.height * 0.1,
              child: Center(child: Text('No Data')),
            )
                : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: custVehicleModel.body.length,
                itemBuilder: (context, i) {
                  return Container(
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text('Brand : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i].brand ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Model : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i].model ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child:
                                    Text('Registration No : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]
                                        ?.registrationNo ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child:
                                    Text('Vehicle Date In : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]
                                        ?.vehicleDateIn ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        'Vehicle Last Visit Date : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]
                                        ?.vehicleLastVisitDate ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Colour : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]?.colour ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Engine No : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]?.engineNo ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        'Vehicle Due Out Date : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]
                                        ?.vehicleDuepOutDate ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text('Fuel Reading : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]?.fuelReading ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text('Mileage In : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]?.mileageIn ??
                                        "")),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ));
                }),
          ),
          SizedBox(
            height: size.height * 0.002,
          ),

          //COMPLAINT
          InkWell(
            onTap: () {
              setState(() {
                viewcomplaint = !viewcomplaint;
                // callCustomerApi();
              });
            },
            child: Container(
              color: Colors.blue,
              height: size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Complaint'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                        viewcomplaint == false
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
          (custVehicleModel == null || custVehicleModel == "")
              ? Container()
              : Visibility(
            visible: viewcomplaint,
            child: (custVehicleModel == null ||
                custVehicleModel == "")
                ? Container(
              height: size.height * 0.1,
              child: Center(child: Text('No Data')),
            )
                : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: custVehicleModel.body.length,
                itemBuilder: (context, i) {
                  return Container(
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text('Category : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i]
                                        .mobileNo ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Remarks : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i]
                                        .mobileNo ??
                                        "")),
                              ],
                            ),
                            //  Row(
                            //    children: [
                            //       Expanded(child: Text('Complaint Description : ')),
                            //      Expanded(child: Text( custVehicleModel?.body[i]?.compl??"")),
                            //    ],
                            //  ),

                            Divider()
                          ],
                        ),
                      ));
                }),
          ),
          SizedBox(
            height: size.height * 0.002,
          ),

          //INVENTORY
          InkWell(
            onTap: () {
              setState(() {
                viewinventory = !viewinventory;
                // callCustomerApi();
              });
            },
            child: Container(
              color: Colors.blue,
              height: size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Inventory'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                        viewinventory == false
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
          (custVehicleModel == null || custVehicleModel == "")
              ? Container()
              : Visibility(
            visible: viewinventory,
            child: (custVehicleModel == null ||
                custVehicleModel == "")
                ? Container(
              height: size.height * 0.1,
              child: Center(child: Text('No Data')),
            )
                : ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: custVehicleModel.body.length,
                itemBuilder: (context, i) {
                  return Container(
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text('Inventory : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i].mobileNo ??
                                        "")),
                                Expanded(
                                  child: CheckboxListTile(
                                    value: (custVehicleModel.body[i]
                                        .address ==
                                        "true")
                                        ? true
                                        : false,
                                    onChanged: null,
                                    controlAffinity:
                                    ListTileControlAffinity
                                        .leading, //  <-- leading Checkbox
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Remarks : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i].year ??
                                        "")),
                                Expanded(child: Container())
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text('Inventory Name : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        ?.body[i]?.address ??
                                        "")),
                                Expanded(child: Container())
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ));
                }),
          ),
          SizedBox(
            height: size.height * 0.002,
          ),

          //BODY
          InkWell(
            onTap: () {
              setState(() {
                viewbody = !viewbody;
                // callCustomerApi();
              });
            },
            child: Container(
              color: Colors.blue,
              height: size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BODY DETAILS',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                        viewbody == false
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
          (custVehicleModel == null || custVehicleModel == "")
              ? Container()
              : Visibility(
            visible: viewbody,
            child: (custVehicleModel == null || custVehicleModel == "")
                ? Container(
              height: size.height * 0.1,
              child: Center(child: Text('No Data')),
            )
                : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: custVehicleModel.body.length,
                itemBuilder: (context, i) {
                  return Container(
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text('Vehicle Side : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i].address ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Remarks : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i].address ??
                                        "")),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Picture : ")),
                                // Expanded(child: Text(custBodyModel.body[i].singnature??"")),

                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ));
                }),
          ),
          SizedBox(
            height: size.height * 0.002,
          ),

          //TESTER
          InkWell(
            onTap: () {
              setState(() {
                viewtester = !viewtester;
                // callCustomerApi();
              });
            },
            child: Container(
              color: Colors.blue,
              height: size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TESTER DETAILS',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                        viewtester == false
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
          (custVehicleModel == null || custVehicleModel == "")
              ? Container()
              : Visibility(
            visible: viewtester,
            child: (custVehicleModel == null || custVehicleModel == "")
                ? Container(
              height: size.height * 0.1,
              child: Center(child: Text('No Data')),
            )
                : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: custVehicleModel.body.length,
                itemBuilder: (context, i) {
                  return Container(
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text('Description : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i].address ??
                                        "")),
                                Expanded(
                                  child: CheckboxListTile(
                                    value: (custVehicleModel.body[i]
                                        .address ==
                                        "true")
                                        ? true
                                        : false,
                                    onChanged: null,
                                    controlAffinity:
                                    ListTileControlAffinity
                                        .leading, //  <-- leading Checkbox
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Remarks : ')),
                                Expanded(
                                    child: Text(custVehicleModel
                                        .body[i].address ??
                                        "")),
                                Expanded(child: Container())
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ));
                }),
          ),
          SizedBox(
            height: size.height * 0.002,
          ),

          //SelecExecutive
          InkWell(
            onTap: () {
              setState(() {
                salesexecutive = !salesexecutive;
                // callCustomerApi();
              });
            },
            child: Container(
              color: Colors.blue,
              height: size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sale Executive'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                        salesexecutive == false
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
          /* Visibility(
              visible: salesexecutive,
              child: ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text('  Name '), fromField()],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text('  Contact '), fromFieldNumber()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: this.iswish,
                        onChanged: (bool value) {
                          setState(() {
                            this.iswish = value;
                            print(iswish.toString());
                          });
                        },
                      ),
                      Text('I wish you to proceed without further authority'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: this.ismyphone,
                        onChanged: (bool value) {
                          setState(() {
                            this.ismyphone = value;
                          });
                        },
                      ),
                      Text('Await my telephone/written authority')
                    ],
                  ),
                ],
              )),*/
        ],
      ),
    );
  }
}
class CustVehicleModel {
  List<CustVehBody> body;
  bool success;
  String total;
  int code;
  String message;
  String status;
  String token;
  String userId;

  CustVehicleModel(
      {this.body,
        this.success,
        this.total,
        this.code,
        this.message,
        this.status,
        this.token,
        this.userId});

  CustVehicleModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = <CustVehBody>[];
      json['body'].forEach((v) {
        body.add(new CustVehBody.fromJson(v));
      });
    }
    success = json['success'];
    total = json['total'];
    code = json['code'];
    message = json['message'];
    status = json['status'];
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['total'] = this.total;
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    data['token'] = this.token;
    data['userId'] = this.userId;
    return data;
  }
}

class CustVehBody {
  String fName;
  String mName;
  String lName;
  String companyName;
  String contactPerson;
  String mobileNo;
  String address;
  String district;
  String status;
  String customerType;
  String idcardType;
  String idCardno;
  String gender;
  String profileimageName;
  String profileImg;
  String idImageName;
  String idImg;
  String altMobileNo;
  String noPlate;
  String brand;
  String model;
  String year;
  String insuranceCompny;
  String validTill;
  String garageName;
  String ownerName;
  String ownerContactNo;
  String ownerLandlineNo;
  String tollFreeNo;
  String email;
  String passward;
  String country;
  String state;
  String city;
  String address1;
  String address2;
  String address3;
  String pincode;
  String webSiteName;
  String services;
  String facility;
  String insurance;
  String registrationNo;
  String customerId;
  String panNo;
  String gstNo;
  String whatsappNo;
  String colour;
  String engineNo;
  String fuelReading;
  String mileageIn;
  String vehicleDateIn;
  String vehicleLastVisitDate;
  String vehicleDuepOutDate;
  String jobCardNo;
  String garageLogo;
  String userId;

  CustVehBody(
      {this.fName,
        this.mName,
        this.lName,
        this.companyName,
        this.contactPerson,
        this.mobileNo,
        this.address,
        this.district,
        this.status,
        this.customerType,
        this.idcardType,
        this.idCardno,
        this.gender,
        this.profileimageName,
        this.profileImg,
        this.idImageName,
        this.idImg,
        this.altMobileNo,
        this.noPlate,
        this.brand,
        this.model,
        this.year,
        this.insuranceCompny,
        this.validTill,
        this.garageName,
        this.ownerName,
        this.ownerContactNo,
        this.ownerLandlineNo,
        this.tollFreeNo,
        this.email,
        this.passward,
        this.country,
        this.state,
        this.city,
        this.address1,
        this.address2,
        this.address3,
        this.pincode,
        this.webSiteName,
        this.services,
        this.facility,
        this.insurance,
        this.registrationNo,
        this.customerId,
        this.panNo,
        this.gstNo,
        this.whatsappNo,
        this.colour,
        this.engineNo,
        this.fuelReading,
        this.mileageIn,
        this.vehicleDateIn,
        this.vehicleLastVisitDate,
        this.vehicleDuepOutDate,
        this.jobCardNo,
        this.garageLogo,
        this.userId});

  CustVehBody.fromJson(Map<String, dynamic> json) {
    fName = json['fName'];
    mName = json['mName'];
    lName = json['lName'];
    companyName = json['companyName'];
    contactPerson = json['contactPerson'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    district = json['district'];
    status = json['status'];
    customerType = json['customerType'];
    idcardType = json['idcard_type'];
    idCardno = json['id_cardno'];
    gender = json['gender'];
    profileimageName = json['profileimageName'];
    profileImg = json['profileImg'];
    idImageName = json['idImageName'];
    idImg = json['idImg'];
    altMobileNo = json['altMobileNo'];
    noPlate = json['noPlate'];
    brand = json['brand'];
    model = json['model'];
    year = json['year'];
    insuranceCompny = json['insuranceCompny'];
    validTill = json['validTill'];
    garageName = json['garageName'];
    ownerName = json['ownerName'];
    ownerContactNo = json['ownerContactNo'];
    ownerLandlineNo = json['ownerLandlineNo'];
    tollFreeNo = json['tollFreeNo'];
    email = json['email'];
    passward = json['passward'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    pincode = json['pincode'];
    webSiteName = json['webSiteName'];
    services = json['services'];
    facility = json['facility'];
    insurance = json['insurance'];
    registrationNo = json['registrationNo'];
    customerId = json['customerId'];
    panNo = json['panNo'];
    gstNo = json['gstNo'];
    whatsappNo = json['whatsappNo'];
    colour = json['colour'];
    engineNo = json['engineNo'];
    fuelReading = json['fuelReading'];
    mileageIn = json['mileageIn'];
    vehicleDateIn = json['vehicleDateIn'];
    vehicleLastVisitDate = json['vehicleLastVisitDate'];
    vehicleDuepOutDate = json['vehicleDuepOutDate'];
    jobCardNo = json['jobCardNo'];
    garageLogo = json['garageLogo'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fName'] = this.fName;
    data['mName'] = this.mName;
    data['lName'] = this.lName;
    data['companyName'] = this.companyName;
    data['contactPerson'] = this.contactPerson;
    data['mobileNo'] = this.mobileNo;
    data['address'] = this.address;
    data['district'] = this.district;
    data['status'] = this.status;
    data['customerType'] = this.customerType;
    data['idcard_type'] = this.idcardType;
    data['id_cardno'] = this.idCardno;
    data['gender'] = this.gender;
    data['profileimageName'] = this.profileimageName;
    data['profileImg'] = this.profileImg;
    data['idImageName'] = this.idImageName;
    data['idImg'] = this.idImg;
    data['altMobileNo'] = this.altMobileNo;
    data['noPlate'] = this.noPlate;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['year'] = this.year;
    data['insuranceCompny'] = this.insuranceCompny;
    data['validTill'] = this.validTill;
    data['garageName'] = this.garageName;
    data['ownerName'] = this.ownerName;
    data['ownerContactNo'] = this.ownerContactNo;
    data['ownerLandlineNo'] = this.ownerLandlineNo;
    data['tollFreeNo'] = this.tollFreeNo;
    data['email'] = this.email;
    data['passward'] = this.passward;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['pincode'] = this.pincode;
    data['webSiteName'] = this.webSiteName;
    data['services'] = this.services;
    data['facility'] = this.facility;
    data['insurance'] = this.insurance;
    data['registrationNo'] = this.registrationNo;
    data['customerId'] = this.customerId;
    data['panNo'] = this.panNo;
    data['gstNo'] = this.gstNo;
    data['whatsappNo'] = this.whatsappNo;
    data['colour'] = this.colour;
    data['engineNo'] = this.engineNo;
    data['fuelReading'] = this.fuelReading;
    data['mileageIn'] = this.mileageIn;
    data['vehicleDateIn'] = this.vehicleDateIn;
    data['vehicleLastVisitDate'] = this.vehicleLastVisitDate;
    data['vehicleDuepOutDate'] = this.vehicleDuepOutDate;
    data['jobCardNo'] = this.jobCardNo;
    data['garageLogo'] = this.garageLogo;
    data['userId'] = this.userId;
    return data;
  }
}