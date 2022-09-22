import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user/models/AyuRythmDataModel.dart';
import 'package:user/models/AyuRythmPostModel.dart';
import 'package:user/models/NadiModel.dart';
import 'package:user/models/TestTypeModel.dart';
import 'package:user/models/WritzoReceiveModel.dart';
import 'package:user/providers/Aes.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

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
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController patientHeight = TextEditingController();
  TextEditingController patientWeight = TextEditingController();

  List<String> data = ['Inhouse', 'Writzo', 'Spiro', 'Ayruthm'];
  List<bool> viewStatus = [];
  List<int> count = [];
  List<String>venderName=[];
  var dio = Dio();
  String dateofBirth1;
  static const platform = AppData.channel;
  // List<String>testName=[];
  var testName1;
  var testNameId;
  TestTypeModel testTypeModel;
  int age=0;
  @override
  void initState() {
    /* data.forEach((element) {
      viewStatus.add(false);
    });*/
    callApi();
    // print("id"+widget.model.localBookModelBody.regNo);
    super.initState();
  }

  callApi() {
    widget.model.GETMETHODCALL(
        api: ApiFactory.GET_AllTest + widget.model.patientList.patientId,
        /*  api:
        "http://api-demo.ehealthsystem.com/nirmalyaRest/api/view-vle-vender-testlist?patientId=9121997046982259",*/
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              log("Response>>>" + jsonEncode(map));
              testTypeModel = TestTypeModel.fromJson(map);
              // testTypeModel.body.sort();
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
              testNameId =
                  List.generate(testTypeModel.body.length, (index) => []);
              venderName =
                  List.generate(testTypeModel.body.length, (index) => "");
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
                                testNameId[i].clear();
                                // venderName.removeAt(i);
                                venderName[i]="";
                                print("testName" + testName1[i].toString());
                                print("testId" + testNameId[i].toString());
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
                                      (testTypeModel.body[i].type ?? "")
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
                            child: (testTypeModel != null &&
                                    testTypeModel.body[i].getvendertestLists
                                            .length !=
                                        0)
                                ? Column(
                                    children: [
                                      Container(
                                        // height: size.height * 0.1,
                                        child: DataTable2(
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
                                                                (e.status.trim() =="Pending")? Container(
                                                                  width: 30,
                                                                  child:
                                                                      Checkbox(
                                                                    value: e
                                                                        .isSelected,
                                                                    onChanged:
                                                                        (value) {
                                                                      if (value) {
                                                                        if(testName1[i].length == 0){
                                                                          venderName[i]="";
                                                                        }
                                                                        if(venderName[i].trim() =="" ||
                                                                            venderName[i].toLowerCase() ==e.venderName.toLowerCase() ){
                                                                          print("Vender namefrom server>>>>"+e.venderName);
                                                                          venderName[i]=e.venderName;
                                                                          e.isSelected =
                                                                              value;
                                                                          count[
                                                                          i]++;
                                                                          print("$i>>>>>+" +
                                                                              count[i].toString());
                                                                          testName1[i]
                                                                              .add(e.testName);
                                                                          testNameId[i]
                                                                              .add(e.testId??" ");
                                                                          print("testName+ " +
                                                                              testName1[i].toString());
                                                                          print("testNameId" +
                                                                              testNameId[i].toString());
                                                                          print("Vender name"+venderName[i]);
                                                                        }else{
                                                                          /*if(testName1[i].length == 0){
                                                                            venderName[i]="";
                                                                          }*/
                                                                          print("Vender name "+venderName[i]);
                                                                          print("Vender namefrom server"+e.venderName);
                                                                          AppData.showInSnackBar(context, "Please select one set of group");
                                                                        }

                                                                      } else {
                                                                        print("length>>jks"+testName1[i].length.toString());
                                                                        if(testName1[i].length == 1){
                                                                          venderName[i]="";
                                                                        }
                                                                        count[
                                                                            i]--;
                                                                        print("$i>>>>>-" +
                                                                            count[i].toString());
                                                                        testName1[i]
                                                                            .remove(e.testName);
                                                                        testNameId[i]
                                                                            .remove(e.testId);
                                                                        print("testName- " +
                                                                            testName1[i].toString());
                                                                        print("testName- " +
                                                                            testName1.toString());
                                                                        print("Vender name"+venderName[i]);
                                                                        e.isSelected =
                                                                            value;
                                                                      }
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ):Container(),
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
                                          onPressed: () {
                                            // venderName[i] = "Ayurythm";
                                            if(venderName[i].trim().toLowerCase() == ("Safiey").toLowerCase() ){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      dialogForSpiro(context,i));
                                            }
                                            else if( venderName[i].trim().toLowerCase() == ("WRIZTO").toLowerCase() ){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      dialogForWritzo(context,i));
                                            }
                                           else if( venderName[i].trim().toLowerCase() == ("Birla").toLowerCase() ){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      dialogForBirla(context,i));
                                            }
                                           else if( venderName[i].trim().toLowerCase() == ("Naditarangini").toLowerCase() ){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      dialogForNadiTrangi(context,i));
                                            }
                                            else if( venderName[i].trim().toLowerCase() == ("Ayurythm").toLowerCase() ){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      dialogForAyuruthm(context,i));

                                            }else if(venderName[i].trim() !=""){
                                              AppData.showInSnackBar(context, "Coming Soon....");
                                            }
                                            else{
                                              AppData.showInSnackBar(context, "Please Select at least one test");
                                            }

                                          },
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
                child: Center(child: Text("Data Not found")),
              ));
  }

  callNadiApp(String val) async {
    var result = await AppData.channel.invokeMethod('call_nadi', val);
    NadiModel nadiModel = NadiModel.fromJson(jsonDecode(result));
    log("nadi data" + nadiModel.toJson().toString());
    widget.model.POSTMETHOD(
        api: ApiFactory.API_Nadi,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Response>>>" + jsonEncode(map));
          if (map['code'] == "success") {
            AppData.showInSnackDone(context, map['message']);
          } else {
            AppData.showInSnackBar(context, map['message']);
          }
        },
        json: nadiModel.toJson());
    // AppData.showInSnackBar(context, result??"Some thing wrong");
  }


  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        // firstDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 30000)),
        lastDate: DateTime.now().add(Duration(days: 120)));
    if (picked != null) {
      dateOfBirth.text = DateFormat("dd-MM-yyyy").format(picked);
      // dateofBirth.text = picked.toString();
      dateofBirth1 = picked.millisecondsSinceEpoch.toString();
    } else {
      AppData.showInSnackBar(context, "Please choose date");
    }
  }

  Widget dialogForWritzo(BuildContext context,int index) {
    print("Function call");
    dateOfBirth.text = "";
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //_buildAboutText(),
              //_buildLogoAttribution(),
              Text(
                "FILL UP DETAILS",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                child: Divider(
                  height: 2,
                ),
                width: 180,
              ),
              Text(
                "(" + widget.model.patientList.patientName + ")",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 0, top: 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "DOB:",
                      ),
                      onTap: () {
                        _selectDate1(context);
                      },
                      controller: dateOfBirth,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            age=0;
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: const Text('CANCEL'),
        ),
        new FlatButton(
          onPressed: () {
            if(dateOfBirth.text == null || dateOfBirth.text.trim() ==""){
              AppData.showInSnackBar(context, "Please enter date of birth");
            }else{
              var inputFormat = DateFormat('dd-MM-yyyy');
              var outputFormat = DateFormat('yyyy-MM-dd');
              var date1 = inputFormat.parse(dateOfBirth.text);

              age = (DateTime.parse(date1.toString()).difference(DateTime.now()).inDays/365 ).round().abs() ;
              widget.model.patientList.age=age.toString();
              print("age>>>"+age.toString());

              if(age<=0 ){
                AppData.showInSnackBar(context, "Age should be greater than one");
              }else if(testName1[index].length <=0 ||  venderName[index].trim() ==""){
                AppData.showInSnackBar(context, "Please select at least one test");
            }else{
                print("Writzocall >>>>>>>>>>>>>>jatin");

                String mapping = Aes.encrypt(widget.model.patientList.patientId.trim()) +
                    "," +
                    widget.model.patientList.age.toString().trim() +
                    "," +
                    (widget.model.patientList.gender??"Other") +
                    "," +
                    Aes.encrypt(widget.model.patientList.patientName);
                _callWritzo(mapping);
                Navigator.of(context).pop();
              }


            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('0k'),
        ),
      ],
    );
  }

  Widget dialogForBirla(BuildContext context,int index) {
    print("Function call");
    dateOfBirth.text = "";
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //_buildAboutText(),
              //_buildLogoAttribution(),
              Text(
                "FILL UP DETAILS",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                child: Divider(
                  height: 2,
                ),
                width: 180,
              ),
              Text(
                "(" + widget.model.patientList.patientName + ")",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 0, top: 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "DOB:",
                      ),
                      onTap: () {
                        _selectDate1(context);
                      },
                      controller: dateOfBirth,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            age=0;
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: const Text('CANCEL'),
        ),
        new FlatButton(
          onPressed: () {
            if(dateOfBirth.text == null || dateOfBirth.text.trim() ==""){
              AppData.showInSnackBar(context, "Please enter date of birth");
            }else{
              var inputFormat = DateFormat('dd-MM-yyyy');
              var outputFormat = DateFormat('yyyy-MM-dd');
              var date1 = inputFormat.parse(dateOfBirth.text);

              age = (DateTime.parse(date1.toString()).difference(DateTime.now()).inDays/365 ).round().abs() ;
              widget.model.patientList.age=age.toString();
              print("age>>>"+age.toString());

              if(age<=0 ){
                AppData.showInSnackBar(context, "Age should be greater than one");
              }else if(testName1[index].length <=0 ||  venderName[index].trim() ==""){
                AppData.showInSnackBar(context, "Please select at least one test");
              }else{
                String testName="";
                String testId="";
                testName1[index].forEach((element) {
                  if(testName.trim() ==""){
                    testName=element;
                  }else{
                    testName=testName+","+element;
                  }

                });
                print("testName>>>>"+testName);
                testNameId[index].forEach((element) {
                  if(testId.trim() ==""){
                    testId=element;
                  }else{
                    testId=testId+","+element;
                  }

                });
                print("testId>>>>>"+testId);

               Map<String,String>  postData={
                 "lab_code":widget.model.patientList.vleId,
                 "TestName":testName,
                 "DateOfEntry":DateTime.now().toString(),
                 "intial":"Mr.",
                 "FirstName":widget.model.patientList.patientName,
                 "LastName":widget.model.patientList.patientName,
                 "DateofBirth":dateOfBirth.text ,
                 "Remark":"some things",
                 "Username":widget.model.loginResponse1.body.user,
                 "TLCode":testId,
                 "sex":widget.model.patientList.gender,
                 "Age":widget.model.patientList.age,
                 "MDY":DateTime.now().year.toString(),
                 "Mob_no":widget.model.patientList.patientId,
                 "email":"jatinkumarsahoo99@gmail.com"
               };
               log("Birla Post data>>>"+postData.toString());
                // callBirlaApi(postData);
                Navigator.of(context).pop();
              }


            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('0k'),
        ),
      ],
    );
  }
  callBirlaApi( Map<String,String> data){
    widget.model.POSTMETHOD(
        api: "https://pathogoldcloud.com/EHS/api/InsertupdateResult_SASCAN/RegisterPatientAPI",
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Response>>>" + jsonEncode(map));
          if (map['code'] == "success") {
            AppData.showInSnackDone(context, map['message']);
          } else {
            AppData.showInSnackBar(context, map['message']);
          }
        },
        json: data);
  }
  Widget dialogForNadiTrangi(BuildContext context,int index) {
    print("Function call");
    dateOfBirth.text = "";
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //_buildAboutText(),
              //_buildLogoAttribution(),
              Text(
                "FILL UP DETAILS",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                child: Divider(
                  height: 2,
                ),
                width: 180,
              ),
              Text(
                "(" + widget.model.patientList.patientName + ")",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 0, top: 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "DOB:",
                      ),
                      onTap: () {
                        _selectDate1(context);
                      },
                      controller: dateOfBirth,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            age=0;
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: const Text('CANCEL'),
        ),
        new FlatButton(
          onPressed: () {
            if(dateOfBirth.text == null || dateOfBirth.text.trim() ==""){
              AppData.showInSnackBar(context, "Please enter date of birth");
            }else{
              var inputFormat = DateFormat('dd-MM-yyyy');
              var outputFormat = DateFormat('yyyy-MM-dd');
              var date1 = inputFormat.parse(dateOfBirth.text);

              age = (DateTime.parse(date1.toString()).difference(DateTime.now()).inDays/365 ).round().abs() ;
              widget.model.patientList.age=age.toString();
              print("age>>>"+age.toString());

              if(age<=0 ){
                AppData.showInSnackBar(context, "Age should be greater than one");
              }else if(testName1[index].length <=0 ||  venderName[index].trim() ==""){
                AppData.showInSnackBar(context, "Please select at least one test");
              }else{
                print("Naditrangi >>>>>>>>>>>>>>jatin");
                String mapping = widget.model.patientList.patientId.trim() +
                    "," +
                    widget.model.patientList.age.toString().trim() +
                    "," +
                    widget.model.patientList.gender +
                    "," +
                    widget.model.patientList.patientName;
                callNadiApp(mapping);
                Navigator.of(context).pop();
              }


            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('0k'),
        ),
      ],
    );
  }


  Widget fromFieldNew(String hint, inputAct, keyType, String type,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
      child: TextFormField(
        autofocus: false,
        controller: controller,
        //textInputAction: TextInputAction.next,

        /*inputFormatters: [
          //UpperCaseTextFormatter(),
        ],*/
        maxLength: 6,
        keyboardType: TextInputType.number,
        inputFormatters: [
          WhitelistingTextInputFormatter(RegExp("[0-9. ]")),
        ],
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          labelText: hint,
          counterText: "",
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
        ),
      ),
    );
  }

  Future<void> callAyurythm(String data, String uhid) async {
    try {
      log("Value data>>>>" + data);
      dynamic result = await AppData.channel.invokeMethod('ayurythm', data);

      /*  AppData.showInSnackBar2(context, result.toString());*/

/*
      String result = '{"yogasana":[{"type":"kapha,pitta","name":"Janu Sirshasana","shortdescription":"The name comes from the Sanskrit words ‘Janu’ meaning ‘knee’, ‘Sirsa’ meaning ‘head’ and ‘asana’ meaning ‘posture’. This asana is a forward fold asana bringing the head towards the knee while bending the upper torso from the hips. This asana is considered as a great hip opener and it also opens the hamstrings.","steps":"1. Sit on the mat with left leg straight and the right leg folded, close to the inner part of the left thigh. \\n2. Keep your spine straight, inhale, and raise both the hands, Exhale and bend forward to hold your toe of the left leg with the both hands. \\n3. Keep your head on the left knee without bending the leg and hold the position for 10 - 20 seconds.\\n4. To release, inhale and come up, raise your hands and while exhaling bring the arms down to the sides.\\n5. Repeat the same with the other leg.","benefit_description":"Calms the brain and helps relieve mild depression\\nStretches the spine, shoulders, hamstrings, and groins\\nStimulates the liver and kidneys.\\nImproves digestion.\\nHelps relieve the symptoms of menopause.\\nRelieves anxiety, fatigue, headache, menstrual discomfort.\\nTherapeutic for high blood pressure, insomnia, and sinusitis.\\nStrengthens the back muscles during pregnancy (up to second trimester), done without coming forward, keeping your back spine concave and front torso long.","precautions":"Person suffering from sciatica, slipped disc, injured knee, or hernia problem should avoid this asana."},{"type":"kapha,pitta,vatta","name":"Ardha Matsyendrasana","shortdescription":"Ardha Matsyendrasana or half spinal twist yogasana is major asana effectively practiced in the hatha yoga. When you do this yogasana, the complete length of your spine receives the lateral twist in both the directions. This asana includes different movements that tones your ligaments and spinal nerves, and enhance your digestion.","steps":"1. Sit with both the legs stretched out\\n2. Cross the right leg over the left, placing the right foot flat on the floor close to the right knee. \\n3. Then bend the left leg to bring the heel next to the right hip.\\n4. Inhale and move the left hand up and as you exhale turn around your upper body with your right palm on the ground\\n5. Now slowly hold your right feet with your left hand\\n6. Hold the position for 10-15 seconds\\n7. Now slowly release your left hand get back to resting position\\n8. Repeat the same on with your left leg crossed over your right","benefit_description":"Ardha matsyendrasana is one of the best asans to improve the flexibility of the spine. It keeps your spine young.\\nIt stretches the muscles along the spinal column and tones the spinal nerves. This can relieve some mild pains caused by stiff back.\\nIt is good for mild cases of slipped disk.\\nThis asana massages the organs in the abdominal region.\\nIt improves digestion.\\nArdha matysendrasana tones the kidneys and improves secretion of the adrenal glands.\\nIt activates the pancreas and helps to manage diabetes.","precautions":"People who are suffering from peptic ulcer, hernia, heart and brain problems, hyperthyroidism should avoid. Women after two or three months of pregnancy should avoid."},{"type":"vatta","name":"Baddh Konasana","shortdescription":"Baddh Konasana, also known as Bound Angle asana, is a seated asana in hatha yoga and modern yoga as exercise. This asana strengthens and opens the hips and groin while eradicating abdominal discomfort.","steps":"1. Sit down on the floor with the legs stretched out\\n2. Pull in your feet as close as possible and place the soles of the feet together with your hands\\n3. Keep the upper body straight \\n4. Exhale and bend forward, bringing your forehead all the way down to touch the floor\\n5. Hold the pose for 5 breaths, Then raise the head and get back to starting position","benefit_description":"Relieves urinary disorders.\\nStrong hip and groin opener.\\nStimulates pelvis, abdomen and back.\\nRelieves sciatica pain and stretches spine.\\nPrevents hernia.\\nRelieves stress.\\nImproves blood circulation and reproductive system.\\nCorrects irregular menstruation.\\nEffective for lumbar region, flat feet, infertility and asthma.","precautions":"People with groin and knee injury, Sciatica patients and during menstruation should avoid this asana."}],"pranayama":[{"type":"pitta","name":"Bahirkumbhak Pranayama","shortdescription":"Bahirkumbhak pranayama is a yogic breathing technique that consists of a deep inhalation, full exhalation, and holding this full exhalation while enforcing 3 ?locks? in the chin, abdomen and naval/pelvis. It is beneficial for diseases pertaining to organs in the abdominal cavity. This pranayama is best done after Kapalbhati ? you make most efficient use of the built up energy from Kapalbhati in this pranayama.","steps":"- Sit comfortably in an upright posture and close your eyes\\n- Breathe in deeply\\n- Hold for 10-15 seconds (or as long as comfortably possible)\\n- Exhale fully with uniform force\\n- Start with 3 repetitions of Bahya pranayama and increase gradually.","benefit_description":"It makes the digestive system strong. It deals with constipation and gas (acidity). It offers wonderful benefits for Diabetic patients. It is helpful for concentration boosting.","precautions":""},{"type":"pitta","name":"Jalandhar Bandha","shortdescription":"Jalandhara Bandha is the chin Bandha described and employed in Hatha Yoga. This bandha is performed by extending the neck and elevating the sternum (breastbone) before dropping the head so that the chin may rest on the chest. Meanwhile, the tongue pushes up against the palate in the mouth. This bandha is the most important in practice of pranayama with breath retention.","steps":"Sit in a comfortable pose\\n- just relax your mind\\n- Inhale deeply and lock your chin To the neck\\n- hold the breathe until you maintain the lock\\n- slowly, release the lock and relax","benefit_description":"This posture works the spinal cord. It enhances blood circulation, thereby improving the health of your spinal cord. It awakens the inner energy centres, especially the Vishuddhi Chakra. Improves the ability to retain the breath for a long period of time and develops the ability to concentrate. Beneficial for throat diseases and regulates thyroid function.","precautions":"High or low blood pressure\\nCervical spondylitis or neck pain\\nVertigo or heart disease\\nHyper thyroid"},{"type":"vatta","name":"Bhramari Pranayama","shortdescription":"The Bhramari pranayama, or Humming Bee breathing, is breathing technique derives its name from the black Indian bee called Bhramari. Bhramari pranayama is effective in instantly calming down the mind. It is one of the best breathing exercises to free the mind of agitation, frustration or anxiety and get rid of anger to a great extent.","steps":"- Sit in a comfortable position\\n- Close the ears by pressing your thumbs on the cartilage between the cheek and the ear gently\\n- Bring the rest of your palm over to cover your eyes with the index and middle finger. Do not press\\ndown on the eyes\\n- Breathe in and slowly, while breathing out make a loud humming sound like a bee keeping your\\ncartilage pressed\\n- Breathe in again and repeat the same pattern for 6-7 times.","benefit_description":"It lowers blood pressure, thus relieving hypertension. It releases cerebral tension. It soothes the nerves. It stimulates the pineal and pituitary glands, thus supporting their proper functioning. It dissipates anger. It is the great cure for stress.","precautions":"Should be done on empty stomach"}],"meditation":[{"type":"kapha,pitta,vatta","name":"Sound Meditation","shortdescription":"You can do this exercise at any time, in any place, for any length of time you choose. I encourage you to practice it in different settings: a quiet space in your home, a park, a crowded office or shopping center, even alongside a major road or construction site.\\nDo not discriminate between settings you usually find to be ‘positive’ or ‘peaceful’ and those you find ‘negative’ ‘noisy’ or ‘annoying.’","steps":"As always, take a few moments to breathe, calming the mind, separating the next few minutes from the rest of your day, setting your intention to move within.\\nNow, turn your attention to the sounds around you. Listen to the sound of my voice, the sound of the music, and any others sounds that may be around you.\\nWherever you are, observe that there is always sound. With the music, this is obvious, but we can use the music as a symbol, a pointer, for listening more fully.\\nSo, ask yourself, what do you hear, right now?\\nListen more closely. How many instruments do you hear? How many tones do you hear? How many layers are there to the sound?\\nThese layers have different qualities to them. Some, like the sound of my voice, a melody, or a gong, come and go freely. They appear obvious\\nOthers are more subtle. The pedal-point of a song, the hum of a radiator, light, or appliance.\\nBut, even these more constant sounds vary. They pass in and out of our awareness. They expand and contract.\\nNow, begin to isolate one layer – one aspect – of the sound you hear. Choose anything, and focus on it.\\nAs it resonates, ask: what, really, is this sound? What is beside it, or behind it?\\nAs it passes, ask: where does the sound go? Where did it begin?\\nWhat is the canvas the sound is painted upon?\\nListen, observe, and repeat.","benefit_description":"Stress reduction.\\nReduced chance of brain decline.\\nReduction in anxiety and depression.\\nBetter sleep and relaxation.","precautions":""},{"type":"pitta,vatta,kapha","name":"Mindfulness Meditation","shortdescription":"Mindfulness meditation is the practice of intentionally focusing on the present moment, accepting and non-judgmentally paying attention to the sensations, thoughts, and emotions that arise. “Mindfulness” is the common western translation for the Buddhist term Anapanasati, “mindfulness of breathing”.","steps":"- For the “formal practice” time, sit on a cushion on the floor, or on a chair, with straight and unsupported back. Pay close attention to the movement of your breath. When you breath in, be aware that you are breathing in, and how it feels. When you breath out, be aware you are breathing out. Do like this for the length of your meditation practice, constantly redirecting the attention to the breath. Or you can move on to be paying attention to the sensations, thoughts and feelings that arise.\\n- The effort is to not intentionally add anything to our present moment experience, but to be aware of what is going on, without losing ourselves in anything that arises.\\n- Your mind will get distracted into going along with sounds, sensations, and thoughts. Whenever that happens, gently recognize that you have been distracted, and bring the attention back to the breathing, or to the objective noticing of that thought or sensation. There is a big different between being inside the thought/sensation, and simply being aware of its presence.\\n- Learn to enjoy your practice. Once you are done, appreciate how different the body and mind feel.","benefit_description":"Help relieve stress.\\nImprove sleep.\\nIncreased self-awareness.\\nSense of calmness.\\nIncrease focus.","precautions":""},{"type":"kapha","name":"Ajapa-Japa","shortdescription":"Ajapa Japa, a sadhana that dates from the Upanishads, is a powerful practice that combines elements of pranayama, mantra chanting and meditation. Japa means ","steps":"Sit in a comfortable position of your choice and relax your body completely. Practice kaya sthairyam (stillness of the body). Become aware of the breathing process. Observe every breath as your breathing becomes slow and rhythmic. \\n\\nNow visualize and try to imagine a transparent breathing tube spanning the body between the navel and the throat. Bring your awareness to your navel and start practicing ujjayi breathing. Slowly move your awareness up and down inside the psychic breathing tube (frontal passage). As you breathe in, your knowledge flows slowly and evenly up from the navel to the throat and as you breathe out, it flows from the throat to the navel.\\n\\nThen add a third force, prana in the form of golden liquid. Visualize prana as a golden liquid flowing up and down together with the breath and the awareness. You have the breath, the awareness, and pranic energy in the form of golden liquid ascending and descending inside this psychic passage. \\n\\nObserve this slender, flowing river of golden liquid flowing with the breath and the consciousness inside the passage.\\n\\nTo make the practice more constant, use the mantra SOHAM. (I am that). As you inhale, it is SO and as you exhale it is HAM. Now you have the breath, the awareness, the pranic energy and the mantra SOHAM ascending and descending inside the frontal passage. Practice this for a while. \\n\\n\\nNow get ready to end the practice. Leave the awareness of the psychic passage, of the prana and the breath. Become aware of your physical body, of your meditation posture and the external environment. \\nWhen your consciousness is fully externalized, slowly open your eyes.","benefit_description":"By bringing the consciousness into the heart, this breathing method supports Prana Vayu (energy pervades the chest region).\\nImproves blood circulation and oxygenation of the body, fills the mind with positive energy.\\nCultivate self-awareness and reduces the dominance of the senses and boosts mental faculties.","precautions":"Try not to move your physical body. The head, spine and back must remain straight, but without tensing. \\nDo not make the breath so long that your body starts jerking or shaking."}],"mudra":[{"type":"pitta, vatta","name":"Vipareet Karni Mudra","shortdescription":"Viparita karani mudra is a full-body gesture in yoga that is also an energizing inversion. The name comes from the Sanskrit viparita, meaning ","steps":"1. The base position is lying down supine with hands to the sides.\\n2. Inhale deeply and hold the breath inside. Bring the legs up to the right angle from the floor while keeping the knees extended. Check how the abdomen gets engaged in the process. Continue breathing normally.\\n3. Now inhale deeply and while holding the breath, contract the abdomen more strongly while lifting the spine off the floor. Bring the hands to support the torso adjacent to the sacrum bone, the flat space that you feel under the lower back and place the torso at a 45 degree angle from the floor. Legs will move parallel to the floor over and behind the head. The key point of awareness is abdomen which is the central axis of building the asana from here.\\n4. As you get comfortable, continue breathing and extend the hips and bring the legs to a 45 degree elevation with pelvic being the base. Hands will be bear weight of the body along with the abdomen so you might experience it in your wrists and elbows.\\n5. Stay in the posture for minimum 30 seconds while breathing deeply through diaphragm. You will feel your diaphragm here.\\n6. Coming out, flex the hips bringing the legs down and in a controlled manner put the torso down on the floor with a coordinated effort of hands and abdomen.\\n7. Check your breath and relax the abdomen.","benefit_description":"Vipreeta karani mudra has hte following benefits \\nIt is a nice way to build your inversion practise. \\nIt gives a stability of the core and strengthen the wrists and lower arms.\\nHelp in relieving the strain from the heart.\\nIt is used as a primary technique along with other mudras in Kundalini Yoga, for channelising the Pran Shakti.","precautions":"Avoid this Asana with high blood pressure or dizziness.\\nIf you have serious back and neck problems, make sure you do this asana under the guidance of a certified yoga instructor."},{"type":"pitta","name":"Tadaagi Mudra","shortdescription":"The Sanskrit meaning of ","steps":"Keep the feet a little apart and take a comfortable standing position.\\nKeeping hands on knees, slightly bend the body forward.\\nExhale out the air deeply and do not allow the air to enter the lungs again.\\nRaise the ribs so that the thorax relax. \\nThe diaphragm is raised to completely fill the vacuum and with this the abdominal wall is also pulled.\\nThis provides the concave shape to the abdomen.\\nWhile the abdominal wall is in relaxed position, the anus and pelvis are contracted.\\nHold the position as long as the person can take it comfortably, then inhale the air normally.\\nAfter a few normal breathings, this process can be repeated for few times.","benefit_description":"This benefits in \\nHealthy respiratory system, digestive system, abdomen and pelvis muscles.\\nBenefits various glands and organs of abdominal cavity.\\nDispels depression and headache. \\nImproves digestive function. \\nStrengthens the finger, arm, shoulder, chest and abdominal muscles.","precautions":"This Asana should not be practiced during menstruation, pregnancy or with haemorrhoids. If the Asana causes pain in the fingers, avoid its practice."},{"type":"vatta","name":"Maha Mudra, Maha Bhed Mudra","shortdescription":"Maha Bheda Mudra or the Great Piercing Attitude is mentioned in both Hatha Yoga Pradeepika and Gheranda Samhita. In Sanskrit, Maha means great, Bheda means to pierce and Mudra means a gesture, attitude or seal.","steps":"Sit on the floor with legs stretched out. Fold the left leg and press the perineum with the left heel. The right leg remains stretched out in front throughout the practice.\\nBend forward and hold the big toe of the right leg with the hands. Exhale while bending forward.\\nNow perform Maha Bandha. It comprises of the three Bandhas or locks Jalandhara Bandha, Uddhiyana Bandha and Moola Bandha done together.\\nPerform nose tip gazing or Nasikagra Dhristi.\\nNow begin to rotate the consciousness between the three chakras ","benefit_description":"Maha Bheda Mudra gives physical and spiritual benefits.\\nIt gives all the benefits of Maha Bandha.\\nIt harnesses the energy at the three chakra and induces concentration of the mind and prepares the mind for meditation.\\nIt supposed to give siddhis and perfection to the yogi.\\nAccording to the Hatha Yoga Pradeepika, this mudra gives siddhis, destroys old age and grey hair, increases appetite and gives steadiness to the body.\\nAccording to Gheranda Samhita, there is no fear of death and decay does not come to a yogi who practices Mahe Bheda Mudra.","precautions":""}],"kriya":[{"type":"kapha","name":"Jalneti Kriya","shortdescription":"Neti kriya is an integral part of shatkarmas - the six cleansing techniques that form the most important aspect of hatha yoga. Jal Neti is a nasal cleansing yogic process where salted lukewarm water is used to remove the congestion and blockages of nasal as well as respiratory regions.","steps":"The simple steps and technique of performing Jal neti are being given below:\\nFirst of all sit in Kagasana having 1 foot distance between legs.\\nLean forward from the lower back and tilt the head to the opposite side of the nostril whichever is more active at the moment.\\nInsert the nozzle of the pot into the nostril which is active at that moment. Open your mouth throughout the neti process and try to breathe through it.\\n\\nLet the water flow in through one nostril and out through the other nostril.\\nAfter finishing half of the water of the Neti pot, put it down and clear your nostril.\\nThe same thing should start from other side.\\nAfter finishing from both side, do forceful exhalation from both the nostrils in all the directions i.e. left \u0026 right, top \u0026 bottom.","benefit_description":"Daily practice helps maintain the nasal hygiene by removing the dirt and bacteria trapped along with the mucus in the nostrils.\\nIt soothes the sensitive tissues inside the nose, which can assuage a bout of rhinitis or allergies.\\nIt is beneficial in dealing with asthmatic conditions and making breathing easier.\\nIt reduces tinnitus and middle ear infections.\\nIt helps abate sinusitis or migraine attack.\\nIt can alleviate upper respiratory complaints like sore throats, tonsils, and dry coughs.\\nIt can clear the eye ducts and improve vision.\\nClearing of nasal passages helps improve the sense of smell and thereby improves digestion.\\nPeople have experienced a reduction in their anger by practicing Jal Neti regularly.\\nIt helps improve the quality of your meditation.","precautions":"The nose should be dried properly after the process.\\nPeople with high blood pressure should be careful during this part. If one feels dizzy while drying the nose, then it should be done standing upright.\\nTake care that you do not leave any water in the nasal passages as it might cause an infection.\\nLike any other yogic practice, learn it from an expert practitioner."},{"type":"kapha","name":"Sutraneti Kriya","shortdescription":"Sutra means thread, and neti refers to a prescribed system or process. This is described as ?yoga for cleaning your sinuses and is thought to relieve a blocked nose, ease headache, sinusitis and so on.","steps":"Sit in Kagasana.\\nTilt the head slight back and insert thread or rubber catheter into one of the nostrils, whichever is more active at the moment. Gently push it through the nostril using both hands.\\nWhen the thread has come through to the back of the throat, put the index and middle fingers into the mouth; catch hold of the thread and take it out carefully and slowly through the mouth.\\nLeave a few inches of the thread hanging out of the nose.\\nNow, slowly and gently pull the thread out and do it twice or thrice initially.\\nThe same process can be practiced through other nostril.\\nAfter becoming mastering of the process, the thread can be moved forward and backward as per convenience and take out slowly through the mouth.","benefit_description":"Several benefits of this kriya are listed below: \\nThis is one of the best yoga exercises to clean the nasal region and is good in the prevention and management of cold, cough and sneezing.\\nWhen practised along with Jal neti, it has the power to cure all nasal related disorders like sinusitis, blockage of nasal passage, etc. \\nIt massages the membranes and sinus glands thereby strengthening them. \\nIt improves the function of tear duct and olfactory zone of the brain.\\nIt helps to stimulate the nerves and improves functions of the eyes and eyesight.\\nIt increases resistance to invasion by viruses and bacteria.\\nThis practice greatly assists in balancing the airflow of the two nostrils.\\nThe practice of this yoga engages the Kosas and stimulates the _j?_cakra, the psychic centre in the midbrain.","precautions":"This is thought to be a more advanced kriya than jal neti and it is generally recommended that you seek some guidance from an expert before attempting this on your own. \\nIt is also recommended that a good quality rubber tube be used for the purpose. It should be soft and comfortable; the prescribed thickness is about 4mm but to begin with an even thinner tube or sutra can be used. The thickness can be increased as one gets more proficient at Sutra Neti.\\nPerson having nose bleeding shouldn?t perform it.\\nIt should be avoided during sinus."},{"type":"kapha, pitta, vatta","name":"Kunjal Kriya","shortdescription":"Kunjal Kriya is one of the purification techniques of Hatha yoga, especially practiced for cleansing of the Esophagus and Stomach. It is also known as Vaman Dhauti.","steps":"While standing, drink a glass of water as quick as you can. Repeat the process until your stomach gets full of water.\\nNow comes a time when you will not be able to drink even a drop of water. It looks like everything will come out now. At this time, lean your upper body (trunk and head ) in the forwarding position.\\nIn this position open your mouth wide and insert 2 fingers in it. Use your longest fingers i.e. middle finger along with index finger and slide it on tongue gently in to-and-fro motion. After rubbing like this you will get an urge to vomit and suddenly the water will come out. As soon as the water comes out, remove your fingers immediately.\\nA few movements later, the flow of water will stop. Again, put your fingers in mouth and rub your tongue gently.\\nRepeat the same process until there is no more water left in the stomach.","benefit_description":"Kunjal Kriya gives an effective wash to our digestive system. Hence, It helps to eliminate all diseases caused by poor digestion. \\nimproves the strength of the entire digestive system.\\nIt removes that extra mucus from the esophagus and gives relief from cough.\\nIt also minimizes the poor breathing issue.\\nReduces the chances of the formation of kidney stones.","precautions":"Those who suffer from any chronic disabling disease, an active stomach ulcer, hernia of the stomach or abdomen, high blood pressure, heart disease or esophageal varices, should only practice kunjal under the guidance of a qualified yoga teacher or ashram."}],"food_types":[{"food_type":"Oils","favour_foods":"","avoid_foods":""},{"food_type":"Meat \u0026 Eggs","favour_foods":"","avoid_foods":""},{"food_type":"Legumes","favour_foods":"","avoid_foods":""},{"food_type":"Grains","favour_foods":"","avoid_foods":""},{"food_type":"Nuts \u0026 Seeds","favour_foods":"","avoid_foods":""},{"food_type":"Dairy","favour_foods":"","avoid_foods":""},{"food_type":"Vegetables","favour_foods":"","avoid_foods":""},{"food_type":"Fruits","favour_foods":"","avoid_foods":""},{"food_type":"Spices","favour_foods":"","avoid_foods":""},{"food_type":"Sweeteners","favour_foods":"","avoid_foods":""}],"sparshna_master":{},"sparshna_result_desc":[{"title":"Oxygen Saturation","short_description":"Measure of the amount of oxygen-carrying hemoglobin in the blood relative to the amount of hemoglobin not carrying oxygen.","what_it_means":""},{"title":"Body Mass Index","short_description":"Measure of body fat based on height and weight (kgs/sqm) that applies to adult men and women.","what_it_means":""},{"title":"Basal Metabolic Rate","short_description":"Calories burnt by an individual’s body at rest.","what_it_means":""}],"type":""}';
*/
      if (result != null) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>" + result.toString());
        List<String> data_auyrthm = result.toString().split('@');
        /* log(">>>>>>list" + data_auyrthm.length.toString());
        log(">>>>>>listdata" + data_auyrthm.toString());
        log("json decode result" + json.decode(data_auyrthm[0]).toString());*/
        Map<String, dynamic> map = json.decode(data_auyrthm[0]);
        /*  var data=[

        ];*/
        if (!map.containsKey("herbs")) {
          map["herbs"] = [];
        }

        log("json decode result" + map.toString());
        AyuRythmDataModel ayuRythmDataModel =
        AyuRythmDataModel.fromJson(json.decode(json.encode(map)));
        AyuRythmPostModel ayuRythmPostModel = AyuRythmPostModel(
            data: Data(
                type: null,
                foodTypes: null,
                herbs: null,
                kriya: null,
                meditation: null,
                mudra: null,
                pranayama: null,
                sparshnaMaster: null,
                sparshnaResultDesc: null,
                userId: null,
                yogasana: null),
            prakriti: null,
            sparshna: null,
            vikriti: null);
        List<Herbs> herbs = [Herbs(herbsList: "", herbType: "")];
        ayuRythmPostModel.data.type = ayuRythmDataModel.type;
        ayuRythmPostModel.data.userId = uhid;
        ayuRythmPostModel.data.kriya = ayuRythmDataModel.kriya;
        ayuRythmPostModel.data.foodTypes = ayuRythmDataModel.foodTypes;
        ayuRythmPostModel.data.meditation = ayuRythmDataModel.meditation;
        ayuRythmPostModel.data.mudra = ayuRythmDataModel.mudra;
        ayuRythmPostModel.data.pranayama = ayuRythmDataModel.pranayama;
        ayuRythmPostModel.data.sparshnaMaster =
            ayuRythmDataModel.sparshnaMaster;
        ayuRythmPostModel.data.sparshnaResultDesc =
            ayuRythmDataModel.sparshnaResultDesc;
        ayuRythmPostModel.data.herbs = ayuRythmDataModel.herbs;
        ayuRythmPostModel.data.yogasana = ayuRythmDataModel.yogasana;
        if (data_auyrthm[3] != "null" &&
            data_auyrthm[3].toString().trim() != "") {
          print("data_auyrthm[3]" + data_auyrthm[3].toString());
          ayuRythmPostModel.prakriti =
          /* Vikriti(kapha: "36.10",pitta: "25.00",vata: "38.90");*/
          Vikriti.fromJson(jsonDecode(data_auyrthm[3]));
        } else {
          ayuRythmPostModel.prakriti =
              Vikriti(kapha: "23", pitta: '23', vata: "34");
        }
        if (data_auyrthm[1] != "null" &&
            data_auyrthm[1].toString().trim() != "") {
          print("data_auyrthm[1]" + data_auyrthm[1].toString());
          ayuRythmPostModel.sparshna =
              Sparshna.fromJson(jsonDecode(data_auyrthm[1]));
          /* ayuRythmPostModel.sparshna = Sparshna(
              bala: "81",
              bmi: "81",
              bmr: "81",
              bpm: "81",
              dp: "81",
              gati: "Kapha",
              kapha2: "81",
              kath: "81",
              o2r: "81",
              pbreath: "81",
              pitta2: "81",
              rythm: "81",
              sp: "81",
              tbpm: "81",
              vata2: "81"
          );*/
        } else {
          ayuRythmPostModel.sparshna = Sparshna(
              bala: null,
              bmi: 23,
              bmr: 34,
              bpm: 34,
              dp: 34,
              gati: "JKS",
              kapha2: 34,
              kath: 34,
              o2r: 34,
              pbreath: 34,
              pitta2: 34,
              rythm: 34,
              sp: 34,
              tbpm: 34,
              vata2: 34);
        }
        if (data_auyrthm[2] != "null" &&
            data_auyrthm[2].toString().trim() != "") {
          print("data_auyrthm[2]" + data_auyrthm[2].toString());
          ayuRythmPostModel.vikriti =
          /* Vikriti(kapha: "36.10",pitta: "25.00",vata: "38.90");*/
          Vikriti.fromJson(jsonDecode(data_auyrthm[2]));
        } else {
          ayuRythmPostModel.vikriti =
              Vikriti(kapha: '56', pitta: "45", vata: "67");
        }
        log(">>>>>>>>>>>data_converted" +
            ayuRythmPostModel.toJson().toString());
        // log("APi>>>>>"+ApiFactory.API_AyuRythm);
        if (ayuRythmPostModel != null) {
          MyWidgets.showLoading(context);
          widget.model.POSTMETHOD(
              api: ApiFactory.API_AyuRythm,
              fun: (Map<String, dynamic> map) {
                Navigator.pop(context);
                log("Response>>>" + jsonEncode(map));
                if (map['code'] == "success") {
                  AppData.showInSnackDone(context, map['message']);
                } else {
                  AppData.showInSnackBar(context, map['message']);
                }
              },
              json: ayuRythmPostModel.toJson());
        }
      }
    } on PlatformException catch (e) {}
  }
  Widget dialogForSpiro(BuildContext context,int index) {
    print("Function call");
    dateOfBirth.text = "";
    patientHeight.text="";
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //_buildAboutText(),
              //_buildLogoAttribution(),
              Text(
                "FILL UP DETAILS",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                child: Divider(
                  height: 2,
                ),
                width: 180,
              ),
              Text(
                "(" + widget.model.patientList.patientName + ")",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              fromFieldNew("Height(In CM)", TextInputAction.next,
                  TextInputType.number, "name", patientHeight),
              Padding(
                padding:
                const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 0, top: 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "DOB:",
                      ),
                      onTap: () {
                        _selectDate1(context);
                      },
                      controller: dateOfBirth,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            age=0;
            dateOfBirth.text="";
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: const Text('CANCEL'),
        ),
        new FlatButton(
          onPressed: () {
            if(dateOfBirth.text == null || dateOfBirth.text.trim() ==""){
              AppData.showInSnackBar(context, "Please enter date of birth");
            }else if(patientHeight.text == null || patientHeight.text.trim() ==""){
              AppData.showInSnackBar(context, "Please enter height in CM");
            }
            else{
              var inputFormat = DateFormat('dd-MM-yyyy');
              var outputFormat = DateFormat('yyyy-MM-dd');
              var date1 = inputFormat.parse(dateOfBirth.text);

              age = (DateTime.parse(date1.toString()).difference(DateTime.now()).inDays/365 ).round().abs() ;
              widget.model.patientList.age=age.toString();
              print("age>>>"+age.toString());


              if(age <=0){
                AppData.showInSnackBar(context, "age should be greater than one");
              }else if(testName1[index].length <=0 ||  venderName[index].trim() ==""){
                AppData.showInSnackBar(context, "Please select at least one test");
              }else if(dateofBirth1 == null || dateofBirth1.trim() ==""){
                AppData.showInSnackBar(context, "please select Date of birth");
              }else{
                String val = widget.model.patientList.patientName +
                    "," +
                    widget.model.patientList.patientName +
                    "," +
                    widget.model.patientList.gender +
                    "," +
                    patientHeight.text +
                    "," +
                    "20" +
                    "," +
                    widget.model.patientList.patientId +
                    "," +
                    age.toString() +
                    "," +
                    dateofBirth1;
                callSpiro(val);
                Navigator.of(context).pop();
              }

            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('0k'),
        ),
      ],
    );
  }

  Widget dialogForAyuruthm(BuildContext context,int index) {
    print("Function call");
    dateOfBirth.text = "";
    patientHeight.text="";
    patientWeight.text="";
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //_buildAboutText(),
              //_buildLogoAttribution(),
              Text(
                "FILL UP DETAILS",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                child: Divider(
                  height: 2,
                ),
                width: 180,
              ),
              Text(
                "(" + widget.model.patientList.patientName + ")",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              fromFieldNew("Height(In CM)", TextInputAction.next,
                  TextInputType.number, "name", patientHeight),
              fromFieldNew("Weight(In KG)", TextInputAction.next,
                  TextInputType.number, "name", patientWeight),
              Padding(
                padding:
                const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 0, top: 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "DOB:",
                      ),
                      onTap: () {
                        _selectDate1(context);
                      },
                      controller: dateOfBirth,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            age=0;
            dateOfBirth.text="";
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: const Text('CANCEL'),
        ),
        new FlatButton(
          onPressed: () {
            if(dateOfBirth.text == null || dateOfBirth.text.trim() ==""){
              AppData.showInSnackBar(context, "Please enter date of birth");
            }else if(patientHeight.text == null || patientHeight.text.trim() ==""){
              AppData.showInSnackBar(context, "Please enter height in CM");
            }else if(patientWeight.text == null || patientWeight.text.trim() ==""){
              AppData.showInSnackBar(context, "Please enter weight in kg");
            }
            else{
              var inputFormat = DateFormat('dd-MM-yyyy');
              var outputFormat = DateFormat('yyyy-MM-dd');
              var date1 = inputFormat.parse(dateOfBirth.text);

              age = (DateTime.parse(date1.toString()).difference(DateTime.now()).inDays/365 ).round().abs() ;
              widget.model.patientList.age=age.toString();
              print("age>>>"+age.toString());


              if(age <=0){
                AppData.showInSnackBar(context, "age should be greater than one");
              }else if(testName1[index].length <=0 ||  venderName[index].trim() ==""){
                AppData.showInSnackBar(context, "Please select at least one test");
              }else{
                String mapping = widget.model.patientList.patientId.trim() +
                    "," +
                    widget.model.patientList.age.toString().trim() +
                    "," +
                    patientHeight.text +
                    "," +
                    patientWeight.text +
                    "," +
                    widget.model.patientList. gender??"Other";
                callAyurythm(mapping.trim(), widget.model.patientList.patientId.trim());

                Navigator.of(context).pop();
              }

            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('0k'),
        ),
      ],
    );
  }

  postFromWritzo(FormData formData, String Url) async {
    /*MyWidgets.showLoading(context);*/
    log("API call>>>>>>>>>>>" + Url);
    try {
      Response response;
      response = await dio.post(
        Url,
        data: formData,
        onSendProgress: (received, total) {
          if (total != -1) {
            setState(() {
              print((received / total * 100).toStringAsFixed(0) + '%');
            });
            print((received / total * 100).toStringAsFixed(0) + '%');
          }
        },
      );
      // Navigator.pop(context);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("value" + jsonEncode(response.data));
        if (response.data["code"] == "success") {
          print("Data Saved Successfully");
          log("Data Saved Successfully");
          AppData.showInSnackDone(context, "Data Saved Successfully");
          Navigator.pop(context, true);
        } else {
          log("Something went wrong ");
        }
      } else {
        Navigator.pop(context);
        log("Something went wrong");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        log("Dio Error" + jsonEncode(e.response.data).toString());
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        log("Dio Error" + jsonEncode(e.response.data).toString());
      }
      if (e.type == DioErrorType.DEFAULT) {
        log("Dio Error" + jsonEncode(e.response?.data ?? "").toString());
      }
      if (e.type == DioErrorType.RESPONSE) {
        log("Dio Error" + jsonEncode(e.response.data).toString());
      }
    }
  }
  Future<void> _callWritzo(String data) async {
    try {
      if (await Permission.storage.request().isGranted) {
        print("<<>>>>>writzoData>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" +
            data);
        Directory directory = await getExternalStorageDirectory();
        final Directory folder = Directory(directory.path + "/writzoFiles");
        if (!await folder.exists()) {
          folder.create();
        }
        log(folder.path);
        String data1 = data + "," + "${folder.path}";
        log("Whole Dataa>>>>>>" + data1);
        dynamic result = await platform.invokeMethod('writzo', data1);
        if (result != null) {
          try {
            WritzoReceiveModel writzoReceiveModel =
            WritzoReceiveModel.fromJson(json.decode(result));
            // AppData.showInSnackDone1(context, result);
            log("post data>>>>>" + writzoReceiveModel.toJson().toString());
            List<ScreeningDetails> document = [];
            List<ScreeningDetails> value = [];
            var formData = FormData();
            formData.fields
                .add(MapEntry("patientId", writzoReceiveModel.patientId));
            formData.fields.add(MapEntry("screeningDate", "1654253238098"));
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                File(writzoReceiveModel.screeningDetails[2].result).path);
            var count = 0;
            writzoReceiveModel.screeningDetails.forEach((element) {
              if (element.type == "file") {
                document.add(new ScreeningDetails(
                    type: element.type,
                    vitalName: element.vitalName,
                    result: /* (AppData.getExt(element.result) !='pdf')?  createPdf(File(element.result),count):*/
                    File(element.result).path));
                log(">>>>>>path" + File(element.result).path);
                count++;
              } else {
                value.add(element);
              }
            });
            log(">>>>>>>>>>>>>>>>>>>>file data" +
                AppData.getExt(document[0].result));
            for (int i = 0; i < document.length; i++) {
              formData.fields.add(MapEntry(
                  "fileDetails[${i.toString()}].key", document[i].vitalName));
              formData.fields.add(MapEntry("fileDetails[${i.toString()}].ext",
                  AppData.getExt(document[i].result)));
              formData.files.add(MapEntry(
                  "fileDetails[${i.toString()}].file",
                  MultipartFile.fromFileSync(
                    document[i].result,
                    filename: document[i].result,
                  )));
            }
            for (int i = 0; i < value.length; i++) {
              formData.fields.add(MapEntry(
                  "screeningDetails[${i.toString()}].vitalName",
                  value[i].vitalName));
              formData.fields.add(MapEntry(
                  "screeningDetails[${i.toString()}].result", value[i].result));
              formData.fields.add(MapEntry(
                  "screeningDetails[${i.toString()}].type", value[i].type));
            }

            postFromWritzo(formData, ApiFactory.API_Writzo);
          } catch (e) {
            log(e.toString());
            AppData.showInSnackDone(context, e.toString());
          }
        }
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
        AppData.showInSnackBar(context, "Storage Permission Required");
      } else if (await Permission.storage.request().isDenied) {
        AppData.showInSnackBar(context, "Storage Permission Required");
        await Permission.storage.request();
      }
    } on PlatformException catch (e) {}
  }
  Future<void> callSpiro(String val) async {
    try {
      /* String val = body.patientName+","+body.patientName+","+body.gender+","+"55"+","+"20"+","+body.regNo;*/
      if (await Permission.storage.request().isGranted) {
        await AppData.channel.invokeMethod('intentTest', val);
        AppData.showInSnackBar(context, "Permission Granted");
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
        AppData.showInSnackBar(context, "Storage Permission Required");
      } else if (await Permission.storage.request().isDenied) {
        AppData.showInSnackBar(context, "Storage Permission Required");
        await Permission.storage.request();
      }
    } on PlatformException catch (e) {}
  }
  callApp(String venderName){
    if(venderName.trim() == "WRIZTO"){
      print("Writzocall >>>>>>>>>>>>>>jatin");

      String mapping = Aes.encrypt(widget.model.patientList.patientId.trim()) +
          "," +
          widget.model.patientList.age.toString().trim() +
          "," +
          widget.model.patientList.gender??"Other" +
          "," +
          Aes.encrypt(widget.model.patientList.patientName);
      _callWritzo(mapping);
    }else if(venderName.trim() == "Safiey"){
      String val = widget.model.patientList.patientName +
          "," +
          widget.model.patientList.patientName +
          "," +
          widget.model.patientList.gender +
          "," +
          patientHeight.text +
          "," +
          "20" +
          "," +
          widget.model.patientList.patientId +
          "," +
          age.toString() +
          "," +
          dateofBirth1;
      callSpiro(val);

    }else{

    }


    //  widget.model.patientList.patientId

  }

}

