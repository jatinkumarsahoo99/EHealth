import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class TestPerfromPage extends StatefulWidget {
  MainModel model;
  TestPerfromPage({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  State<TestPerfromPage> createState() => _TestPerfromPageState();
}

class _TestPerfromPageState extends State<TestPerfromPage> {
  bool viewcustomer = false;
  bool viewinventory = false;
  bool viewvehicle = false;
  bool viewcomplaint = false;
  bool viewtester = false;
  bool viewbody = false;
  bool salesexecutive = false;
  CustVehicleModel custVehicleModel;
  List<CustVehBody> body = [
    new CustVehBody(Nadi: "Nadi", Spiro: "Spiro", Xyz: "Xyz")
  ];
  List<String> data = ['Inhouse', 'Writzo', 'Spiro', 'Ayruthm'];
  List<bool> viewStatus = [];
  @override
  void initState() {
    data.forEach((element) {
      viewStatus.add(false);
    });
    custVehicleModel = new CustVehicleModel(
        userId: "JKs", status: "jkj", message: "vcnanv", body: body);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppData.matruColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 3,bottom: 3,left: 3,right: 3),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, i) {
                // print("token>>>"+widget.model.token.toString());
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          viewStatus[i] = !viewStatus[i];
                          // callCustomerApi();
                        });
                      },
                      child: Container(
                        color: (data[i].toUpperCase()=="INHOUSE")?Colors.green:Color(0xFFf26666),
                        // height: size.height * 0.07,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data[i].toUpperCase(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  (data[i].toUpperCase() =="INHOUSE")? Text(
                                    "Completed".toUpperCase(),
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                                  ):Text(
                                    "Pending".toUpperCase(),
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                      viewStatus[i] == false
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_up,
                                      color: Colors.white),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: viewStatus[i],
                      child: (custVehicleModel != null || custVehicleModel != "")
                          ? Container(
                              // height: size.height * 0.1,
                              child:DataTable2(
                                /*floatingActionButton: ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
                                onSelectAll: (b) {},
                                //dataRowHeight: 3,
                                columnSpacing: 3,

                                horizontalMargin: 6,
                                headingRowHeight: 35,
                                dataRowHeight: 35,

                                border: TableBorder.all(color: Colors.white),
                                headingRowColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.blue
                                ),
                                // sortColumnIndex: 1,
                                sortAscending: true,
                                columns: <DataColumn>[
                                  DataColumn2(
                                    label: Container(
                                      child: Text(
                                        'Test',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:13),
                                      ),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    size: ColumnSize.S,

                                    label: Container(
                                      width: 120,
                                      child: Text(
                                        "Status",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:13),
                                      ),
                                    ),
                                    numeric: false,
                                    //tooltip: "Description",
                                  ),
                                  DataColumn2(
                                    size: ColumnSize.S,
                                    label: Container(
                                      width: 100.0,
                                      child: Text(
                                        "Action",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ],
                                  rows:
                                  (data[i].toUpperCase() =="INHOUSE")?   [
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width:150,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 30,
                                                  child: Checkbox(
                                                    value: false,
                                                    onChanged: (value){

                                                    },

                                                  ),
                                                ),
                                                Container(
                                                  width: 120.0,
                                                  child: Text(
                                                    "Spiro",
                                                    style: TextStyle(color: Colors.black),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child:
                                            Text(
                                              "Complete",
                                              style: TextStyle(color: Colors.green),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Icon( IconData(0xf635, fontFamily: 'MaterialIcons',),color: Colors.green,),
                                           /* Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),*/
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width:150,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 30,
                                                  child: Checkbox(
                                                    value: false,
                                                    onChanged: (value){

                                                    },

                                                  ),
                                                ),
                                                Container(
                                                  width: 120.0,
                                                  child: Text(
                                                    "Nadi",
                                                    style: TextStyle(color: Colors.black),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Complete",
                                              style: TextStyle(color: Colors.green),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Icon( IconData(0xf635, fontFamily: 'MaterialIcons',),color: Colors.green,),
                                          /*  Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),*/
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width:150,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 30,
                                                  child: Checkbox(
                                                    value: false,
                                                    onChanged: (value){

                                                    },

                                                  ),
                                                ),
                                                Container(
                                                  width: 120.0,
                                                  child: Text(
                                                    "XYZ",
                                                    style: TextStyle(color: Colors.black),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Complete",
                                              style: TextStyle(color: Colors.green),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Icon( IconData(0xf635, fontFamily: 'MaterialIcons',),color: Colors.green,),
                                           /* Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),*/
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]:(i== 1)?[
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "ECG",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Pending",
                                              style: TextStyle(color: Colors.red),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "BP",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Pending",
                                              style: TextStyle(color: Colors.red),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "BodyAnalyzer",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Pending",
                                              style: TextStyle(color: Colors.red),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "PQR",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Pending",
                                              style: TextStyle(color: Colors.red),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]:[
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Test1",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Complete",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Test2",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Complete",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Test3",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Complete",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      // selected: true,
                                      cells: [
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Test4",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Complete",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          showEditIcon: false,
                                          placeholder: false,
                                        ),
                                        DataCell(
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Start",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]
                              // Center(child: Text('No Data')

                              ),
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
                                              Expanded(child: Text('Nadi : ')),
                                              Expanded(
                                                  child: Text(custVehicleModel
                                                          .body[i].Nadi ??
                                                      "")),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(child: Text('Spiro: ')),
                                              Expanded(
                                                  child: Text(custVehicleModel
                                                          .body[i].Spiro ??
                                                      "")),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(child: Text('Xyz: ')),
                                              Expanded(
                                                  child: Text(custVehicleModel
                                                          ?.body[i]?.Xyz ??
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
                  ],
                );
              }),
        ));
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
  String Spiro;
  String Nadi;
  String Xyz;

  CustVehBody({
    this.Spiro,
    this.Nadi,
    this.Xyz,
  });

  CustVehBody.fromJson(Map<String, dynamic> json) {
    Spiro = json['Spiro'];
    Nadi = json['Nadi'];
    Xyz = json['Xyz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Spiro'] = this.Spiro;
    data['Nadi'] = this.Nadi;
    data['Xyz'] = this.Xyz;
    return data;
  }
}
