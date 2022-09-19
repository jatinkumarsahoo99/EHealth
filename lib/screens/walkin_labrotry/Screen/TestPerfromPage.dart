import 'dart:convert';
import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/TestTypeModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
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
  List<int> count = [];
  // List<String>testName=[];
  var testName1;
  TestTypeModel testTypeModel;
  @override
  void initState() {
    /* data.forEach((element) {
      viewStatus.add(false);
    });*/
    custVehicleModel = new CustVehicleModel(
        userId: "JKs", status: "jkj", message: "vcnanv", body: body);
    callApi();
    // print("id"+widget.model.localBookModelBody.regNo);
    super.initState();
  }

  callApi() {
    widget.model.GETMETHODCALL(
        /* api: ApiFactory
            .GET_AllTest + */ /*widget.model.localBookModelBody.regNo*/ /* "9121997046982259",*/
        api:
            "http://api-demo.ehealthsystem.com/nirmalyaRest/api/view-vle-vender-testlist?patientId=9121997046982259",
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              log("Response>>>" + jsonEncode(map));
              testTypeModel = TestTypeModel.fromJson(map);
              testTypeModel.body.forEach((element) {
                viewStatus.add(false);
              });
              testTypeModel.body.forEach((element) {
                count.add(0);
              });
              /*testName1=List.generate(testTypeModel.body.length, (index) =>
                  List.generate(testTypeModel.body[index].getvendertestLists.length, (index) => null));*/

              testName1 =
                  List.generate(testTypeModel.body.length, (index) => []);
            } else {
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppData.matruColor,
        ),
        body: (testTypeModel != null)
            ? Padding(
                padding:
                    const EdgeInsets.only(top: 3, bottom: 3, left: 3, right: 3),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: testTypeModel.body.length,
                    itemBuilder: (context, i) {
                      // print("token>>>"+widget.model.token.toString());
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                viewStatus[i] = !viewStatus[i];
                                testName1[i].clear();
                                print("testName" + testName1[i].toString());
                                testTypeModel.body[i].getvendertestLists
                                    .forEach((element) {
                                  element.isSelected = false;
                                });
                                // callCustomerApi();
                              });
                            },
                            child: Container(
                              color: /*(data[i].toUpperCase()=="INHOUSE")?Colors.green:*/
                                  Color(0xFFf26666),
                              // height: size.height * 0.07,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      testTypeModel.body[i].venderName
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        (testTypeModel.body[i].status != null &&
                                                testTypeModel.body[i].status
                                                        .trim() !=
                                                    "")
                                            ? Text(
                                                "Completed".toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              )
                                            : Text(
                                                "Pending".toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
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
                            child: (testTypeModel != null)
                                ? Column(
                                    children: [
                                      Container(
                                        // height: size.height * 0.1,
                                        child: DataTable2(
                                          /*floatingActionButton: ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
                                          onSelectAll: (b) {},
                                          //dataRowHeight: 3,
                                          columnSpacing: 3,

                                          horizontalMargin: 6,
                                          headingRowHeight: 35,
                                          dataRowHeight: 35,

                                          border: TableBorder.all(
                                              color: Colors.white),
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.blue),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows:
                                              testTypeModel
                                                  .body[i].getvendertestLists
                                                  .map(
                                                    (e) => DataRow(
                                                      // selected: true,
                                                      cells: [
                                                        DataCell(
                                                          Container(
                                                            width: 150,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 30,
                                                                  child:
                                                                      Checkbox(
                                                                    value: e
                                                                        .isSelected,
                                                                    onChanged:
                                                                        (value) {
                                                                      if (value) {
                                                                        e.isSelected =
                                                                            value;
                                                                        count[
                                                                            i]++;
                                                                        print("$i>>>>>+" +
                                                                            count[i].toString());
                                                                        testName1[i]
                                                                            .add(e.testName);
                                                                        print("testName+ " +
                                                                            testName1[i].toString());
                                                                        print("testName- " +
                                                                            testName1.toString());
                                                                      } else {
                                                                        count[
                                                                            i]--;
                                                                        print("$i>>>>>-" +
                                                                            count[i].toString());
                                                                        testName1[i]
                                                                            .remove(e.testName);
                                                                        print("testName- " +
                                                                            testName1[i].toString());
                                                                        print("testName- " +
                                                                            testName1.toString());
                                                                        e.isSelected =
                                                                            value;
                                                                      }
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 120.0,
                                                                  child: Text(
                                                                    e.testName ??
                                                                        "",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Container(
                                                            width: 120.0,
                                                            child: (e.status
                                                                        .trim() ==
                                                                    "Pending")
                                                                ? Text(
                                                                    e.status ??
                                                                        "",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  )
                                                                : Text(
                                                                    "Completed",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                          ),
                                                          showEditIcon: false,
                                                          placeholder: false,
                                                        ),
                                                        DataCell(
                                                          (e.status.trim() !=
                                                                  "Pending")
                                                              ? Container(
                                                                  width: 120.0,
                                                                  child: Icon(
                                                                    IconData(
                                                                      0xf635,
                                                                      fontFamily:
                                                                          'MaterialIcons',
                                                                    ),
                                                                    color: Colors
                                                                        .green,
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 120.0,
                                                                  child: Text(
                                                                    "Start",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  .toList(),
                                          // Center(child: Text('No Data')
                                        ),
                                      ),
                                      Container(
                                        child: FlatButton(
                                          child: Text(
                                            'Start',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          color: Colors.blueAccent,
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  )
                                : Container(
                                    child: Text("Data not found"),
                                  ),
                          ),
                          SizedBox(
                            height: size.height * 0.002,
                          ),
                        ],
                      );
                    }),
              )
            : Container(
                child: Text("Data Not found"),
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
