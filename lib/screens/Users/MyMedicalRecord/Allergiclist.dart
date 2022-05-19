import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AllergicModel.dart' as allergic;
import 'package:user/models/AllergicPostModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class AllergicListList extends StatefulWidget {
  MainModel model;
  static KeyvalueModel nameModel = null;
  static KeyvalueModel typeModel = null;
  static KeyvalueModel severitylistModel = null;

  AllergicListList({Key key, this.model}) : super(key: key);

  @override
  _AllergicListListState createState() => _AllergicListListState();
}

class _AllergicListListState extends State<AllergicListList> {
  var selectedMinValue;
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];
  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();

  bool isShown = true;
  List<KeyvalueModel> severitylist = [
    KeyvalueModel(name: "High", key: "High"),
    KeyvalueModel(name: "Medium", key: "Medium"),
    KeyvalueModel(name: "Low", key: "Low"),
  ];
  LoginResponse1 loginResponse;
  bool isDataNoFound = false;
  allergic.AllergicModel allergicModel;
  bool isdata = true;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callAPI();
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.ALLERGY_LIST + loginResponse.body.user,
        //userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              allergicModel = allergic.AllergicModel.fromJson(map);
              isdata=false;
            } else {
              setState(() {
                isdata=false;
               // AppData.showInSnackBar(context, msg);
              });
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppData.kPrimaryColor,
              title: Text(MyLocalizations.of(context).text("ALLERGIC")),
              /* leading: Icon(
              Icons.menu,
            ),*/
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        dialogaddnomination(context);
                        /* showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            dialogaddnomination(context),
                      );*/
                        // callAPI();
                      },
                      child: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 26.0,
                      ),
                    )),
                /*Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                        Icons.more_vert
                    ),
                  )
              ),*/
              ],
            ),
            body: isdata == true
                ? Container(
            child:
            Center(
            child: CircularProgressIndicator(
            backgroundColor: AppData.matruColor,
            ),
            )
            )

                : allergicModel == null
                    ?  Container(
              child: Center(
                  child: Image.asset("assets/NoRecordFound.png",
                    // height: 25,
                  )
              ),
            )
                    : Container(
                        child: SingleChildScrollView(
                          child: (allergicModel != null)
                              ? ListView.builder(
                                   physics: NeverScrollableScrollPhysics(),
                                  // controller: _scrollController,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    if (i == allergicModel.body.length) {
                                      return (allergicModel.body.length % 10 == 0)
                                          ? CupertinoActivityIndicator()
                                          : Container();
                                    }
                                    allergic.Body body = allergicModel.body[i];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, top: 5),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        shadowColor: Colors.grey,
                                        elevation: 10,
                                        child: ClipPath(
                                          clipper: ShapeBorderClipper(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5))),
                                          child: Container(
                                              /*height: 100,*/
                                              decoration: (i % 2 == 0)
                                                  ? BoxDecoration(
                                                      border: Border(
                                                          left: BorderSide(
                                                              color: AppData
                                                                  .kPrimaryRedColor,
                                                              width: 5)))
                                                  : BoxDecoration(
                                                      border: Border(
                                                          left: BorderSide(
                                                              color: AppData
                                                                  .kPrimaryColor,
                                                              width: 5))
                                              ),
                                              width: double.maxFinite,
                                              /*  margin: const EdgeInsets.only(top: 6.0),*/

                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 120,
                                                                    child:  Text(
                                                                      MyLocalizations.of(
                                                                          context)
                                                                          .text(
                                                                          "NAME"),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 15,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    body.allnameid ??
                                                                        "N/A",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 15),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 120,
                                                                    child: Text(
                                                                      MyLocalizations.of(
                                                                              context)
                                                                          .text(
                                                                              "ALLERGEN"),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 15,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    body.alltypeid??
                                                                        "N/A",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 15),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 120,
                                                                    child: Text(
                                                                      MyLocalizations.of(
                                                                              context)
                                                                          .text(
                                                                              "SEVERTY"),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 15,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    body.severity ??
                                                                        "N/A",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 15),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 120,
                                                                    child: Text(
                                                                      MyLocalizations.of(
                                                                              context)
                                                                          .text(
                                                                              "REACTION"),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 15,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    body.reaction ??
                                                                        "N/A",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 15),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 120,
                                                                    child: Text(
                                                                      MyLocalizations.of(
                                                                              context)
                                                                          .text(
                                                                              "UPDATED_BY"),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 15,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 150,
                                                                    child: Text(
                                                                      body.updatedby ??
                                                                          "N/A",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 15),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              allergicdisplayDialog(
                                                                  context, allergicModel, i);
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.edit,
                                                            size: 20,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: allergicModel.body.length,
                                )
                              : Container(),
                        ),
                      )
            /*: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: (isDataNoFound) ? Text("Data Not Found") : callAPI(),
                ),*/
            ),
        (isShown)?Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.black54,
          child: MaterialButton(
            onPressed: () {
              setState(() {
                isShown = false;
              });
            },
          ),
        ):Container(),
        Positioned(
            right: 25,
            top: 20,
            child: Visibility(
              visible: isShown,
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      isShown = false;
                    });
                  },
                  enableFeedback: false,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Visibility(
                      visible: isShown,
                      child: SafeArea(
                          child:
                          Image.asset("assets/images/indication.png")))),
            ))
      ],
    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        // Navigator.pushNamed(context, "/otpView");
        //}
      },
    );
  }

  Future<void> dialogaddnomination(BuildContext context) async {
    AllergicListList.typeModel=null;
    AllergicListList.nameModel=null;
    AllergicListList.severitylistModel=null;
    textEditingController[0].text="";
    textEditingController[1].text="";


    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //title: Text('TextField in Dialog'),
            insetPadding: EdgeInsets.zero,
            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(MyLocalizations.of(context).text("ADD_ALLERGIC"),
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),/*Text(
                                  MyLocalizations.of(context)
                                      .text("ADD_ALLERGIC"),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),*/
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DropDown.networkDropdownGetpartUser1(
                                  MyLocalizations.of(context).text("NAME"),
                                  ApiFactory.TYPE_API,
                                  "typelist",
                                  Icons.location_on_rounded,
                                  23.0, (KeyvalueModel data) {
                                setState(() {
                                  print(ApiFactory.TYPE_API);
                                  AllergicListList.typeModel = data;
                                });
                              }),
                              DropDown.networkDropdownGetpartUser1(
                                  MyLocalizations.of(context).text("ALLERGEN"),
                                  ApiFactory.NAME_API,
                                  "namelistt",
                                  Icons.location_on_rounded,
                                  23.0, (KeyvalueModel data) {
                                 setState(() {
                                  print(ApiFactory.NAME_API);
                                  AllergicListList.nameModel = data;
                                });
                              }),
                              DropDown.networkDrop(
                                  MyLocalizations.of(context).text("SEVERTY"),
                                  "SEVERITY",
                                  severitylist, (KeyvalueModel data) {
                                setState(() {
                                  AllergicListList.severitylistModel = data;
                                });
                              }),
                              SizedBox(
                                height: 8,
                              ),
                              formField(
                                  0,
                                  MyLocalizations.of(context).text("REACTION"),
                                  fnode1,
                                  fnode2),
                              SizedBox(
                                height: 8,
                              ),
                              formField(
                                  1,
                                  MyLocalizations.of(context)
                                      .text("UPDATED_BY"),
                                  fnode2,
                                  null),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
            textColor: AppData.kPrimaryRedColor,
            child:Text(MyLocalizations.of(context).text("CANCEL"),
          ),
                onPressed: () {
                  setState(() {
             /* Navigator.of(context).pop();*/
                    AllergicListList.typeModel=null;
                    AllergicListList.nameModel=null;
                    AllergicListList.severitylistModel=null;
                    textEditingController[0].text = "";
                    textEditingController[1].text = "";
                    callAPI();
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
              MyLocalizations.of(context).text("SUBMIT"),
          //style: TextStyle(color: Colors.grey),
          style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {
                    if (AllergicListList.typeModel == null ||
                        AllergicListList.typeModel == "") {
                      AppData.showInSnackBar(context, "Please select name ");
                    } else if (AllergicListList.nameModel == null ||
                        AllergicListList.nameModel == "") {
                      AppData.showInSnackBar(context, "Please select allergen ");
                    } else if (AllergicListList.severitylistModel == null ||
                        AllergicListList.severitylistModel == "") {
                      AppData.showInSnackBar(
                          context, "Please select severity ");
                    } else if (textEditingController[0].text.trim() == "" ||
                        textEditingController[0].text.trim() == null) {
                      FocusScope.of(context).requestFocus(fnode1);
                      AppData.showInSnackBar(context, "Please enter reaction");
                    } else if (textEditingController[0].text.trim() != "" &&  textEditingController[0].text.trim().length <= 2) {
                      FocusScope.of(context).requestFocus(fnode1);
                      AppData.showInSnackBar(context, "Please enter valid reaction");
                    } else if (textEditingController[1].text.trim() == "" ||
                        textEditingController[1].text.trim() == null) {
                      FocusScope.of(context).requestFocus(fnode2);
                      AppData.showInSnackBar(
                          context, "Please enter updated by");
                    } else if ( textEditingController[1].text.trim() != "" &&  textEditingController[1].text.trim().length <= 2) {
                      FocusScope.of(context).requestFocus(fnode2);
                      AppData.showInSnackBar(context, "Please enter valid name");
                    } else {
                      MyWidgets.showLoading(context);
                      AllergicPostModel allergicmodel = AllergicPostModel();
                      allergicmodel.userid = loginResponse.body.user;
                      allergicmodel.allnameid = AllergicListList.nameModel.key;
                      allergicmodel.alltypeid = AllergicListList.typeModel.key;
                      allergicmodel.severity =
                          AllergicListList.severitylistModel.key;
                      allergicmodel.reaction = textEditingController[0].text;
                      allergicmodel.updatedby = textEditingController[1].text;
                      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                          allergicmodel.toJson().toString());
                      widget.model.POSTMETHOD2(
                        api: ApiFactory.ALLERGIC_POST,
                        json: allergicmodel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          setState(() {
                            if (map[Const.STATUS1] == Const.SUCCESS) {
                              Navigator.pop(context);
                              callAPI();
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);
                            } else {
                              callAPI();
                              AppData.showInSnackBar(
                                  context, map[Const.MESSAGE]);
                            }
                          });
                        },
                      );
                      //AppData.showInSnackBar(context, "add Successfully");
                    }
                  });
                },
              ),
            ],
          );
        });
  }

  /*Widget dialogaddnomination(BuildContext context) {

    AllergicListList.typeModel=null;
    AllergicListList.nameModel=null;
    AllergicListList.severitylistModel=null;
    textEditingController[0].text = "";
    textEditingController[1].text = "";


    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.86,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //_buildAboutText(),
                  //_buildLogoAttribution(),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(MyLocalizations.of(context).text("ADD_ALLERGIC"),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropDown.networkDropdownGetpartUser1(MyLocalizations.of(context).text("NAME"),
                            ApiFactory.TYPE_API,
                            "typelist",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.TYPE_API);
                            AllergicListList.typeModel = data;
                          });
                        }),
                        */
  /*SizedBox(
                          height: 5,
                        ),*/
  /*
                        DropDown.networkDropdownGetpartUser1(
                            MyLocalizations.of(context)
                                .text("ALLERGEN") ,
                            ApiFactory.NAME_API,
                            "namelist",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.NAME_API);
                            AllergicListList.nameModel = data;
                          });
                        }),
                       */ /* SizedBox(
                          height: 5,
                        ),*/
  /*
                        DropDown.networkDrop(
                            MyLocalizations.of(context)
                                .text("SEVERTY") ,
                            "SEVERITY", severitylist,
                            (KeyvalueModel data) {
                          setState(() {
                            AllergicListList.severitylistModel = data;
                          });
                        }),
                        SizedBox(
                          height: 8,
                        ),
                        formField(0,MyLocalizations.of(context).text("REACTION"),fnode1,fnode2),
                        SizedBox(
                          height: 8,
                        ),
                        formField(1,MyLocalizations.of(context).text("UPDATED_BY"),fnode2,null),
                      ],
                    ),
                  ),

                  // fromAddress(0, "Remark", TextInputAction.next,
                  //     TextInputType.text, "remark"),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            */
  /*AllergicListList.nameModel.key = "";
            AllergicListList.typeModel.key = "";
            AllergicListList.severitylistModel.key = "";
            textEditingController[0].text = "";
            textEditingController[1].text = "";*/
  /*
            // textEditingController[0].text = "";
          },
          textColor: Theme.of(context).primaryColor,
          child:Text(MyLocalizations.of(context).text("CANCEL")),
        ),
        new FlatButton(
          child: Text(
            'OK',
            //style: TextStyle(color: Colors.grey),
            style: TextStyle(color: AppData.matruColor),
          ),
          onPressed: () {
          setState(() {
            if (AllergicListList.typeModel == null ||
                AllergicListList.typeModel == "") {
              AppData.showInSnackBar(context, "Please select Name ");
            } else if (AllergicListList.nameModel == null ||
                AllergicListList.nameModel == "") {
              AppData.showInSnackBar(context, "Please select Type ");
            } else if (AllergicListList.severitylistModel == null ||
                AllergicListList.severitylistModel == "") {
              AppData.showInSnackBar(context, "Please select Severity ");
            } else if (textEditingController[0].text == "" ||
                textEditingController[0].text == null) {
              FocusScope.of(context).requestFocus(fnode1);
              AppData.showInSnackBar(context, "Please enter Reaction");
            } else if (textEditingController[1].text == "" ||
                textEditingController[1].text == null) {
              FocusScope.of(context).requestFocus(fnode2);
              AppData.showInSnackBar(context, "Please enter Updated by");


            } else {
              MyWidgets.showLoading(context);
              AllergicPostModel allergicmodel = AllergicPostModel();
              allergicmodel.userid = loginResponse.body.user;
              allergicmodel.allnameid = AllergicListList.nameModel.key;
              allergicmodel.alltypeid = AllergicListList.typeModel.key;
              allergicmodel.severity = AllergicListList.severitylistModel.key;
              allergicmodel.reaction = textEditingController[0].text;
              allergicmodel.updatedby = textEditingController[1].text;
              print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                  allergicmodel.toJson().toString());
              widget.model.POSTMETHOD2(
                api: ApiFactory.ALLERGIC_POST,
                json: allergicmodel.toJson(),
                token: widget.model.token,
                fun: (Map<String, dynamic> map) {
                  Navigator.pop(context);
                  setState(() {
                    if (map[Const.STATUS1] == Const.SUCCESS) {
                      callAPI();
                      AppData.showInSnackDone(context, map[Const.MESSAGE]);
                    } else {
                      callAPI();
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  });
                },
                */
  /*fun: (Map<String, dynamic> map) {
                    Navigator.pop(context);
                    callAPI();
                    if (map[Const.STATUS] == Const.SUCCESS) {
                      AppData.showInSnackDone(context, map[Const.MESSAGE]);
                    } else {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  }*/
  /*
              );
              //AppData.showInSnackBar(context, "add Successfully");
            }

    });

           // Navigator.of(context).pop();

            // Navigator.of(context).pop();
            // AllergicListList.nameModel.key="";
            // AllergicListList.typeModel.key="";
            // AllergicListList.severitylistModel.key="";
            // textEditingController[1].text="";
            // textEditingController[2].text="";
          },

        ),
      ],
    );
  }*/

  Widget formField(
      int index, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          focusNode: currentfn,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z. ]")),
          ],
          onFieldSubmitted: (value) {
            AppData.fieldFocusChange(context, currentfn, nextFn);
          },
        ),
      ),
    );
  }

  popup(BuildContext context, String message) {
    return Alert(
        context: context,
        title: message,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              callAPI();
              //  Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  void allergicdisplayDialog(BuildContext context, allergic.AllergicModel allergicModel, int i) async {
    textEditingController[0].text =allergicModel.body[i].reaction;
    textEditingController[1].text =allergicModel.body[i].updatedby;
    if (allergicModel.body[i].allnameid == null ||
        allergicModel.body[i].allnameid == "") {
      AllergicListList.typeModel = null;
    } else {
      AllergicListList.typeModel = KeyvalueModel(
          key: allergicModel.body[i].allName,
          name: allergicModel.body[i].allnameid);
    }

    if (allergicModel.body[i].alltypeid == null ||
        allergicModel.body[i].alltypeid == "") {
      AllergicListList.nameModel = null;
    } else {
      AllergicListList.nameModel = KeyvalueModel(
          key: allergicModel.body[i].allFood,
          name: allergicModel.body[i].alltypeid);
    }

    if (allergicModel.body[i].severity == null ||
        allergicModel.body[i].severity == "") {
      AllergicListList.severitylistModel = null;
    } else {
      AllergicListList.severitylistModel = KeyvalueModel(
          key: allergicModel.body[i].severity,
          name: allergicModel.body[i].severity);
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            insetPadding: EdgeInsets.zero,

            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text( MyLocalizations.of(context).text("EDIT_ALLERGIC"),
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),/*Text(
                                  MyLocalizations.of(context)
                                      .text("ADD_ALLERGIC"),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),*/
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DropDown.networkDropdownGetpartUser1(
                                  MyLocalizations.of(context).text("NAME"),
                                  ApiFactory.TYPE_API,
                                  "namelist",
                                  Icons.location_on_rounded,
                                  23.0, (KeyvalueModel data) {
                                setState(() {
                                  print(ApiFactory.TYPE_API);
                                  AllergicListList.typeModel = data;
                                  AllergicListList.typeModel = data.key;
                                });
                              }),
                              DropDown.networkDropdownGetpartUser1(
                                  MyLocalizations.of(context).text("ALLERGEN"),
                                  ApiFactory.NAME_API,
                                  "allergen",
                                  Icons.location_on_rounded,
                                  23.0, (KeyvalueModel data) {
                                setState(() {
                                  print(ApiFactory.NAME_API);
                                  AllergicListList.nameModel = data;
                                  AllergicListList.nameModel = data.key;
                                });
                              }),
                              DropDown.networkDrop(
                                  MyLocalizations.of(context).text("SEVERTY"),
                                  "SEVERITY",
                                  severitylist, (KeyvalueModel data) {
                                setState(() {
                                  AllergicListList.severitylistModel = data;
                                  AllergicListList.severitylistModel = data.key;
                                });
                              }),
                              SizedBox(
                                height: 8,
                              ),
                              formField(
                                  0,
                                  MyLocalizations.of(context).text("REACTION"),
                                  fnode1,
                                  fnode2),
                              SizedBox(
                                height: 8,
                              ),
                              formField(
                                  1,
                                  MyLocalizations.of(context)
                                      .text("UPDATED_BY"),
                                  fnode2,
                                  null),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                textColor: AppData.kPrimaryRedColor,
                child:Text(MyLocalizations.of(context).text("CANCEL"),
                ),
                onPressed: () {
                  setState(() {
                    /* Navigator.of(context).pop();*/
                    /*AllergicListList.typeModel=null;
                    AllergicListList.nameModel=null;
                    AllergicListList.severitylistModel=null;
                    textEditingController[0].text = "";
                    textEditingController[1].text = "";
                    callAPI();*/
                    callAPI();
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  MyLocalizations.of(context).text("SUBMIT"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {
                    if (AllergicListList.typeModel == null ||
                        AllergicListList.typeModel == "") {
                      AppData.showInSnackBar(context, "Please select Name ");
                    } else if (AllergicListList.nameModel == null ||
                        AllergicListList.nameModel == "") {
                      AppData.showInSnackBar(context, "Please select Allergen ");
                    } else if (AllergicListList.severitylistModel == null ||
                        AllergicListList.severitylistModel == "") {
                      AppData.showInSnackBar(
                          context, "Please select Severity ");
                    } else if (textEditingController[0].text == "" ||
                        textEditingController[0].text == null) {
                      FocusScope.of(context).requestFocus(fnode1);
                      AppData.showInSnackBar(context, "Please enter Reaction");
                    } else if (textEditingController[0].text != "" &&  textEditingController[0].text.length <= 2) {
                      FocusScope.of(context).requestFocus(fnode1);
                      AppData.showInSnackBar(context, "Please enter valid Reaction");
                    } else if (textEditingController[1].text == "" ||
                        textEditingController[1].text == null) {
                      FocusScope.of(context).requestFocus(fnode2);
                      AppData.showInSnackBar(
                          context, "Please enter Updated by");
                    } /*else if ( textEditingController[1].text != "" &&  textEditingController[1].text.length <= 2) {
                      FocusScope.of(context).requestFocus(fnode2);
                      AppData.showInSnackBar(context, "Please enter valid Updated by");
                    }*/ else {
                      MyWidgets.showLoading(context);
                      AllergicPostModel allergicmodel = AllergicPostModel();
                      allergicmodel.userid = loginResponse.body.user;
                      allergicmodel.allnameid = AllergicListList.nameModel.key;
                      allergicmodel.alltypeid = AllergicListList.typeModel.key;
                      allergicmodel.severity = AllergicListList.severitylistModel.key;
                      allergicmodel.reaction = textEditingController[0].text;
                      allergicmodel.updatedby = textEditingController[1].text;
                      allergicmodel.id = allergicModel.body[i].id;

                      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                          allergicmodel.toJson().toString());
                      widget.model.POSTMETHOD2(
                        api: ApiFactory.ALLERGIC_POST,
                        json: allergicmodel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          setState(() {
                            if (map[Const.STATUS1] == Const.SUCCESS) {
                              Navigator.pop(context);
                              callAPI();
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);
                            } else {
                              callAPI();
                              AppData.showInSnackBar(
                                  context, map[Const.MESSAGE]);
                            }
                          });
                        },
                      );
                      //AppData.showInSnackBar(context, "add Successfully");
                    }
                  });
                },
              ),
            ],
          );
        });

  }
}
