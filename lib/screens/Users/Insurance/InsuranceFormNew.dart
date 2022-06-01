import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/AddOrganDonModel.dart';
import 'package:user/models/AutocompleteDTO.dart';
import 'package:user/models/InsurancePincodeModel.dart' as ins;
import 'package:user/models/EmergencyMessageModel.dart';
import 'package:user/models/InsurancePincodeModel.dart';
import 'package:user/models/ProfileModel.dart';
import 'package:user/models/TissueModel.dart' as tissue;
import 'package:user/models/OrganModel.dart' as organ;
import 'package:user/models/OrganModel.dart';
import 'package:user/models/TissueModel.dart';
import 'package:user/models/NomineeModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';
import 'package:xml2json/xml2json.dart';
import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';
import 'package:http/http.dart' as http;


// ignore: must_be_immutable
class InsuranceFormNew extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel countryModel = null;
  static KeyvalueModel cityModel = null;
  static KeyvalueModel bloodgroupModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel genderModel2 = null;
  static KeyvalueModel relationmodel = null;
  static KeyvalueModel materialmodel = null;
  static KeyvalueModel titleModel = null;
  static KeyvalueModel insurancetitlemodel = null;
  static KeyvalueModel insurancepincodemodel = null;
  static KeyvalueModel insurancemaritalmodel = null;
  static KeyvalueModel insuranceoccupationmodel = null;
  static KeyvalueModel insuranceoccupationmodel1 = null;
  static List<KeyvalueModel> UserType1 = [];

  InsuranceFormNew({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  InsuranceFormNewState createState() => InsuranceFormNewState();
}

enum PayMode1 { cash, cheque, online }

class InsuranceFormNewState extends State<InsuranceFormNew> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  bool isChecked = false;
  bool isTissueChecked = false;
  DateTime selectedDate = DateTime.now();
   DateTime selectedDate1 = DateTime.now();
  PayMode1 payMode1 = PayMode1.cash;
  ProfileModel patientProfileModel;
  EmergencyMessageModel emergencyMessageModel = EmergencyMessageModel();
  TextEditingController name = TextEditingController();
  String profilePath = null,
      idproof = null,
      idproof1 = null,
      idproof2 = null,
      idproof3 = null,
      labReport = null,
      helathCheckup = null;
  String extension;
  String extension1;
  String extension2;
  String extension3;
  File selectFile;
  File selectFile1;
  File selectFile2;
  File selectFile3;
  final ymd = new DateFormat('yyyy-MM-dd');
  final mdy = new DateFormat('MM/dd/yyyy');
  bool value = false;
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
  TextEditingController _message = TextEditingController();
  TextEditingController stdob = TextEditingController();
  TextEditingController nomdob = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController fromdtTxt = TextEditingController();
  TextEditingController todtTxt = TextEditingController();
  List<bool> error = [false, false, false, false, false, false];
  bool _isSignUpLoading = false;

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();

  TextEditingController _email = TextEditingController();
  FocusNode emailFocus_ = FocusNode();
  tissue.TissueModel tissueModel;
  List<tissue.Body> selectetissue = [];
  organ.OrganModel organModel;
  List<organ.Body> selectedorgan = [];
  List<NomineeModel> witnessModle = [];
  DateTime selectedStartDate;
  List<bool> dropdownError = [false, false, false];
  var color = Colors.black;
  var strokeWidth = 3.0;
  File _imageCertificate;
  bool selectGallery = false;
  var image;
  var pngBytes;
  String selectDob;
  KeyvalueModel selectedKey = null;
  KeyvalueModel selectedUser;
  KeyvalueModel selectedUser1;
  List<KeyvalueModel> UserType = [
    KeyvalueModel(key: "S", name: "S/O"),
    KeyvalueModel(key: "D", name: "D/O"),
    KeyvalueModel(key: "W", name: "W/O"),
  ];
  List<KeyvalueModel> UserType1 = [
    KeyvalueModel(key: "S", name: "S/O"),
    KeyvalueModel(key: "D", name: "D/O"),
    KeyvalueModel(key: "W", name: "W/O"),
  ];
  List<KeyvalueModel> _dropdownItems = [
    KeyvalueModel(key: "S", name: "S/O"),
    KeyvalueModel(key: "D", name: "D/O"),
    KeyvalueModel(key: "W", name: "W/O"),
  ];
  List<KeyvalueModel> _dropdownItems1 = [
    KeyvalueModel(key: "S", name: "S/O"),
    KeyvalueModel(key: "D", name: "D/O"),
    KeyvalueModel(key: "W", name: "W/O"),
  ];
  static String toDate(String date) {
    if (date != null && date != "") {
      DateTime formatter = new DateFormat("dd-MM-yyyy").parse(date);
      // final DateTime formatter =
      //DateFormat("yyyy-MM-dd\'T\'HH:mm:ss.SSSZ\'").parse(date);
      //DateFormat("dd/MM/yyyy").parse(date);
      DateFormat toNeed = DateFormat("dd/MM/yyyy");
      final String formatted = toNeed.format(formatter);
      return formatted;
    } else {
      return "";
    }
  }
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  String calculateTimeDif(String startDt) {
    // String format=formatter.format(DateTime.now());
    /*String a="2021-11-11T11:16:51.083Z";
    String b="2021-11-11T12:16:51.083Z";*/
    DateTime startDate = toDateFormat(startDt);
    DateTime current = DateTime.now();
    DateTime endDate = DateTime(current.year, current.month, current.day);
    //DateTime endDate=DateTime.parse(DateTime.now().toIso8601String());
    int days = endDate.difference(startDate).inDays;
    log("Start Date: " + startDate.toString());
    log("End Date: " + endDate.toString());
    log("Diff day: " + days.toString() + "\n\n\n");
    //double y=days/365;
    int year1= (days/365).toInt();
    log("Year day: "+year1.toString()+"\n\n\n");
    int restDays=0;
    int month=0;
    if(year1>0) {
      restDays = days - (year1 * 365);
      month=restDays%30;
    }

    return year1.toString()/*+" Years and "+month.toString()+" Month"*/;
    setState(() => year = year1.toString());
    return year1.toString() + " Years and " + month.toString() + " Month";
  }

  String calculateTimeDifOne(DateTime startDate) {
    // String format=formatter.format(DateTime.now());
    /*String a="2021-11-11T11:16:51.083Z";
    String b="2021-11-11T12:16:51.083Z";*/
    //DateTime startDate=toDateFormat(startDt);
    DateTime current = DateTime.now();
    DateTime endDate = DateTime(current.year, current.month, current.day);
    //DateTime endDate=DateTime.parse(DateTime.now().toIso8601String());
    int days = endDate.difference(startDate).inDays;
    log("Start Date: " + startDate.toString());
    log("End Date: " + endDate.toString());
    log("Diff day: " + days.toString() + "\n\n\n");

    //double y=days/365;
    int year1 = (days / 365).toInt();
    setState(() => year = year1.toString());
    log("Year day: " + year1.toString() + "\n\n\n");
    int restDays = 0;
    int month = 0;
    if (year1 > 0) {
      restDays = days - (year1 * 365);
      month = restDays % 30;
    }

    return year1.toString()/*+" Years "+month.toString()+" Month"*/;
  }

  static DateTime toDateFormat(String date) {
    final DateTime formatter = DateFormat("dd-MM-yyyy").parse(date);
    return formatter;
  }


  List<DropdownMenuItem<KeyvalueModel>> _dropdownMenuItems;
  KeyvalueModel _selectedItem;
  List<DropdownMenuItem<KeyvalueModel>> _dropdownMenuItems1;
  KeyvalueModel _selectedItem1;
  final df = new DateFormat('dd/MM/yyyy');
  bool ispartnercode = false;
  bool _checkbox = false;
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  bool _checkbox4 = false;
  bool _checkbox5 = false;
  bool _checkbox6 = false;
  bool _checkbox7 = false;
  bool _checkbox8 = false;
  bool _checkbox9 = false;
  bool _checkbox0 = false;
  String year;



  bool fromLogin = false;
  StreamSubscription _connectionChangeStream;
  bool isOnline = false;
  List<KeyvalueModel> genderList = [
    KeyvalueModel(name: "0.5", key: "1"),
    KeyvalueModel(name: "0.6", key: "2"),
    KeyvalueModel(name: "0.7", key: "3"),
  ];
  List<KeyvalueModel> districtList = [
    KeyvalueModel(name: "3", key: "1"),
    KeyvalueModel(name: "4", key: "1"),
    KeyvalueModel(name: "5", key: "1"),
    KeyvalueModel(name: "6", key: "1"),
  ];

  List<String> selectedOrganList = [];
  List<String> selectedTissueList = [];

  @override
  void initState() {
    _askPermissions(null);
    super.initState();
    InsuranceFormNew.districtModel = null;
    InsuranceFormNew.blockModel = null;
    InsuranceFormNew.bloodgroupModel = null;
    //DonorApplication.genderModel = null;
    selectedUser = UserType[0];
    selectedUser1 = UserType1[0];
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
    _dropdownMenuItems1 = buildDropDownMenuItems(_dropdownItems1);
    _selectedItem1 = _dropdownMenuItems1[0].value;
    /*setState(() {
      masterClass = widget.model.masterDataResponse;
    });
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    setState(() {
      isOnline = connectionStatus.hasConnection;
    });*/
    //organcallAPI();
    //tissuecallAPI();
    //profileAPI();
    //pincodeAPI();
  }

 /* pincodeAPI(){
    widget.model.GETMETHODCAL(api: ApiFactory.INSURANCE_PINCODE,
        fun:(Map<String, dynamic> map){
      setState(() {
        String msg = map[Const.MESSAGE];
        if (map[Const.CODE] == Const.SUCCESS){

        }

      });
        }
    )
  }*/



  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {

      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: Locale("en"),
      // initialDate: DateTime.now().subtract(Duration(days: 6570)),
      //firstDate: DateTime(1901, 1),
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 10000)),
      lastDate: DateTime.now(),/*add(Duration(days: 365))*/
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      // lastDate: DateTime.now()
      //     .subtract(Duration(days: 6570))
    ); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        selectedStartDate = picked;
        error[2] = false;
        stdob.value = TextEditingValue(text: df.format(picked));
      });
  }
  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: Locale("en"),
      // initialDate: DateTime.now().subtract(Duration(days: 6570)),
      //firstDate: DateTime(1901, 1),
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 10000)),
      lastDate: DateTime.now(),/*add(Duration(days: 365))*/
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      // lastDate: DateTime.now()
      //     .subtract(Duration(days: 6570))
    ); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        selectedStartDate = picked;
        error[2] = false;
        nomdob.value = TextEditingValue(text: df.format(picked));
        nomdob.text = mdy.format(picked);
      });
  }

  Future<List<ins.Body>> fetchSearchAutoComplete(String course_name) async {
    var dio = Dio();
    //Map<String, dynamic> postMap = {"course_name": course_name};
    final response = await dio.get(
      ApiFactory.INSURANCE_PINCODE + course_name,
    );

    if (response.statusCode == 200) {
      ins.InsurancePincodeModel model = ins.InsurancePincodeModel.fromJson(response.data);
      setState(() {
        //this.courcesDto = model;
      });
      return model.body;
    } else {
      setState(() {
        //isAnySearchFail = true;
      });
      throw Exception('Failed to load album');
    }
  }

  List<DropdownMenuItem<KeyvalueModel>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<KeyvalueModel>> items = List();
    for (KeyvalueModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<KeyvalueModel>> buildDropDownMenuItems1(
      List listItems) {
    List<DropdownMenuItem<KeyvalueModel>> items = List();
    for (KeyvalueModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  // profileAPI() {
  //   widget.model.GETMETHODCALL_TOKEN(
  //     api: ApiFactory.PATIENT_PROFILE + widget.model.loginResponse1.body.user,
  //     token: widget.model.token,
  //     fun: (Map<String, dynamic> map) {
  //       String msg = map[Const.MESSAGE];
  //       //String msg = map[Const.MESSAGE];
  //       if (map[Const.CODE] == Const.SUCCESS) {
  //         setState(() {
  //           log("Response from sagar>>>>>" + jsonEncode(map));
  //           patientProfileModel = ProfileModel.fromJson(map);
  //           textEditingController[0].text = patientProfileModel.body.fullName;
  //           textEditingController[2].text = patientProfileModel.body.dob;
  //
  //           //textEditingController[3].text=patientProfileModel.body.ageYears;
  //           textEditingController[4].text = patientProfileModel.body.mobile;
  //           textEditingController[5].text = patientProfileModel.body.email;
  //           textEditingController[6].text = patientProfileModel.body.address +
  //               " , " +
  //               patientProfileModel.body.pAddress;
  //           textEditingController[15].text = patientProfileModel.body.bloodGroup;
  //           //String dob=patientProfileModel.body.dob;
  //           textEditingController[3].value = TextEditingValue(
  //               text: calculateTimeDif(patientProfileModel.body.dob));
  //           //textEditingController[15].text=patientProfileModel.body.bloodGroupId;
  //         });
  //       } else {
  //         setState(() {
  //           //isDataNoFound = true;
  //         });
  //         /* Center(
  //           child: Text(
  //             'Data Not Found',
  //             style: TextStyle(fontSize: 12),
  //           ),
  //         );*/
  //         // AppData.showInSnackBar(context, msg);
  //       }
  //     },
  //   );
  // }
  void getContactDetails() async {
    // if (await FlutterContacts.requestPermission()) {
    //   // Get all contacts (lightly fetched)
    //   MyWidgets.showLoading(context);
    //   List<Contact> contacts = await FlutterContacts.getContacts(
    //       withProperties: true, withPhoto: true);
    //   Navigator.pop(context);

    //   _displayContact(context, contacts);
    //   /* if(contacts!=null && contacts.isNotEmpty) {

    //       contacts = await FlutterContacts.getContacts(
    //           withProperties: true, withPhoto: true);
    //       setState(() {});
    //       _displayContact(context, contacts);
    //   }else{
    //     _displayContact(context, contacts);
    //   }*/

    // }
    MyWidgets.showLoading(context);
    List<Contact> contacts = await ContactsService.getContacts();
    // log(jsonEncode(contacts[5].toMap()));
    _displayContact(context, contacts);
  }
  Future<void> _displayContact(BuildContext context, List<Contact> list) async {
    List<Contact> foundUser=[];
    foundUser=list;
    // List<Contact> myList;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            insetPadding: EdgeInsets.symmetric(horizontal: 3),
            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {

                void _runFilter(String enteredKeyword) {
                  List<Contact> results = [];
                  if (enteredKeyword.isEmpty) {
                    results = list;
                  } else {
                    results = list
                        .where((user) => user.displayName.toLowerCase()
                        .contains(enteredKeyword.toLowerCase()))
                        .toList();
                  }
                  setState(() {
                    foundUser = results;
                  });
                }
                return Container(
                  height: 400,
                  width: double.maxFinite-50,
                  child:(list!=null && list.isNotEmpty)?Column(

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          child: TextField(
                            onChanged: (value) => _runFilter(value),
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                hintText: "Search"),
                          ),
                        ),
                      ),
                      Expanded(
                        child:ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return ListTile(
                              title: Text(foundUser[i]?.displayName??""),
                              subtitle: Text((foundUser[i]?.phones[0]?.value??"")),
                              onTap: (){

                                log("Selected Response>>>"+list[i].toString());
                                log("Selected Response>>>"+list[i]?.phones[0]?.value??"");
                                widget.model.contMobileno=list[i]?.phones[0]?.value??"";

                                textEditingController[7].text=foundUser[i].displayName.toString();
                                //_mobile.text=list[i]?.phones[0]?.number.replaceAll("- ", "")??"".toString();

                                textEditingController[10].text=foundUser[i]?.phones[0]?.value.replaceAll(" ", "").replaceAll("-", "").replaceAll("+91", "")??"".replaceAll("+", "")??"".toString();
                                //_mobile.text=list[i]?.phones[0]?.number.replaceAll(" ":"", "").replaceAll("-", "")??"".toString();
                                Navigator.pop(context);
                                 Navigator.pop(context);
                              },
                            );
                          },
                          itemCount: foundUser.length,
                        ),
                      ),
                    ],
                  ):Container(),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text('CANCEL',
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  'SUBMIT',
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  // setState(() {
                  //   emergencyMessageModel = EmergencyMessageModel();
                  //   emergencyMessageModel.msg = _message.text;
                  //   emergencyMessageModel.userid = widget.model.user;
                  //
                  //   print("Value json>>" +
                  //       emergencyMessageModel.toJson().toString());
                  //   widget.model.POSTMETHOD_TOKEN(
                  //       api: ApiFactory.POST_EMERGENCY_MESSAGE,
                  //       json: emergencyMessageModel.toJson(),
                  //       token: widget.model.token,
                  //       fun: (Map<String, dynamic> map) {
                  //         //Navigator.pop(context);
                  //         if (map[Const.STATUS1] == Const.SUCCESS) {
                  //           // popup(context, map[Const.MESSAGE]);
                  //           Navigator.pop(context);
                  //           //callApi();
                  //           AppData.showInSnackDone(
                  //               context, map[Const.MESSAGE]);
                  //         } else {
                  //           // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  //         }
                  //       });
                  //   /*codeDialog = valueText;
                  //   Navigator.pop(context);*/
                  // });
                },
              ),
            ],
          );
        });
  }


  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        centerTitle: true,
        title: Text(
          "Insurance Form",
          //MyLocalizations.of(context).text("DONOR_APPLICATION"),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text("*  Aditya Birla Health Insurance",style: TextStyle(
                    fontSize: 20,color: Colors.blue),),
                SizedBox(height: 10),
              Form(
                 key: _formKey,
                  autovalidate: _autovalidate,
                child: 
                Column(children: [
                  formFieldPassPortno(0,"Customer Id (UHID)"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:
                    DropDown.
                    networkDropdown1(
                      // "TITLE"
                        MyLocalizations.of(context)
                            .text("TITLE"),
                        ApiFactory.INSURANCE_TITLE,
                        "insurancetitle",
                        Icons.person_rounded,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.INSURANCE_TITLE);
                        InsuranceFormNew.insurancetitlemodel = data;
                        //userModel.title = data.key;
                      });
                    }),
                  ),
                ),

                SizedBox(
                  height: 8,
                ),
                formField1(
                    1,
                    "First Name"),
            SizedBox(
              height: 8,),
                formField1(
                    2,
                    "Middle Name(Optional)"),

                SizedBox(
                  height: 8,
                ),
                formField1(
                    3,
                    "Last Name"),
                SizedBox(height: 8),
                dobBirth(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:DropDown.networkDropdown1(
                      //"Gender"
                        MyLocalizations.of(context)
                            .text("GENDER"),
                        ApiFactory.GENDER_API,
                        "gender",
                        Icons.wc_outlined,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.GENDER_API);
                        InsuranceFormNew.genderModel = data;
                        //userModel.gender = data.key;
                        // UserSignUpForm.cityModel = null;
                      });
                    }),
                  ),
                ),
                SizedBox(height: 8,),
                educationalQualification(4, "Educational Qualification"),
                SizedBox(height: 8,),
                formFieldemail(5, MyLocalizations.of(context).text("EMAILID")),
                SizedBox(height: 8,),
              /*  Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:
                    DropDown.networkDropdown1(
                      //"Gender"
                       "Insurance Pin Code",
                        ApiFactory.INSURANCE_PINCODE,
                        "insurancepincode",
                        Icons.wc_outlined,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.INSURANCE_PINCODE);
                        InsuranceFormNew.insurancepincodemodel = data;
                        //userModel.gender = data.key;
                        // UserSignUpForm.cityModel = null;
                      });
                    }),
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Material(
                    //elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(5),
                        border: Border.all(
                            color: Colors.black, width: 0.3),
                      ),
                      width: double.maxFinite,
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          style: TextStyle(color: Colors.black),
                          controller: pincode,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pin code',
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                                fontFamily: "Monte",
                                fontSize: 15,
                                color:AppData.hintColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                          ),
                          onSubmitted: (String value) {
                            if (value != "") {
                              /*widget.model.searchFilter = value;
                                    Navigator.pushNamed(context, "/searchResult");*/
                              //fetchSearchResult(value);
                            }
                            //AppData.showInSnackDone(context, value);
                          },
                        ),
                        getImmediateSuggestions: true,
                        suggestionsCallback: (pattern) async {
                          return (pattern != null)
                              ? await fetchSearchAutoComplete(pattern)
                              : null;
                        },
                        hideOnLoading: true,
                        itemBuilder: (context, ins.Body suggestion) {
                          return ListTile(
                            leading: Icon(Icons.search),
                            title: Text(suggestion.name),
                          );
                        },
                        onSuggestionSelected: (ins.Body suggestion) {
                          //widget.model.courceName = suggestion.courseSlug;
                          //Navigator.pushNamed(context, "/courceDetail1");
                          //Navigator.pop(context);
                        pincode.text=suggestion.name;
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 8),
                formFieldAadhaaerno(7, "Uid No"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:DropDown.networkDropdown1(
                        MyLocalizations.of(context).text("MARITAL_STATUS"),
                        ApiFactory.INSURANCE_MARITALSTATUS,
                        "insurancemarital",
                        Icons.wc_outlined,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.INSURANCE_MARITALSTATUS);
                        InsuranceFormNew.insurancemaritalmodel = data;
                      /*  patientProfileModel.body.mstausid =
                            data.key;
                        patientProfileModel.body.maritialstatus =
                            data.name;*/
                        //userModel.gender = data.key;
                        // UserSignUpForm.cityModel = null;
                      });
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:DropDown.networkDropdown1(
                        "Occupation",
                        ApiFactory.INSURANCE_OCCUPATION,
                        "insuranceoccupation",
                        Icons.wc_outlined,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.INSURANCE_OCCUPATION);
                        InsuranceFormNew.insuranceoccupationmodel = data;
                      /*  patientProfileModel.body.mstausid =
                            data.key;
                        patientProfileModel.body.maritialstatus =
                            data.name;*/
                        //userModel.gender = data.key;
                        // UserSignUpForm.cityModel = null;
                      });
                    }),
                  ),
                ),
          /*      SizedBox(height: 8),
                educationalQualification(8, "Occupation"),*/
                SizedBox(height: 8),
                formFieldPhoneNo(9,"Contact MobileNo", /*fnode13, fnode14*/),
                SizedBox(height: 8),
                stdLandlineNo(10,"Landline No", /*fnode13, fnode14*/),
                SizedBox(height: 8),
                panNo(11,"PAN No",TextInputType.number  /*fnode13, fnode14*/),
                SizedBox(height: 8),
                panNo(12,"Passport Number", TextInputType.number /*fnode13, fnode14*/),
                SizedBox(height: 8),
                panNo(13,"Contact Person", TextInputType.text /*fnode13, fnode14*/),
                SizedBox(height: 8),
                panNo(14,"Annual Income", TextInputType.number /*fnode13, fnode14*/),
                SizedBox(height: 8),
                panNo(15,"Remarks", TextInputType.text /*fnode13, fnode14*/),
              SizedBox(height: 8),
              fromDt(),
              toDt(),
               // panNo(16,"remarks", *//*fnode13, fnode14*//*),*/
                SizedBox(height: 8),
                homeAddressLine1(17,"Home Address Line1", TextInputType.text, /*fnode13, fnode14*/),
                SizedBox(height: 8),
                homeAddressLine1(18,"Home Address Line2", TextInputType.text, /*fnode13, fnode14*/),
                SizedBox(height: 8),
                homeAddressLine1(19,"Home Address Line3", TextInputType.text, /*fnode13, fnode14*/),
                SizedBox(height: 8),
                panNo(20,"Home PinCode", TextInputType.number /*fnode13, fnode14*/),
                SizedBox(height: 8),
                homeAddressLine1(21,"Home Area",TextInputType.text /*fnode13, fnode14*/),
                SizedBox(height: 8),
                formFieldPhoneNo(22,"Home Contact MobileNo", /*fnode13, fnode14*/),
                SizedBox(height: 8),
                formFieldPhoneNo(23,"home Contact MobileNo1", /*fnode13, fnode14*/),
                SizedBox(height: 8),
                stdLandlineNo(24,"Home STD Landline No", /*fnode13, fnode14*/),
                SizedBox(height: 8),
                homeAddressLine1(25,"Home Fax No", TextInputType.number /*fnode13, fnode14*/),
                SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                              value: this.value,
                              onChanged: (bool value) {
                                setState(() {
                                  this.value = value;
                                  if(this.value == true){
                                  textEditingController[27].text=textEditingController[17].text;
                                  textEditingController[28].text=textEditingController[18].text;
                                  textEditingController[29].text=textEditingController[19].text;
                                  textEditingController[30].text=textEditingController[20].text;
                                  textEditingController[31].text=textEditingController[21].text;
                                  }
                                  else{
                                  textEditingController[27].text="";
                                  textEditingController[28].text="";
                                  textEditingController[29].text="";
                                  textEditingController[30].text="";
                                  textEditingController[31].text="";
                                  }
                                 
                                });
                              }),
                              Text('Same As Home Address')
                  ],
                ),
                // homeAddressLine1(26,"Same As Home Address",TextInputType.text, /*fnode13, fnode14*/),
                SizedBox(height: 8),
                homeAddressLine1(27,"Mailing Address Line1", TextInputType.text, /*fnode13, fnode14*/),
                SizedBox(height: 8),
                homeAddressLine1(28,"Mailing  Address Line2",TextInputType.text, /*fnode13, fnode14*/),
                SizedBox(height: 8),
                homeAddressLine1(29,"Mailing Address Line3", TextInputType.text, /*fnode13, fnode14*/),
                SizedBox(height: 8),
                panNo(30,"Mailing PinCode", TextInputType.number /*fnode13, fnode14*/),
                SizedBox(height: 8),
                homeAddressLine1(31,"Mailing Area",TextInputType.text, /*fnode13, fnode14*/),
                SizedBox(height: 8),
                formFieldPhoneNo(32,"Mailing Contact Mobile No", /*fnode13, fnode14*/),
                SizedBox(height: 8),
                formFieldPhoneNo(33,"Mailing Contact Mobile No2", /*fnode13, fnode14*/),
                SizedBox(height: 8),
                stdLandlineNo(12,"Mailing STD Landline No", /*fnode13, fnode14*/),
                SizedBox(height: 8),
                stdLandlineNo(34,"Mailing STD Landline No2", /*fnode13, fnode14*/),
                SizedBox(height: 8),
                homeAddressLine1(35,"Mailing Fax No",TextInputType.number),
                SizedBox(height: 8),
                homeAddressLine1(36,"Bank Account Type", TextInputType.text,),
                SizedBox(height: 8),
                panNo(37,"Bank Account No", TextInputType.number),
                SizedBox(height: 8),
                panNo(38,"IFSC Code", TextInputType.text),
                SizedBox(height: 8),
                formFieldPinno(39,"GST IN"),
                SizedBox(height: 8),
                formFieldPinno(40,"GST Registration Status"),
                SizedBox(height: 8),
                panNo(41,"EIA AccountNo", TextInputType.number),
                 SizedBox(height: 8),
                panNo(53,"Sum Insured", TextInputType.number),
               /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.black26,
                    height: 40,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("PolicyCreationRequest",
                              // MyLocalizations.of(context).text("ADD_WITNESS"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        //Spacer(),

                      ],
                    ),
                  ),
                ),
                formFieldPinno(12,"Quotation Number"),
                SizedBox(height: 8),
                homeAddressLine1(12,"MasterPolicyNumber"),
                SizedBox(height: 8),
                panNo(12,"GroupID"),
                SizedBox(height: 8),
                panNo(12,"Product Code"),
                SizedBox(height: 8),
                panNo(12,"IntermediaryCode"),
                SizedBox(height: 8),
                panNo(12,"AutoRenewal"),
                SizedBox(height: 8),
                panNo(12,"IntermediaryBranchCode"),
                SizedBox(height: 8),
                homeAddressLine1(12,"BusinessSourceChannel"),
                SizedBox(height: 8),
                panNo(12,"AssignPolicy"),
                SizedBox(height: 8),
                formField1(1,"AssigneeName"),
                SizedBox(height: 8),
                panNo(1,"leadID"),
                SizedBox(height: 8),
                formField1(1,"Source Name"),
                SizedBox(height: 8),
                formField1(1,"Source Name"),
                panNo(12,"SPID"),
                SizedBox(height: 8),
                panNo(12,"TCN"),
                SizedBox(height: 8),
                panNo(12,"CRTNO"),
                SizedBox(height: 8),

*/
                SizedBox(height: 8),
                ],)
              ),
                
                formField1(12, MyLocalizations.of(context).text("DOCUMENT1")),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(MyLocalizations.of(context).text("UPLOAD_DOCUMENT1")
                              ,style: TextStyle(color:AppData.kPrimaryColor,
                                  fontSize: 18,fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(width:5),
                        Material(
                          elevation: 3,
                          color:AppData.kPrimaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                          child: MaterialButton(
                            onPressed: () {
                              if (textEditingController[12].text == "" ||
                                  textEditingController[12].text == null) {
                                AppData.showInSnackBar(context, "Please Enter Document Name 1");
                              }else {
                                _settingModalBottomSheet(context);
                              }
                            },
                            minWidth: 120,
                            height: 30.0,
                            child: Text(MyLocalizations.of(context).text("UPLOAD"),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                (idproof != null)
                    ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "Report Path :" + idproof,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                      InkWell(
                        child: SizedBox(
                            width: 50.0,
                            child: Icon(Icons.clear)),
                        onTap: () {
                          setState(() {
                            idproof = null;
                            // registrationModel.profilePhotoBase64 =
                            null;
                            //registrationModel.profilePhotoExt =
                            null;
                          });
                        },
                      )
                    ],
                  ),
                )
                    : Container(),
                SizedBox(
                  height: 8,
                ),
                (idproof != null)
                    ?  formField1(13,  MyLocalizations.of(context).text("DOCUMENT2")):Container(),
                (idproof != null)
                    ? SizedBox(
                  height: 8,
                ):Container(),
                (idproof != null)
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(MyLocalizations.of(context).text("UPLOAD_DOCUMENT2")
                              ,style: TextStyle(color:AppData.kPrimaryColor,
                                  fontSize: 18,fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(width:5),
                        Material(
                          elevation: 3,
                          color:AppData.kPrimaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                          child: MaterialButton(
                            onPressed: ( ) {
                              if (textEditingController[13].text == "" ||
                                  textEditingController[13].text == null) {
                                AppData.showInSnackBar(context, "Please Enter Document Name 2");
                              }else {
                                _settingModalBottomSheet1(
                                    context);
                              }
                            },
                            minWidth: 120,
                            height: 30.0,
                            child: Text(MyLocalizations.of(context).text("UPLOAD"),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ):Container(),
                SizedBox(height: 10,),
                (idproof1 != null)
                    ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(

                          child: Text(

                            "Report Path :" + idproof1,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                      InkWell(
                        child: SizedBox(
                            width: 50.0,
                            child: Icon(Icons.clear)),
                        onTap: () {
                          setState(() {
                            idproof1 = null;
                            // registrationModel.profilePhotoBase64 =
                            null;
                            //registrationModel.profilePhotoExt =
                            null;
                          });
                        },
                      )
                    ],
                  ),
                )
                    : Container(),
                SizedBox(
                  height: 8
                ),
                (idproof1 != null)
                    ? formField1(14, MyLocalizations.of(context).text("DOCUMENT3")):Container(),
                (idproof1 != null)
                    ? SizedBox(
                  height: 8,
                ):Container(),
                (idproof1 != null)
                    ?Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(MyLocalizations.of(context).text("UPLOAD_DOCUMENT3")
                              ,style: TextStyle(color:AppData.kPrimaryColor,fontSize: 18,
                                  fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(width:5),
                        Material(
                          elevation: 3,
                          color:AppData.kPrimaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                          child: MaterialButton(
                            onPressed: () {
                              if (textEditingController[14].text == "" ||
                                  textEditingController[14].text == null) {
                                AppData.showInSnackBar(context, "Please Enter Document Name 3");
                              }else {
                                _settingModalBottomSheet2(
                                    context);
                              }
                            },
                            minWidth: 120,
                            height: 30.0,
                            child: Text(MyLocalizations.of(context).text("UPLOAD"),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ):Container(),

                //SizedBox(height: 10,),
                (idproof2 != null)
                    ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(

                          child: Text(

                            "Report Path :" + idproof2,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                      InkWell(
                        child: SizedBox(
                            width: 50.0,
                            child: Icon(Icons.clear)),
                        onTap: () {
                          setState(() {
                            idproof2 = null;
                            // registrationModel.profilePhotoBase64 =
                            null;
                            //registrationModel.profilePhotoExt =
                            null;
                          });
                        },
                      )
                    ],
                  ),
                )
                    : Container(),
                SizedBox(
                  height: 8,
                ),
                (idproof2 != null)
                    ?formField1(15, MyLocalizations.of(context).text("DOCUMENT4")):Container(),
                (idproof2 != null)
                    ? SizedBox(
                  height: 8,
                ):Container(),
                (idproof2 != null)
                    ?Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(MyLocalizations.of(context).text("UPLOAD_DOCUMENT4")
                              ,style: TextStyle(color:AppData.kPrimaryColor,fontSize: 18,
                                  fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(width:5),
                        Material(
                          elevation: 3,
                          color:AppData.kPrimaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                          child: MaterialButton(
                            onPressed: () {
                              if (textEditingController[15].text == "" ||
                                  textEditingController[15].text == null) {
                                AppData.showInSnackBar(context, "Please Enter Document Name 4");
                              }else {
                                _settingModalBottomSheet3(
                                    context);
                              }

                            },
                            minWidth: 120,
                            height: 30.0,
                            child: Text(MyLocalizations.of(context).text("UPLOAD"),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ):Container(),
                SizedBox(height: 10,),
                (idproof3 != null)
                    ? Padding(
                  padding: const EdgeInsets.only(
                      left: 18, right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(

                          child: Text(

                            "Report Path :" + idproof3,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                      InkWell(
                        child: SizedBox(
                            width: 50.0,
                            child: Icon(Icons.clear)),
                        onTap: () {
                          setState(() {
                            idproof3 = null;
                            // registrationModel.profilePhotoBase64 =
                            null;
                            //registrationModel.profilePhotoExt =
                            null;
                          });
                        },
                      )
                    ],
                  ),
                )
                    : Container(),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                           dialogaddnomination(context),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.black26,
                      height: 40,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Add Nominee",
                               // MyLocalizations.of(context).text("ADD_WITNESS"),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          //Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.add_box,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  itemBuilder: (context, i) {
                    //= witnessModle[i];
                    // widget.model.medicinelist = ;
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        shadowColor: Colors.grey,
                        elevation: 4,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Container(
                            //height: 100,
                              width: double.maxFinite,
                              /*  margin: const EdgeInsets.only(top: 6.0),*/
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "MemberNo: " +
                                                witnessModle[i].memberNo??"N?A",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "First_Name: " + witnessModle[i].first_Name??"N/A",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Middle_Name: " + witnessModle[i].middle_Name??"N/A",
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                         /* Text(
                                            "DateOfBirth: "+ witnessModle[i].dateOfBirth??"N/A",
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(color: Colors.grey),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          //witnessModle.remove(i);
                                          witnessModle.remove(witnessModle[i]);
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        // color: Colors.red,
                                      ),
                                    ),
                                    //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                    /*Image.asset(
                                  "assets/forwardarrow.png",
                                  fit: BoxFit.fitWidth,
                                  */
                                    /*width: 50,*/
                                    /*
                                  height: 30,
                                ),*/
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              )),
                          /* clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                            ),*/
                        ),
                      ),

                      /* */
                    );
                  },
                  itemCount: witnessModle.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: _submitButton(),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () => {
                      Navigator.pop(context),
                      getCameraImage(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),


                    /* MultiImagePicker.pickImages(
                  maxImages: 300,
                  enableCamera: true,
                  //selectedAssets: images,
                  materialOptions: MaterialOptions(
                  actionBarTitle: "FlutterCorner.com",
                  ),
                  ),*/
                    getCerificateImage()},
                ),
                new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                      Navigator.pop(context),
                      getPdfAndUpload(),
                    }),
              ],
            ),
          );
        });
  }
  Future getCameraImage() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile = image1;
      idproof = image1.path;
      //adduploaddocument.extension = extName;
      extension = extName;
      print("Message is: " + extension); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future getCerificateImage() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile = image1;
      idproof = image1.path;
      //adduploaddocument.extension = extName;
      extension = extName;
      print("Message is: " +
          extension); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future<void> getPdfAndUpload() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        selectFile = file;
        idproof = file.path;
//        adduploaddocument.extension = extName;
        extension = extName;
        print("Message is: " +
            extension); // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +
            extName); // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }
  void _settingModalBottomSheet1(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () => {
                      Navigator.pop(context),
                      getCameraImage1(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),


                    /* MultiImagePicker.pickImages(
                  maxImages: 300,
                  enableCamera: true,
                  //selectedAssets: images,
                  materialOptions: MaterialOptions(
                  actionBarTitle: "FlutterCorner.com",
                  ),
                  ),*/
                    getCerificateImage1()},
                ),
                new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                      Navigator.pop(context),
                      getPdfAndUpload1(),
                    }),
              ],
            ),
          );
        });
  }
  Future getCameraImage1() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile1 = image1;
      idproof1 = image1.path;
      //adduploaddocument1.extension = extName;
      extension1 = extName;
      print("Message is: " +
          extension1); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future getCerificateImage1() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile1 = image1;
      idproof1 = image1.path;
      //adduploaddocument1.extension = extName;
      extension1 = extName;
      print("Message is: " +
          extension1); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future<void> getPdfAndUpload1() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        selectFile1 = file;
        idproof1 = file.path;
        //adduploaddocument1.extension = extName;
        extension1 = extName;
        print("Message is: " +
            extension1); // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +
            extName); // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }
  void _settingModalBottomSheet2(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () => {
                      Navigator.pop(context),
                      getCameraImage2(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),


                    /* MultiImagePicker.pickImages(
                  maxImages: 300,
                  enableCamera: true,
                  //selectedAssets: images,
                  materialOptions: MaterialOptions(
                  actionBarTitle: "FlutterCorner.com",
                  ),
                  ),*/
                    getCerificateImage2()},
                ),
                new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                      Navigator.pop(context),
                      getPdfAndUpload2(),
                    }),
              ],
            ),
          );
        });
  }
  Future getCameraImage2() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile2 = image1;
      idproof2 = image1.path;
      //adduploaddocument1.extension = extName;
      extension2 = extName;
      print("Message is: " +
          extension2); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future getCerificateImage2() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile2 = image1;
      idproof2 = image1.path;
      //adduploaddocument1.extension = extName;
      extension2 = extName;
      print("Message is: " +
          extension2); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future<void> getPdfAndUpload2() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        selectFile2 = file;
        idproof2 = file.path;
        //adduploaddocument1.extension = extName;
        extension2 = extName;
        print("Message is: " +
            extension2); // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +
            extName); // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }
  void _settingModalBottomSheet3(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () => {
                      Navigator.pop(context),
                      getCameraImage3(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),

                    getCerificateImage3()},
                ),
                new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                      Navigator.pop(context),
                      getPdfAndUpload3(),
                    }),
              ],
            ),
          );
        });
  }
  Future getCameraImage3() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile3 = image1;
      idproof3 = image1.path;
      //adduploaddocument1.extension = extName;
      extension3 = extName;
      print("Message is: " +
          extension3); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future getCerificateImage3() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile3 = image1;
      idproof3 = image1.path;
      //adduploaddocument1.extension = extName;
      extension3 = extName;
      print("Message is: " +
          extension3); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future<void> getPdfAndUpload3() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        selectFile3 = file;
        idproof3 = file.path;
        //adduploaddocument1.extension = extName;
        extension3 = extName;
        print("Message is: " +
            extension3); // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +
            extName); // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }
  Widget dialogaddnomination(BuildContext context) {
    NomineeModel witness = NomineeModel();
    textEditingController[42].text = "";
    textEditingController[43].text = "";
    textEditingController[44].text = "";
    textEditingController[45].text = "";
    textEditingController[46].text = "";
    textEditingController[47].text = "";
    textEditingController[48].text = "";
    textEditingController[49].text = "";
    textEditingController[50].text = "";
    textEditingController[51].text = "";
    textEditingController[52].text = "";
    InsuranceFormNew.relationmodel = null;

    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //_buildAboutText(),
                //_buildLogoAttribution(),
                Text("Add Nominee"),
                SizedBox(
                  height: 8,
                ),
                panNo(42,"Member No", TextInputType.number),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:
                    DropDown.
                    networkDropdown1(
                      // "TITLE"
                        MyLocalizations.of(context)
                            .text("TITLE"),
                        ApiFactory.TITLE_API,
                        "title",
                        Icons.person_rounded,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.TITLE_API);
                        InsuranceFormNew.titleModel = data;
                        //userModel.title = data.key;
                      });
                    }),
                  ),
                ),

                SizedBox(
                  height: 8,
                ),
                formField1(
                    43,
                    "First Name"),
                SizedBox(
                  height: 8,),
                formField1(
                    44,
                    "Middle Name(Optional)"),

                SizedBox(
                  height: 8,
                ),
                formField1(
                    45,
                    "Last Name"),
                SizedBox(height: 8),
                 panNo(52,"Contact No.", TextInputType.number),
                  SizedBox(height: 8),
                dob2('Date of Birth'),
                 Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:DropDown.networkDropdown1(
                      //"Gender"
                        MyLocalizations.of(context)
                            .text("GENDER"),
                        ApiFactory.GENDER_API,
                        "gender",
                        Icons.wc_outlined,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.GENDER_API);
                        InsuranceFormNew.genderModel2 = data;
                        //userModel.gender = data.key;
                        // UserSignUpForm.cityModel = null;
                      });
                    }),
                  ),
                ),
                //panNo(37,"Relation Code"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:DropDown.networkDropdown1(
                       "Relation Code",
                        ApiFactory.INSURANCE_RELATION,
                        "insurancerelation",
                        Icons.wc_outlined,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                     print(ApiFactory.INSURANCE_RELATION);
                         InsuranceFormNew.relationmodel = data;
                        /*patientProfileModel.body.mstausid =
                            data.key;
                        patientProfileModel.body.maritialstatus =
                            data.name;*/
                        //userModel.gender = data.key;
                        // UserSignUpForm.cityModel = null;
                      });
                    }),
                  ),
                ),

            Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:DropDown.networkDropdown1(
                        MyLocalizations.of(context).text("MARITAL_STATUS"),
                        ApiFactory.INSURANCE_MARITALSTATUS,
                        "insurancemarital",
                        Icons.wc_outlined,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.INSURANCE_MARITALSTATUS);
                        InsuranceFormNew.materialmodel = data;
                      /*  patientProfileModel.body.mstausid =
                            data.key;
                        patientProfileModel.body.maritialstatus =
                            data.name;*/
                        //userModel.gender = data.key;
                        // UserSignUpForm.cityModel = null;
                      });
                    }),
                  ),
                ),
                SizedBox(height: 8),
                height(48,"Height"),
                SizedBox(height: 8),
                height(49,"weight"),
                SizedBox(height: 8),
                // educationalQualification(50,"Occupation"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0),
                  child: SizedBox(
                    height: 58,
                    child:DropDown.networkDropdown1(
                        "Occupation",
                        ApiFactory.INSURANCE_OCCUPATION,
                        "insuranceoccupation",
                        Icons.wc_outlined,
                        23.0, (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.INSURANCE_OCCUPATION);
                        InsuranceFormNew.insuranceoccupationmodel1 = data;
                      /*  patientProfileModel.body.mstausid =
                            data.key;
                        patientProfileModel.body.maritialstatus =
                            data.name;*/
                        //userModel.gender = data.key;
                        // UserSignUpForm.cityModel = null;
                      });
                    }),
                  ),
                ),
                SizedBox(height: 8),
                formField1(51,"PrimaryMember"),
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
           /* textEditingController[7].text = "";
            textEditingController[8].text = "";
            textEditingController[9].text = "";
            textEditingController[10].text = "";
            textEditingController[11].text = "";
            textEditingController[12].text = "";*/
          },
          child: Text(MyLocalizations.of(context).text("CANCEL"),
              style: TextStyle(color: AppData.kPrimaryRedColor)),
        ),
        new FlatButton(
          onPressed: () {
            setState(() {
            /*  if (textEditingController[7].text == "" ||
                  textEditingController[7].text == null) {
                AppData.showInSnackBar(context, "Please enter first name");
              } else if (textEditingController[7].text != "" &&
                  textEditingController[7].text.length <= 2) {
                AppData.showInSnackBar(
                    context, "Please enter a valid  name");

              } else if (textEditingController[8].text == "" ||
                  textEditingController[8].text == null) {
                AppData.showInSnackBar(context, "Please enter second name");
              } else if (textEditingController[8].text != "" &&
                  textEditingController[8].text.length <= 2) {
                AppData.showInSnackBar(
                    context, "Please enter a valid  name");

              } else if (textEditingController[9].text == "" ||
                  textEditingController[9].text == null) {
                AppData.showInSnackBar(context, "Please enter last name");
              } else if (textEditingController[9].text != "" &&
                  textEditingController[9].text.length <= 2) {
                AppData.showInSnackBar(
                    context, "Please enter a valid  name");

              } else if (InsuranceFormNew.genderModel == null ||
                  InsuranceFormNew.genderModel == "") {
                AppData.showInSnackBar(context, "Please select gender");

              } else if (InsuranceFormNew.relationmodel == null ||
                  InsuranceFormNew.relationmodel == "") {
                AppData.showInSnackBar(context, "Please select relation");

              } else if (textEditingController[10].text == "" ||
                  textEditingController[10].text == null) {
                AppData.showInSnackBar(context, "Please enter DOB");
              } else {*/
                NomineeModel witness = NomineeModel();
                witness.memberNo = textEditingController[42].text;
                witness.salutation = InsuranceFormNew.titleModel.key;
                witness.first_Name = textEditingController[43].text;
                witness.middle_Name = textEditingController[44].text;
                witness.last_Name = textEditingController[45].text;

               //witness.dateOfBirth = InsuranceFormNew.relationmodel.key;
                witness.relation_Code = textEditingController[47].text;
                //witness.marital_Status =InsuranceFormNew.materialmodel.key;
                witness.height = textEditingController[48].text;
                witness.weight = textEditingController[49].text;
                witness.occupation = textEditingController[50].text;
                witness.primaryMember = textEditingController[51].text;

                //nomineeModel.relaion = AddEmployeePage.RelationModel.key;

                setState(() {
                  witnessModle.add(witness);
                  Navigator.of(context).pop();
                }
                );
             /* }*/
            });

            /* Navigator.of(context).pop();
            textEditingController[7].text = "";
            textEditingController[8].text = "";
            textEditingController[9].text = "";
            textEditingController[10].text = "";
            textEditingController[11].text = "";
            textEditingController[12].text = "";*/
            /*controller[0].text="";
             controller[1].text="";*/
          },
          child: Text(
            MyLocalizations.of(context).text("SUBMIT"),
            //style: TextStyle(color: Colors.grey),
            style: TextStyle(color: AppData.matruColor),
          ),
        ),
      ],
    );
  }
  Widget formField1(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            controller: textEditingController[index],
            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },
            inputFormatters: [
              WhitelistingTextInputFormatter(
                  RegExp("[a-zA-Z ]")),
            ],
          ),
        ),
      ),
    );
  }
  Widget educationalQualification(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            controller: textEditingController[index],
            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },
            inputFormatters: [
              WhitelistingTextInputFormatter(
                  RegExp("[a-zA-Z0-9 ]")),
            ],
          ),
        ),
      ),
    );
  }
  Widget formFieldPinno(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            controller: textEditingController[index],
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            //focusNode: currentfn,
            inputFormatters: [
              WhitelistingTextInputFormatter(
                RegExp("[0-9]"),
              ),
            ],
            maxLength: 6,
            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },

          ),
        ),
      ),
    );
  }
  Widget formFieldPhoneNo(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            controller: textEditingController[index],
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            //focusNode: currentfn,
            inputFormatters: [
              WhitelistingTextInputFormatter(
                RegExp("[0-9]"),
              ),
            ],
            maxLength: 10,
            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },

          ),
        ),
      ),
    );
  }
  Widget stdLandlineNo(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            controller: textEditingController[index],
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            //focusNode: currentfn,
            inputFormatters: [
              WhitelistingTextInputFormatter(
                RegExp("[0-9]"),
              ),
            ],
            maxLength: 11,
            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },

          ),
        ),
      ),
    );
  }
 Future<Null> _selectDate(BuildContext context, String comeFrom) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate:
            DateTime.now().add(Duration(days: 276))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      final df = new DateFormat('dd/MM/yyyy');
      selectedDate = picked;
      selectedDate1 = picked;

      switch (comeFrom) {
        case "fromdate":
          fromdtTxt.value = TextEditingValue(text: ymd.format(selectedDate));
          print(fromdtTxt.text);
          break;
         case "todate":
          todtTxt.value = TextEditingValue(text: ymd.format(selectedDate1));
          break;
      }
    });
  }

  

   Widget fromDt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: GestureDetector(
        onTap: () => _selectDate(context, "fromdate"),
        child: AbsorbPointer(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              controller: fromdtTxt,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Start date",
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: AppData.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

   Widget toDt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: GestureDetector(
        onTap: () => _selectDate(context, "todate"),
        child: AbsorbPointer(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              controller:todtTxt,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "End date",
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: AppData.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget panNo(
      int index,
      String hint,
      TextInputType input
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            controller: textEditingController[index],
            textInputAction: TextInputAction.done,
            keyboardType: input,
            //focusNode: currentfn,
            inputFormatters: [
              //UpperCaseTextFormatter(),
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9-]")),
            ],
            //maxLength: 11,
            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },

          ),
        ),
      ),
    );
  }
  Widget height(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            controller: textEditingController[index],
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            //focusNode: currentfn,
            inputFormatters: [
              //UpperCaseTextFormatter(),
              WhitelistingTextInputFormatter(RegExp("[0-9.-]")),
            ],
            //maxLength: 11,
            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },

          ),
        ),
      ),
    );
  }
  Widget homeAddressLine1(
      int index,
      String hint,
      TextInputType input
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            controller: textEditingController[index],
            textInputAction: TextInputAction.done,
            keyboardType: input,
            //focusNode: currentfn,

            //maxLength: 11,
            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },

          ),
        ),
      ),
    );
  }

  Widget formFieldemail(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            controller: textEditingController[index],
            textInputAction: TextInputAction.done,
            //focusNode: currentfn,
            keyboardType: TextInputType.text,

            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },

          ),
        ),
      ),
    );
  }
  Widget formFieldAadhaaerno(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            controller: textEditingController[index],
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,

            inputFormatters: [
              WhitelistingTextInputFormatter(
                RegExp("[0-9]"),
              ),
            ],
            maxLength: 12,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },

          ),
        ),
      ),
    );
  }



  Widget viewMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.cash,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
            });
          },
        ),
        Text("Daily"),
        SizedBox(
          width: 10,
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.cheque,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
            });
          },
        ),
        Text("Weekly"),
        SizedBox(
          width: 10,
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.online,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
            });
          },
        ),
        Text("Monthly"),
      ],
    );
  }
  Widget formFieldPassPortno(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            controller: textEditingController[index],
            maxLength: 14,

            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },
            inputFormatters: [
              //UpperCaseTextFormatter(),
              WhitelistingTextInputFormatter(RegExp("[0-9-]")),
            ],

          ),
        ),
      ),
    );
  }
  Widget mobileNoOTPSearch() {
    return Row(
      children: <Widget>[
        Expanded(
          //flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 2.0),
            child: Container(
              // padding: EdgeInsets.only(left: 2),
              height: 50.0,

              child: mobileNumber(),
            ),
          ),
        ),
      ],
    );
  }
/*  Future getCerificateImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    print(decodedImage.width);
    print(decodedImage.height);

    setState(() {
      _imageCertificate = image;
      selectGallery = true;
      print('Image Path $_imageCertificate');
    });
  }*/

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    var enc = await image.readAsBytes();

    print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
    if (50000 < enc.length) {
      /*AppData.showToastMessage(
          "Please select image with maximum size 50 KB ", Colors.red);*/
      return;
    }

    setState(() {
      _image = image;

      print('Image Path $_image');
    });
  }

  Widget errorMsg(text) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  Widget inputFieldContainer(child) {
    return Padding(
      padding:
      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // decoration: BoxDecoration(
        //     // color: AppData.kPrimaryLightColor,
        //     borderRadius: BorderRadius.circular(29),
        //     border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }

  Widget fromField(int index, String hint, bool enb, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type) {
    // print(index);
    // print(currentfn);
    return TextFieldContainer(
      //color: error[index] ? Colors.red : AppData.kPrimaryLightColor,
      child: TextFormField(
        enabled: !enb,
        controller: textEditingController[index],
        focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          // ignore: deprecated_member_use
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        keyboardType: keyType,
        decoration: InputDecoration(
          // border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (value) {
          if (value.isEmpty) {
            error[index] = true;
            return null;
          } else {
            error[index] = false;
            return null;
          }
        },
        onFieldSubmitted: (value) {
          print("ValueValue" + error[index].toString());
          setState(() {
            error[index] = false;
          });
          AppData.fieldFocusChange(context, currentfn, nextFn);
        },
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
        text: MyLocalizations.of(context).text("SUBMIT"),
        context: context,
        fun: () {
          validate();
         // Navigator.pushNamed(context, "/dashboard");

        /*else if (textEditingController[1].text == "" ||
              textEditingController[1].text == null) {
            AppData.showInSnackBar(context, "Please enter first name");
          } else if (textEditingController[1].text != "" &&
              textEditingController[1].text.length <= 2) {
            AppData.showInSnackBar(context, "Please enter a valid  name");

          }else if (textEditingController[3].text == "" ||
              textEditingController[3].text == null) {
            AppData.showInSnackBar(context, "Please enter last name");


          }else if (textEditingController[4].text == "" ||
              textEditingController[4].text == null) {
            AppData.showInSnackBar(context, "Please enter date of birth");

          } else if (InsuranceFormNew.genderModel == null) {
            AppData.showInSnackBar(context, "please select gender");

          } else if (textEditingController[4].text == "" ||
              textEditingController[4].text == null) {
            AppData.showInSnackBar(context, "Please enter education qualification");


          } else if (textEditingController[4].text == "" ||
              textEditingController[4].text == null) {
            AppData.showInSnackBar(context, "Please enter email id");


          } else if (textEditingController[4].text == "" ||
              textEditingController[4].text == null) {
            AppData.showInSnackBar(context, "Please enter pin code");

          } else if (textEditingController[4].text == "" ||
              textEditingController[4].text == null) {
            AppData.showInSnackBar(context, "Please enter pan number");

          }

*/






          //   AppData.showInSnackBar(
          //       context, "Please enter a valid  S/O,D/O,W/O");
          // } else if (textEditingController[2].text == "" ||
          //     textEditingController[2].text == null) {
          //   AppData.showInSnackBar(context, "Please enter DOB");
          // } else if (textEditingController[3].text == "" ||
          //     textEditingController[3].text == null) {
          //   AppData.showInSnackBar(context, "Please enter age");
          //   /*} else if (textEditingController[3].text != null &&
          //     (int.tryParse(year) < 18)) {
          //   AppData.showInSnackBar(context, "Age should be 18 above");
          // } */}else if (textEditingController[4].text == "" ||
          //     textEditingController[4].text == null) {
          //   AppData.showInSnackBar(context, "Please enter mobile number");
          // } else if (textEditingController[4].text != "" &&
          //     textEditingController[4].text.length != 10) {
          //   AppData.showInSnackBar(context, "Please enter valid mobile number");
          //   // } else if (textEditingController[5].text == '') {
          //   //   AppData.showInSnackBar(context, "Please enter E-mail");
          //   // } else if (textEditingController[5].text != '' &&
          //   //     !AppData.isValidEmail(textEditingController[5].text)) {
          //   //   AppData.showInSnackBar(context, "Please enter a valid E-mail");
          //   // } else if (textEditingController[6].text == "" ||
          //   //     textEditingController[6].text == null) {
          //   //   AppData.showInSnackBar(context, "Please enter Address");
          //   // } else if (textEditingController[15].text == "" ||
          //   //     textEditingController[15].text == null) {
          //   //   AppData.showInSnackBar(context, "Please enter Blood Group");
          // } else if (patientProfileModel.body.bloodGroup == null && InsuranceFormNew.bloodgroupModel == null ||
          //     InsuranceFormNew.bloodgroupModel == "") {
          //   AppData.showInSnackBar(context, "Please select blood group");
          // } else {
          //   AddOrganDonModel addOrganDonModel = AddOrganDonModel();
          //   addOrganDonModel.patientId = widget.model.user;
          //   addOrganDonModel.donorName = textEditingController[0].text;
          //   addOrganDonModel.donorType = _selectedItem.key;
          //   addOrganDonModel.typeUserName = textEditingController[1].text;
          //   (patientProfileModel != null &&
          //       patientProfileModel.body.dob != null)
          //       ?addOrganDonModel.dob = toDate(patientProfileModel.body.dob):
          //   addOrganDonModel.dob = textEditingController[2].text;
          //   addOrganDonModel.dob = toDate(patientProfileModel.body.dob);
          //   addOrganDonModel.age = year;
          //   addOrganDonModel.mob = textEditingController[4].text;
          //   addOrganDonModel.email = textEditingController[5].text;
          //   addOrganDonModel.address = textEditingController[6].text;
          //   (patientProfileModel.body.bloodGroup != null)
          //       ? addOrganDonModel.bldGr = patientProfileModel.body.bloodGroupId
          //       : addOrganDonModel.bldGr = InsuranceFormNew.bloodgroupModel.key;
          //   addOrganDonModel.witnessList = witnessModle;
          //   addOrganDonModel.organList = selectedOrganList;
          //   addOrganDonModel.tissueList = selectedTissueList;
           // log("Post json>>>>" + jsonEncode(addOrganDonModel.toJson()));
            //AppData.showInSnackBar(context, "add Successfully");
           // MyWidgets.showLoading(context);
           //  widget.model.POSTMETHOD1(
           //      api: ApiFactory.POST_ORGAN_DONOR,
           //      token: widget.model.token,
           //      json: addOrganDonModel.toJson(),
           //      fun: (Map<String, dynamic> map) {
           //        Navigator.pop(context);
           //        if (map[Const.STATUS] == Const.SUCCESS) {
           //          popup(context, map[Const.MESSAGE]);
           //        } else {
           //          AppData.showInSnackBar(context, map[Const.MESSAGE]);
           //        }
           //      });
         // }
        });
  }

  validate() async{
    
    _formKey.currentState.validate();
     if (textEditingController[0].text == "" ||
              textEditingController[0].text == null) {
            AppData.showInSnackBar(context, "Please enter customer id(UHID)");
          } 
          else if (InsuranceFormNew.insurancetitlemodel == null) {
          AppData.showInSnackBar(context, "please select title");

          }else if (textEditingController[1].text == "" ||
              textEditingController[1].text == null) {
            AppData.showInSnackBar(context, "Please enter first name");
          } else if (textEditingController[1].text != "" &&
              textEditingController[1].text.length <= 2) {
            AppData.showInSnackBar(context, "Please enter a valid  name");

          }else if (textEditingController[3].text == "" ||
              textEditingController[3].text == null) {
            AppData.showInSnackBar(context, "Please enter last name");


          }else if (stdob.text == "" ||
              stdob.text == null) {
            AppData.showInSnackBar(context, "Please enter date of birth");

          } else if (InsuranceFormNew.genderModel == null) {
            AppData.showInSnackBar(context, "please select gender");

          } 
          // else if (textEditingController[4].text == "" ||
          //     textEditingController[4].text == null) {
          //   AppData.showInSnackBar(context, "Please enter education qualification");

          // } 
          else if (textEditingController[5].text == "" ||
              textEditingController[5].text == null) {
            AppData.showInSnackBar(context, "Please enter email id");


          } else if (pincode.text == "" ||
              pincode.text == null) {
            AppData.showInSnackBar(context, "Please enter pin code");

          } else if (textEditingController[7].text == "" ||
              textEditingController[7].text == null) {
            AppData.showInSnackBar(context, "Please enter uid number");

          } else if (InsuranceFormNew.insurancemaritalmodel == "" ||
              InsuranceFormNew.insurancemaritalmodel == null) {
            AppData.showInSnackBar(context, "Please enter marriatial status");

          }else if (InsuranceFormNew.insuranceoccupationmodel == "" ||
              InsuranceFormNew.insuranceoccupationmodel == null) {
            AppData.showInSnackBar(context, "Please enter occupation");

          }         
           else if (textEditingController[9].text == "" ||
              textEditingController[9].text == null) {
            AppData.showInSnackBar(context, "Please enter contact mobile no");

          } 
          // else if (textEditingController[10].text == "" ||
          //     textEditingController[10].text == null) {
          //   AppData.showInSnackBar(context, "Please enter landline number");

          // }
          //  else if (textEditingController[11].text == "" ||
          //     textEditingController[11].text == null) {
          //   AppData.showInSnackBar(context, "Please enter pan number");

          // } 
          // else if (textEditingController[12].text == "" ||
          //     textEditingController[12].text == null) {
          //   AppData.showInSnackBar(context, "Please enter passport number");

          // } 
          else if (textEditingController[13].text == "" ||
              textEditingController[13].text == null) {
            AppData.showInSnackBar(context, "Please enter contact person");

          } 
          // else if (textEditingController[14].text == "" ||
          //     textEditingController[14].text == null) {
          //   AppData.showInSnackBar(context, "Please enter annual income");

          //    } 
          //    else if (textEditingController[15].text == "" ||
          //     textEditingController[15].text == null) {
          //   AppData.showInSnackBar(context, "Please enter remarks");
          // }
          else if (fromdtTxt.text == "" ||
              fromdtTxt.text == null) {
            AppData.showInSnackBar(context, "Please enter start date");
          }         
          else if (textEditingController[20].text == "" ||
              textEditingController[20].text == null) {
            AppData.showInSnackBar(context, "Please enter home pincode");
          }
          else if (textEditingController[42].text == "" ||
              textEditingController[42].text == null) {
            AppData.showInSnackBar(context, "Please enter member no");
          }
           else if (InsuranceFormNew.titleModel == "" ||
             InsuranceFormNew.titleModel == null) {
            AppData.showInSnackBar(context, "Please select nominee title");
          }
          else if (textEditingController[43].text == "" ||
              textEditingController[43].text == null) {
            AppData.showInSnackBar(context, "Please enter nominee first name");
          }
          else if (textEditingController[45].text == "" ||
              textEditingController[45].text == null) {
            AppData.showInSnackBar(context, "Please enter nominee last name");
          }
          else if (InsuranceFormNew.genderModel2 == "" ||
              InsuranceFormNew.genderModel2 == null) {
            AppData.showInSnackBar(context, "Please enter nominee gender");
          }
          else if (nomdob.text == "" ||
              nomdob.text == null) {
            AppData.showInSnackBar(context, "Please enter nominee date of birth");
          }
           else if (InsuranceFormNew.relationmodel == "" ||
              InsuranceFormNew.relationmodel == null) {
            AppData.showInSnackBar(context, "Please enter nominee relation");
          }
           else if (InsuranceFormNew.materialmodel == "" ||
              InsuranceFormNew.materialmodel == null) {
            AppData.showInSnackBar(context, "Please enter nominee maritial status");
          }
           else if (InsuranceFormNew.insuranceoccupationmodel1 == "" ||
              InsuranceFormNew.insuranceoccupationmodel1 == null) {
            AppData.showInSnackBar(context, "Please enter nominee occupation");
          }

          else{
            print("form submit");
             var postData =             
             {
    "ClientCreation": {
    "Member_Customer_ID": textEditingController[0].text.toString(),
    "salutation": InsuranceFormNew.insurancetitlemodel.name.toString(),
    "firstName": textEditingController[1].text.toString(),
    "middleName": textEditingController[2].text.toString(),
    "lastName": textEditingController[3].text.toString(),
    "dateofBirth": stdob.text,
    "gender": InsuranceFormNew.genderModel.name.toString(),
    "educationalQualification": textEditingController[4].text.toString(),
    "pinCode": pincode.text.toString(),
    "uidNo": textEditingController[7].text.toString(),
    "maritalStatus": InsuranceFormNew.insurancemaritalmodel.name.toString(),
    "nationality": "Indian",
    "occupation": InsuranceFormNew.insuranceoccupationmodel.key.toString(),
    "primaryEmailID": textEditingController[5].text.toString(),
    "contactMobileNo": textEditingController[9].text.toString(),
    "stdLandlineNo": textEditingController[10].text.toString(),
    "panNo": textEditingController[11].text.toString(),
    "passportNumber": textEditingController[12].text.toString(),
    "contactPerson": textEditingController[13].text.toString(),
    "annualIncome": textEditingController[14].text.toString(),
    "remarks": textEditingController[15].text.toString(),
    "startDate": fromdtTxt.text,
    "endDate": todtTxt.text,
    "IdProof": "Adhaar Card", //textEditingController[7]
    "residenceProof": null, 
    "ageProof": null,
    "others": null,
    "homeAddressLine1": textEditingController[17].text.toString(),
    "homeAddressLine2": textEditingController[18].text.toString(),
    "homeAddressLine3": textEditingController[19].text.toString(),
    "homePinCode": textEditingController[20].text.toString(),
    "homeArea": textEditingController[21].text.toString(),
    "homeContactMobileNo": textEditingController[22].text.toString(),
    "homeContactMobileNo2": textEditingController[23].text.toString(),
    "homeSTDLandlineNo": textEditingController[24].text.toString(),
    "homeFaxNo": textEditingController[25].text.toString(),
    "sameAsHomeAddress": "1",
    "mailingAddressLine1": textEditingController[27].text.toString(),
    "mailingAddressLine2": textEditingController[28].text.toString(),
    "mailingAddressLine3": textEditingController[29].text.toString(),
    "mailingPinCode": textEditingController[30].text.toString(),
    "mailingArea": textEditingController[31].text.toString(),
    "mailingContactMobileNo": textEditingController[32].text.toString(),
    "mailingContactMobileNo2": textEditingController[33].text.toString(),
    "mailingSTDLandlineNo":  textEditingController[12].text.toString(),
    "mailingSTDLandlineNo2": textEditingController[34].text.toString(),
    "mailingFaxNo": textEditingController[35].text.toString(),
    "bankAccountType":textEditingController[36].text.toString(),
    "bankAccountNo":textEditingController[37].text.toString(),
    "ifscCode":textEditingController[38].text.toString(),
    "GSTIN": textEditingController[39].text.toString(),
    "GSTRegistrationStatus": "Consumers", //textEditingController[40]
    "IsEIAavailable": "0",
    "ApplyEIA": "0",
    "EIAAccountNo":textEditingController[41].text.toString(),
    "EIAWith": "0",
    "AccountType": null,
    "AddressProof": null,
    "DOBProof": null,
    "IdentityProof": null
  },
    "PolicyCreationRequest": {
    "Quotation_Number": "",
    "MasterPolicyNumber": "62-21-00113-00-00",
    "GroupID": "Grp001",
    "Product_Code": "4000",
    "intermediaryCode": "ABH1139495",
    "AutoRenewal": null,
    "intermediaryBranchCode": "10MHMUM03",
    "agentSignatureDate": null,
    "Customer_Signature_Date": null,
    "businessSourceChannel": null,
    "AssignPolicy": "0",
    "AssigneeName": null,
    "leadID": "0",
    "Source_Name": "HDFC_NETB",
    "SPID": null,
    "TCN": null,
    "CRTNO": null,
    "RefCode1": null,
    "RefCode2": null,
    "Employee_Number": null,
    "enumIsEmployeeDiscount": null,
    "QuoteDate": null,
    "IsPayment": "0",
    "PaymentMode": null,
    "PolicyproductComponents": [
      {
        "PlanCode": "4112",
        "SumInsured": textEditingController[53].text.toString(),
        "SchemeCode": "4112000003"
      }
    ]
  },
    "MemObj": {
    "Member": [
      {
        "MemberNo":textEditingController[42].text.toString(), // "2"
        "Salutation":InsuranceFormNew.titleModel.name.toString(),
        "First_Name": textEditingController[43].text.toString(),
        "Middle_Name": textEditingController[44].text.toString(),
        "Last_Name": textEditingController[45].text.toString(),
        "Gender": InsuranceFormNew.genderModel2.name[0].toString(),
        "DateOfBirth": nomdob.text,
        "Relation_Code": "R001", //InsuranceFormNew.relationmodel.key.toString(),
        "Marital_Status":InsuranceFormNew.materialmodel.name.toString(),
        "height":textEditingController[48].text.toString(),
        "weight": textEditingController[49].text.toString(),
        "occupation":InsuranceFormNew.insuranceoccupationmodel1.key.toString(),
        "PrimaryMember": "N", //textEditingController[51]
        "MemberproductComponents": [
          {
            "PlanCode": "4112",
            "MemberQuestionDetails": [
              {
                "QuestionCode": null,
                "Answer": null,
                "Remarks": null
              }
            ]
          }
        ],
        "MemberPED": [
          {
            "PEDCode": "",
            "Remarks": ""
          }
        ],
        "exactDiagnosis": null,
        "dateOfDiagnosis": null,
        "lastDateConsultation": null,
        "detailsOfTreatmentGiven": null,
        "doctorName": null,
        "hospitalName": null,
        "phoneNumberHosital": null,
        "Nominee_First_Name": textEditingController[43].text.toString(),
        "Nominee_Last_Name":textEditingController[45].text.toString(),
        "Nominee_Contact_Number": textEditingController[52].text.toString(),
        "Nominee_Home_Address": null,
        "Nominee_Relationship_Code":  InsuranceFormNew.relationmodel.key.toString(),
      }    
    ]
  },
    "ReceiptCreation": {    
  }

          };
     MyWidgets.showLoading(context);
     final response = await http.post(
       Uri.parse('https://esbpre.adityabirlahealth.com/ABHICL_NB/Service1.svc/GFB'),
       headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode(postData)
       );
       print(jsonEncode(postData));
       if (response.statusCode == 200) {
          Navigator.pop(context);
          Xml2Json xml2Json = Xml2Json();
         print('HHHHHHHHHHHHHHHHHHHHHHHHHH ' +  nomdob.text);
          var xmlString = '''${response.body}
''';
xml2Json.parse(xmlString);
var jsonString = xml2Json.toParker();
  var data = jsonDecode(jsonString);
       print(data);
    popup(context,'Success' );
  } else {
    print('GGGGGGGGGGGGGGGGGGGGGGGGGGGG ' );
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
      // widget.model.POSTMETHOD(
      //     api: 'https://esbpre.adityabirlahealth.com/ABHICL_NB/Service1.svc/GFB',
      //     json: postData,
      //     fun: (Map<String, dynamic> map) {
      //       Navigator.pop(context);
      //       // print("Response>>>>"+jsonEncode(map) );
      //        String msg = map["message"].toString()??"NOT RESPONSE GET";
      //       String code = map["code"].toString();
      //       if (code == 200) {
      //         print('\n\n XXXXXXXXXXXXXXXXXXXXXXX ');
      //         popup(context,msg );
      //       } else {
      //         AppData.showInSnackBar(context, msg);
      //       }
      //     });

  }
  }
  /* saveDb() {
    Map<String, dynamic> map = {
      //"regNo": loginRes.ashadtls[0].id,
      "patientId": widget.model.user,
      "donorName": textEditingController[0].text.toString(),
      "typeUserName": DoctorconsultationPage.timeModel.name*/ /*"23:10"*/ /**/ /*time*/ /*,
      "dob": DoctorconsultationPage.timeModel.code,//validitytime.text,
      "age": DoctorconsultationPage.doctorModel.key.toString(),
      "mob": textEditingController[1].text,
      "email": DoctorconsultationPage.hospitalModel.key,
      "address": DoctorconsultationPage.hospitalModel.key,
      "organList": DoctorconsultationPage.hospitalModel.key,
    };

    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_ORGAN_DONOR,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map[Const.STATUS] == Const.SUCCESS) {
            popup(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/

  //Navigator.pushNamed(context, "/navigation");
  /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

  //       Navigator.pushNamed(context, "/addWitness");
  //       //}
  //     },
  //   );
  // }
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
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        // validate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.kPrimaryColor])),
        child: Padding(
          padding:
          EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            MyLocalizations.of(context).text("SIGN_BTN"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget mobileNumber() {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
      const EdgeInsets.only(top: 0.0, left: 14.0, right: 20.0, bottom: 0.0),
      child: Container(
        // decoration: BoxDecoration(
        //   color: AppData.kPrimaryLightColor,
        //   borderRadius: BorderRadius.circular(29),
        //   /*border: Border.all(
        //        color: Colors.black,width: 0.3)*/
        // ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DropdownButton<KeyvalueModel>(
                  underline: Container(
                    color: Colors.grey,
                  ),
                  value: _selectedItem,
                  items: _dropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value;
                    });
                  }),
              /*DropdownButton<KeyvalueModel>(
                underline: Container(
                  color: Colors.grey,
                ),
                value: selectedUser,
                isDense: true,
                onChanged:(KeyvalueModel newValue) {
                  DonorApplication.genderModel=newValue;
                  setState(() {
                    selectedUser = newValue;
                    DonorApplication.genderModel=selectedUser;
                  });
                },
                items: UserType.map((KeyvalueModel value) {
                  return new DropdownMenuItem<KeyvalueModel>(
                    value: value,
                    child: new Text(
                      value.name,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),*/
            ),
            Container(
              height: 35.0,
              width: 1.0,
              color: Colors.grey.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),
            new Expanded(
              child: TextFormField(
                enabled: widget.isConfirmPage ? false : true,
                controller: textEditingController[1],
                /*  focusNode: fnode7,*/
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z. ]")),
                ],
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  counterText: "",
                  hintText: /*MyLocalizations.of(context).text("RELATION_OF")*/ "",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    error[4] = true;
                    return null;
                  }
                  error[4] = false;
                  return null;
                },
                onFieldSubmitted: (value) {
                  // print(error[2]);
                  error[4] = false;
                  setState(() {});
                  //AppData.fieldFocusChange(context, fnode7, fnode8);
                },
                onSaved: (value) {
                  //userPersonalForm.phoneNumber = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget witnmobileNumber() {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
      const EdgeInsets.only(top: 0.0, left: 10.0, right: 5.0, bottom: 0.0),
      child: Container(
        // decoration: BoxDecoration(
        //   color: AppData.kPrimaryLightColor,
        //   borderRadius: BorderRadius.circular(29),
        //   /*border: Border.all(
        //        color: Colors.black,width: 0.3)*/
        // ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child:
              /*DropdownButton<KeyvalueModel>(
               items: UserType
                   .map((data) => DropdownMenuItem<KeyvalueModel>(
                 child: Text(data.name),
                 value: data,
               ))
                   .toList(),
               onChanged: (KeyvalueModel value) {
                 setState(() => selectedUser = value);
               },
              // hint: Text('Select Key'),
             ),*/
              DropdownButton<KeyvalueModel>(
                // hint: Text("Select Device"),
                underline: Container(
                  color: Colors.grey,
                ),
                value: selectedUser1,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    selectedUser1 = newValue;
                  });
                  print(selectedUser1);
                },
                items: UserType1.map((KeyvalueModel value) {
                  return DropdownMenuItem<KeyvalueModel>(
                    value: value,
                    child: new Text(
                      value.name,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 35.0,
              width: 1.0,
              color: Colors.grey.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),
            new Expanded(
              child: TextFormField(
                enabled: widget.isConfirmPage ? false : true,
                controller: textEditingController[8],
                // focusNode: fnode8,
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,

                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  counterText: "",
                  //hintText: "S/O,D/O,W/O",
                  hintText: "",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    error[4] = true;
                    return null;
                  }
                  error[4] = false;
                  return null;
                },
                onFieldSubmitted: (value) {
                  // print(error[2]);
                  error[4] = false;
                  setState(() {});
                  //AppData.fieldFocusChange(context, fnode7, fnode8);
                },
                onSaved: (value) {
                  //userPersonalForm.phoneNumber = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }



  Widget continueButton() {
    return InkWell(
      child: Center(
        child: CircleAvatar(
          radius: 20.0,
          //backgroundColor: Colors.amber.shade600,
          backgroundColor: AppData.kPrimaryColor,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () {
        setState(() {});
        //validate();
      },
    );
  }

  Widget _applicationButton() {
    return MyWidgets.nextButton(
      text: "Application",
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        Navigator.pushNamed(context, "/donorApplication");

        //}
      },
    );
  }

  /*Widget dob1(String hint) {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => _selectDate1(
          context,
        ),
        child: AbsorbPointer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 9,right: 9),
                child: Container(
                  decoration: BoxDecoration(
                    // color: AppData.kPrimaryLightColor,
                    // borderRadius: BorderRadius.circular(29),
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,

                        color: Colors.grey,
                      ),
                      // border: Border.all(color: Colors.black, width: 0.3)
                    ),
                  ),
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextFormField(
                      controller: stdob*//*textEditingController[10]*//*,
                      keyboardType: TextInputType.datetime,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      onSaved: (value) {
                        // registrationModel.dathOfBirth = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          error[3] = true;
                          return null;
                        }
                        error[3] = false;
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        error[3] = false;
                        // print("error>>>" + error[2].toString());

                        setState(() {});
                        // AppData.fieldFocusChange(context, fnode4, fnode5);
                      },
                      decoration: InputDecoration(
                        hintText: //"Last Period Date",
                        "DOB",
                        border: InputBorder.none,

                        //contentPadding: EdgeInsets.symmetric(vertical: 10),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/

  Widget dobBirth() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate1(context),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              enabled: !widget.isConfirmPage ? false : true,
              controller: stdob,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "Date Of Birth",
                hintStyle: TextStyle(
                    color: AppData.hintColor,
                    fontSize: 15),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  Widget dob2(String hint) {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => _selectDate2(
          context,
        ),
        child: AbsorbPointer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 9,right: 9),
                child: Container(
                   decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextFormField(
                      controller: nomdob/*textEditingController[10]*/,
                      keyboardType: TextInputType.datetime,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      onSaved: (value) {
                        // registrationModel.dathOfBirth = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          error[3] = true;
                          return null;
                        }
                        error[3] = false;
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        error[3] = false;
                        // print("error>>>" + error[2].toString());

                        setState(() {});
                        // AppData.fieldFocusChange(context, fnode4, fnode5);
                      },
                      decoration: InputDecoration(
                        hintText: //"Last Period Date",
                        "DOB",
                        border: InputBorder.none,

                        //contentPadding: EdgeInsets.symmetric(vertical: 10),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
