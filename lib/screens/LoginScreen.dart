import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:math' as math;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info/package_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AyuRythmDataModel.dart';
import 'package:user/models/AyuRythmPostModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MasterLoginResponse.dart' as master;
import 'package:user/models/NadiModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/OTPTextfield.dart';
import 'package:user/screens/PinView.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class LoginScreen extends StatefulWidget {
  final MainModel model;
  final String mobNo, aadharNo;

  LoginScreen({Key key, this.model, this.mobNo, this.aadharNo})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController beniTextController = new TextEditingController();
  TextEditingController aadharTextController = new TextEditingController();
  TextEditingController mobileTextController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController _loginId = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;
  static final List<String> languagesList = application.supportedLanguages;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
    languagesList[2]: languageCodesList[2],
    languagesList[3]: languageCodesList[3],
  };
  final Map<dynamic, dynamic> languageCodeMap = {
    languageCodesList[0]: languagesList[0],
    languageCodesList[1]: languagesList[1],
    languageCodesList[2]: languagesList[3],
    languageCodesList[3]: languagesList[3],
  };
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  void _update(Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Lan", locale.toString());
    application.onLocaleChanged(locale.toString());
  }

  // String  identifier;
  String deviceid;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  dynamic currentTime = DateFormat.jm().format(DateTime.now());

  /* var now = new DateTime.now();
  DateFormat formatter1 = new DateFormat('dd-MM-yyyy');
  String formattedDate = formatter1.format(now);
*/
  bool isLoginLoading = false;

  SharedPref sharedPref = SharedPref();
  bool isPassShow = true;

  // String deviceid = await DeviceId.getID  ;
  // String deviceid = await DeviceId.getID;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  int minNumber = 1000;
  int maxNumber = 6000;
  String countryCode = "+91";
  bool isotpVisible = false;
  bool ispassVisible = true;
  bool isloginButton = true;
  bool _rememberMe = false;
  var rng = new math.Random();
  var code;

  var pin;
  String token = "";
  String imei = "";
  String formattedDate;

  master.MasterLoginResponse masterResponse;

// String imeiNo = await DeviceInformation.deviceIMEINumber;

  @override
  void initState() {
    rememberMe();
    super.initState();
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    formattedDate = formatter.format(now);
    // print(formattedDate);

    tokenCall();
    getDeviceSerialNumber();
    _initPackageInfo();
  }

  _displayTextInputDialog(BuildContext context) async {
    bool _rememberMe = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  //height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "You are dhan Arogya Kranti User.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),

                          /*  Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = !_rememberMe;
                                  });
                                },
                              ),
                              Text("I accept terms & condition")
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
*/
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child:
                    Text("OK", style: TextStyle(color: AppData.kPrimaryColor)),
              ),
            ],
          );
        });
  }

  rememberMe() async {
    var userId = await sharedPref.getKey(Const.REMEMBER_USERID);
    var password = await sharedPref.getKey(Const.REMEMBER_PASSWORD);
    if (userId != null && password != null) {
      _loginId.text = json.decode(userId);
      passController.text = json.decode(password);
      setState(() {
        _rememberMe = true;
      });
    }
  }

  Future<void> _initPackageInfo() async {
    if (Platform.isAndroid) {
      final PackageInfo info = await PackageInfo.fromPlatform();
      setState(() {
        _packageInfo = info;
      });
    }
  }

  Future<String> getDeviceSerialNumber() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        // deviceName = build.model;
        // deviceVersion = build.version.toString();
        // identifier = build.androidId;  //UUID for Android
        setState(() {
          // deviceid=build.model;
          imei = build.androidId;
        });
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        // deviceName = data.name;
        // deviceVersion = data.systemVersion;
        // identifier = data.identifierForVendor;  //UUID for iOS
        setState(() {
          // deviceid=data.name;
          imei = data.identifierForVendor;
        });
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  deviceInfooo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
      deviceid = androidInfo.androidId;
    }
    // e.g. "Moto G (4)"
  }

  tokenCall() {
    FirebaseMessaging.instance.getToken().then((value) {
      String token = value;
      print("token dart locale>>>" + token);
      widget.model.activitytoken = token;
      //sendDeviceInfo();
    });
    /*FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      setState(() {
        token = event;
        log(">>>>>>>>Token>>>>>>>" + token);
      });
    });*/
  }

  dialogGender1() {
    return Alert(
      context: context,
      //title: "Success",
      title: "Gender",
      //type: AlertType.info,
      onWillPopActive: true,
      closeIcon: Icon(
        Icons.info_outline,
        color: Colors.transparent,
      ),
      buttons: [
        DialogButton(
          color: Colors.grey[200],
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.black45),
          ),
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          /*Text(
            "Dana Arogya kranti ",
            style: TextStyle(color: Colors.black, fontSize: 13,fontStyle: FontStyle.normal),
            textAlign: TextAlign.center,
          ),*/
          /* IntrinsicHeight(

            child: Row(
              mainAxisSize: MainAxisSize.max,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                      */ /*  selectGender = "1";
                        callingAPI(selectGender, salID);
                        Navigator.pop(context);
                        _selectDate(context);
                        Navigator.pop(context);*/ /*
                      });
                    },
                      child:DialogButton(
                        color: Colors.grey[200],
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.black45),
                        ),
                      )
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey[400],
                ),
               */ /* Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        */ /**/ /*selectGender = "2";
                        callingAPI(selectGender, salID);
                        Navigator.pop(context);
                        _selectDate(context);*/ /**/
          /*
                      });
                    },
                    child: Container(
                      //width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [


                          Text(
                            "FEMALE",
                            style: TextStyle(color: Colors.black, fontSize: 13,fontStyle: FontStyle.normal),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/ /*
              ],
            ),
          ),*/
          SizedBox(
            height: 10,
          )
        ],
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    code = rng.nextInt(9000) + 1000;
    // log(token ?? "jj");
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: body(context),
    );
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/bg_img.jpg",
              fit: BoxFit.cover,
              //centerSlice: ,
              height: 200,
              width: double.maxFinite,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              margin: EdgeInsets.only(
                top: 200.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Spacer(),
                      Container(
                        width: size.width,
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        margin: EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          // color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              alignment: Alignment.center,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: AppData.selectedLanguage,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      AppData.setSelectedLan(newValue);
                                      _update(Locale(languagesMap[newValue]));
                                    });
                                    print(AppData.selectedLanguage);
                                  },
                                  items: languagesList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                         height: 20,
                      ),
                      InkWell(
                        onTap: (){
                          callAyurythm();
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: MyLocalizations.of(context)
                                      .text("WELCOMENACK"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Monte",
                                    fontSize: 25.0,
                                    color: Colors.black,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    /*  FlatButton(
                          color: Colors.green,
                          onPressed: (){
                            String val="";
                            callNadiApp(val);
                      }, child: Text("Call Nadi")),*/
                      SizedBox(height: 5),
                      // Image.asset("assets/congrat1.gif"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: fromFieldNumber(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: fromFieldPass(),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = !_rememberMe;
                              });
                            },
                          ),
                          Text(
                            MyLocalizations.of(context).text("REMEMBER_ME"),
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      _loginButton(),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            InkWell(
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, "/createUserIDScreen");
                                //FlutterPhoneDirectCaller.callNumber("7008553233");
                              },
                              child: Text(
                                MyLocalizations.of(context).text("CREATE_ID"),
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //Navigator.pushNamed(context, "/docDash");
                        },
                        child: Text(
                          MyLocalizations.of(context).text("OR"),
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      _otpButton(),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 5.0),
                        child: InkWell(
                          onTap: () {
                            dashOption(context);
                            // Navigator.pushNamed(context, "/loginFBandGooglePage");
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: MyLocalizations.of(context)
                                            .text("DIDHAVEACC") +
                                        "\n\n",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                                TextSpan(
                                    text: " ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: MyLocalizations.of(context)
                                        .text("CREATE_ACCOUNT"),
                                    style: TextStyle(
                                        color: AppData.matruColor,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/forgotpassword");
                            //Navigator.pushNamed(context, "/dashDoctor");
                          },
                          child: Text(
                            MyLocalizations.of(context).text("FORGOT_PASSWORD"),
                            style: TextStyle(
                                fontSize: 17, color: AppData.kPrimaryColor),
                          )),

                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Image.asset("assets/intro/main_logo.bmp"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
              ),
            ),
            isLoginLoading
                ? Stack(
                    children: [
                      new Opacity(
                        opacity: 0.1,
                        child: const ModalBarrier(
                            dismissible: false, color: Colors.grey),
                      ),
                      new Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Container()
          ],
        ));
  }

  Widget fromFieldNumber() {
    return Theme(
      data: ThemeData(primaryColor: AppData.matruColor),
      child: TextFormField(
        controller: _loginId,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        autofocus: false,
        // maxLength: 10,
        decoration: InputDecoration(
            prefix: Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            //hintText: "Enter number",
            labelText: MyLocalizations.of(context).text("USER_NAME"),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: ''),
        textAlignVertical: TextAlignVertical.center,
        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (value.length != 14) {
            return null;
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          AppData.fieldFocusChange(context, fnode3, null);
        },
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }

  Widget fromFieldPass() {
    return Theme(
      data: ThemeData(primaryColor: AppData.matruColor),
      child: TextFormField(
        controller: passController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        autofocus: false,
        //maxLength: 7,
        decoration: InputDecoration(
            /* prefix:
                Padding(padding: EdgeInsets.only(top: 10), child: Text('+91 ')),*/
            //hintText: "Enter password",
            //contentPadding: EdgeInsets.only(top: ),
            /*filled: true,
            fillColor: Colors.red.withOpacity(.5),*/
            labelText: MyLocalizations.of(context).text("PASSWORD"),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: '',
            suffixIcon: IconButton(
              icon: Icon(
                !isPassShow ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isPassShow = !isPassShow;
                });
              },
            )),
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: isPassShow,

        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (value.length != 14) {
            return null;
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          AppData.fieldFocusChange(context, fnode3, null);
        },
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }

  Widget dialogUserView(BuildContext context, List<master.Body> data) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 20),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 450,
            child: Column(
              children: [
                Text(
                  "Login Users",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //_buildAboutText(),
                        //_buildLogoAttribution(),
                        ListView.separated(
                          separatorBuilder: (c, i) {
                            return Divider();
                          },
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return  ListTile(
                              leading: Icon(
                                CupertinoIcons.person_alt_circle,
                                size: 44,
                              ),
                              title: Text(data[i]?.userName ?? ""),
                              subtitle: Text(data[i].user),
                              onTap: () {
                                /*  sharedPref.save(Const.LOGIN_phoneno, _loginId.text);
                                sharedPref.save(Const.LOGIN_password, passController.text);
                                LoginResponse1 loginResponse = LoginResponse1();
                                // loginResponse.acceptValue(data[i]);
                                Body body=Body();
                                body.user=data[i].user;
                                body.userName=data[i].userName;
                                body.userAddress=data[i].userAddress;
                                body.userPassword=data[i].userPassword;
                                body.userMobile=data[i].userMobile;
                                body.userStatus=data[i].userStatus;
                                body.token=data[i].token;
                                body.roles.add(value)
                                loginResponse.body=body;
                                widget.model.token = data[i].token;
                                widget.model.user = data[i].user;
                                log("Response after assign>>>>"+jsonEncode(loginResponse.toJson()));
                                sharedPref.save(Const.LOGIN_DATA, loginResponse);
                                widget.model.setLoginData1(loginResponse);
                                sharedPref.save(Const.IS_LOGIN, "true");*/
                                roleUpdateApi(data[i].user, data[i]);
                              },
                              trailing: Icon(Icons.arrow_right),
                            );
                          },
                          itemCount: data.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      /*actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text("Cancel"),
        ),
        new FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: const Text('SEARCH'),
        ),
      ],*/
    );
  }

  roleUpdateApi(userId, master.Body data) {
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(
        api: ApiFactory.GET_ROLE + userId,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Response for role>>>>>" + jsonEncode(map));
          if (map["code"] == "success") {
            // sharedPref.save(Const.LOGIN_phoneno, _loginId.text);
            // sharedPref.save(Const.LOGIN_password, passController.text);
            LoginResponse1 loginResponse = LoginResponse1();
            Body body = Body();
            body.user = data.user;
            body.userName = data.userName;
            body.userAddress = data.userAddress;
            body.userPassword = data.userPassword;
            body.userMobile = data.userMobile;
            body.userStatus = data.userStatus;
            body.userStateId = data.userStateId;
            body.userState = data.userState;
            body.userCountry = data.userCountry;
            body.userCountryId = data.userCountryId;
            body.userPic = data.userPic;
            body.token = data.token;
            body.roles = [];
            body.roles.add(map["body"]["roleid"]);
            loginResponse.body = body;
            widget.model.token = data.token;
            widget.model.masterResponse = masterResponse;
            widget.model.user = data.user;
            log("Response after assign>>>>" +
                jsonEncode(loginResponse.toJson()));
            sharedPref.save(Const.LOGIN_DATA, loginResponse);
            sharedPref.save(Const.MASTER_RESPONSE, masterResponse);
            if (_rememberMe) {
              sharedPref.save(Const.REMEMBER_USERID, _loginId.text);
              sharedPref.save(Const.REMEMBER_PASSWORD, passController.text);
            } else {
              sharedPref.remove(Const.REMEMBER_USERID);
              sharedPref.remove(Const.REMEMBER_PASSWORD);
            }
            widget.model.setLoginData1(loginResponse);
            sharedPref.save(Const.IS_LOGIN, "true");

            FirebaseMessaging.instance.subscribeToTopic(data.user);
            FirebaseMessaging.instance.subscribeToTopic(data.userMobile);

            sendDeviceInfo("SUCCESS", userId);

            if (map["body"]["roleid"] == "1".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboard', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "2".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashDoctor', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "5".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboardreceptionlist', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "7".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboardpharmacy', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "8".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/labDash', (Route<dynamic> route) => false);
            }else if (map["body"]["roleid"] == "31".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/labDash', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "12".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/ambulancedash', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "13".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/bloodBankDashboard', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "22".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/syndicateDashboard', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "24".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/admin', (Route<dynamic> route) => false);
            }else if (map["body"]["roleid"] == "28".toLowerCase()) {
              AppData.showInSnackBar(context, "This Functionality are not available in mobile app please visit our web app");
            } else {
              AppData.showInSnackBar(context, "No Role Assign");
            }
          }
        });
  }

  Widget _loginButton() {
    return MyWidgets.nextButton(
      text: MyLocalizations.of(context).text("LOGIN"),
      context: context,

      ///_loginId,passController
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(
              context, "Please enter mobile no/Email id/User id/User name");
        } else if (passController.text == "" || passController.text == null) {
          AppData.showInSnackBar(context, "Please enter password");
        } else {
          widget.model.phnNo = _loginId.text;
          widget.model.passWord = passController.text;
          MyWidgets.showLoading(context);
          widget.model.GETMETHODCALL(
              api: ApiFactory.LOGIN_PASS_MULTIPLE(
                  _loginId.text, passController.text),
              fun: (Map<String, dynamic> map) {
                Navigator.pop(context);
                log("LOGIN RESPONSE>>>>" + jsonEncode(map));
                //AppData.showInSnackBar(context, map[Const.MESSAGE]);
                if (map[Const.CODE] == Const.SUCCESS) {
                  setState(() {
                    widget.model.phnNo = _loginId.text;
                    widget.model.passWord = passController.text;
                    masterResponse = master.MasterLoginResponse.fromJson(map);
                    widget.model.user = masterResponse.body[0].user;

                    /*FirebaseMessaging.instance.getToken().then((value) {
                      String token = value;
                      print("token dart locale>>>" + token);
                      widget.model.activitytoken=token;


                    });*/

                    showDialog(
                      context: context,                      builder: (BuildContext context) =>

                          dialogUserView(context, masterResponse.body),
                    );

                    /* Map<String, dynamic> postmap = {
                      "userId": widget.model.user,
                      "imeiNo": imei,
                      "version": Platform.isAndroid
                          ? _packageInfo.version
                          : Const.IOS_VERSION,
                      "deviceId": deviceid,
                      "activityDate": */ /*"26-1-2021"*/
                    /* formattedDate,
                      "activityTime": currentTime,
                      "type": "LOGIN",
                      "status": "SUCCESS",
                      "deviceToken": widget.model.activitytoken
                    };

                    log("Print data>>>>" + jsonEncode(postmap));
                    MyWidgets.showLoading(context);
                    widget.model.POSTMETHOD(
                        //api: ApiFactory.POST_APPOINTMENT,
                        api: ApiFactory.POST_ACTIVITYLOG,
                        //token: widget.model.token,
                        json: postmap,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          log("Json Response activity log>>" + jsonEncode(map));
                          if (map["code"] == Const.SUCCESS) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  dialogUserView(context, masterResponse.body),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  dialogUserView(context, masterResponse.body),
                            );
                            Navigator.pop(context);
                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });*/
                  });
                } else {
                  AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  String failed = "FAILED";
                  sendDeviceInfo(failed, _loginId.text);
                }
              });
        }
      },
    );
  }

  sendDeviceInfo(String sTATUS, data) {
    Map<String, dynamic> postmap = {
      "userId": data,
      "imeiNo": imei ?? "",
      "version": Platform.isAndroid ? _packageInfo.version : Const.IOS_VERSION,
      "deviceId": deviceid ?? "",
      "activityDate": /*"26-1-2021"*/ formattedDate,
      "activityTime": currentTime,
      "type": "LOGIN",
      "status": sTATUS,
      "deviceToken": widget.model.activitytoken
    };

    log("DEVICE DATA>>>>" + jsonEncode(postmap));
    // MyWidgets.showLoading(context);
    widget.model.POSTMETHOD(
        //api: ApiFactory.POST_APPOINTMENT,
        api: ApiFactory.POST_ACTIVITYLOG,
        //token: widget.model.token,
        json: postmap,
        fun: (Map<String, dynamic> map) {});
  }

  Widget _otpButton() {
    return MyWidgets.outlinedButton(
      text: MyLocalizations.of(context).text("LOGIN_WITH_OTP"),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {
          widget.model.phnNo = _loginId.text;
          MyWidgets.showLoading(context);
          widget.model.GETMETHODCALL(
              api: ApiFactory.LOGIN_Otp(_loginId.text),
              fun: (Map<String, dynamic> map) async {
                Navigator.pop(context);
                log("LOGIN RESPONSE>>>>" + jsonEncode(map));
                //AppData.showInSnackBar(context, map[Const.MESSAGE]);
                if (map[Const.CODE] == Const.SUCCESS) {
                  masterResponse = master.MasterLoginResponse.fromJson(map);
                  final signature = await SmsAutoFill().getAppSignature;
                  widget.model.empid = signature;
                  print('signature ' + signature);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => OTPTextfield(
                              masterLoginResponse: masterResponse,
                              model: widget.model,
                              token: widget.model.activitytoken,
                            )),
                  );
                } else {
                  // masterResponse = master.MasterLoginResponse.fromJson(map);
                  Map<String, dynamic> postmap = {
                    "userId": _loginId.text,
                    "imeiNo": imei ?? "",
                    "version": Platform.isAndroid
                        ? _packageInfo.version
                        : Const.IOS_VERSION,
                    "deviceId": deviceid ?? "",
                    "activityDate": /*"26-1-2021"*/ formattedDate,
                    "activityTime": currentTime,
                    "type": "LOGIN",
                    "status": "FAILED",
                    "deviceToken": widget.model.activitytoken
                  };
                  widget.model.POSTMETHOD(
                      api: ApiFactory.POST_ACTIVITYLOG,
                      json: postmap,
                      fun: (Map<String, dynamic> map) {
                        // Navigator.pop(context);
                        log("Json Response activity log>>" + jsonEncode(map));
                      });
                  AppData.showInSnackBar(
                      context,
                      map.containsKey([Const.MESSAGE])
                          ? map[Const.MESSAGE]
                          : "Mobile number is not registered");
                }
              });
          // widget.model.phnNo = _loginId.text;
          //Navigator.pushNamed(context, "/otpView");
          // Navigator.pushNamed(context, "/pinView");
        }
      },
    );
  }

  userRegSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialog
                /*You can rename this!*/) {
          return FractionallySizedBox(
            heightFactor: 0.34,
            child: Container(
              child: ListView(
                children: [
                  SizedBox(height: 10,),
                  Center(
                      child: Text("Registration option",
                    style: TextStyle(color: Colors.black,
                        fontSize: 22,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/aadharregistration");
                    },
                    child: ListTile(
                      title: Text("BY AADHAR "),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/abhapan");
                    },
                    child: ListTile(
                      title: Text("BY PAN "),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                  ListTile(
                    title: Text("BY MOBILE "),
                    trailing: Icon(Icons.arrow_right),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }


  dashOption(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: const Text("Is it your details?"),
                contentPadding: EdgeInsets.only(top: 18, left: 18, right: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("USER_REGISTRATION"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.pushNamed(context, "/userSignUpForm");
                            Navigator.pushNamed(context, "/aadharregistration");
                            //userRegSheet();
                            //dashOption1(context);
                            //_validate();
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("DOCTOR_REGISTRATION"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(context, "/doctorsignupform2");
                            //Navigator.pop(context);
                            //Navigator.pushNamed(context, "/doctorsignupform2");
                            // Navigator.pushNamed(context, "/doctorsignupform");
                            //_validate();
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("LAB_REGISTRATION"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(context, "/labsignupform");
                            //Navigator.pushNamed(context, "/labsignupform");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("PHARMACISTS"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            // Navigator.pop(context);
                            organisationDialog(context, "/pharmacists");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("AMBULANCE"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            // Navigator.pop(context);
                            organisationDialog(context, "/ambulance");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(
                                  MyLocalizations.of(context).text("NGO"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            // Navigator.pop(context);
                            organisationDialog(context, "/ngo");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("BLOOD_BANK"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(context, "/bloodbank");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("RECEPTIONIST"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(
                                context, "/receptionlistsignUpformm");
                            // Navigator.pushNamed(context, "/doctorsignupform");
                            //_validate();
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("SYNDICATE_PARTNER"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(
                                context, "/syndicatesignUpformm");
                            // Navigator.pushNamed(context, "/doctorsignupform");
                            //_validate();
                          },
                        ),
                        Divider(),
                        MaterialButton(
                          child: Text(
                            MyLocalizations.of(context).text("CANCEL"),
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  organisationDialog(BuildContext context, String organisation) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(MyLocalizations.of(context).text("CANCEL"),
          style: TextStyle(color: AppData.kPrimaryRedColor)),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.pushNamed(context, "/organisationSignUpForm");
      },
    );
    Widget noButton = TextButton(
      child: Text(MyLocalizations.of(context).text("NO"),
          style: TextStyle(color: AppData.kPrimaryRedColor)),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.pop(context);
        //Navigator.pop(context);
        Navigator.pushNamed(context, "/organisationSignUpForm");
      },
    );
    Widget continueButton = TextButton(
      child: Text(MyLocalizations.of(context).text("YES"),
          style: TextStyle(color: AppData.matruColor)),
      onPressed: () {
        Navigator.pop(context);
        //Navigator.pop(context);

        //Navigator.pushNamed(context, "/doctorsignupform2");
        Navigator.pushNamed(context, organisation);
        // String listid = patientProfileModel.body.familyDetailsList[index].famid;
        // String familydetails="3";

        //  FamilyDeleteApi(listid,familydetails);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(MyLocalizations.of(context).text("HAVE_REG_YOUR_ORG")),
      // content: Text("Do You Want to Delete ?"),
      actions: [
        cancelButton,
        noButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

/*
    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 5),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 5),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     */
    /* Positioned(
                        right: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 10.0,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.close, color: Colors.red,size: 25,),
                            ),
                          ),
                        ),
                      ),*/
    /*
                   Align(
                  alignment: Alignment.center,
                    child: Text(
                        "Have you register your organisation in our eHealthSystems?",
                        style: TextStyle(
                            color: Colors.black, fontSize: 20,fontWeight: FontWeight.w400, // light
                            fontStyle: FontStyle.normal ),
                      ),
                   ),
                      SizedBox(height: 10),

                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text("No", style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                 // Navigator.pushNamed(context, "/doctorsignupform2");

                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  "Yes", style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  Navigator.pushNamed(context,organisation */
    /*"/doctorsignupform2"*/ /*);


                },
              ),
            ],
          );
        },
        context: context);*/
  }
  Future<void> callAyurythm() async {
    try {
      String data = "9105105311619572,25,100,50,Male";
      log("Value data>>>>" + data);
      dynamic result = await AppData.channel.invokeMethod('ayurythm', data);

      /*  AppData.showInSnackBar2(context, result.toString());*/

/*
      String result = '{"yogasana":[{"type":"kapha,pitta","name":"Janu Sirshasana","shortdescription":"The name comes from the Sanskrit words ‘Janu’ meaning ‘knee’, ‘Sirsa’ meaning ‘head’ and ‘asana’ meaning ‘posture’. This asana is a forward fold asana bringing the head towards the knee while bending the upper torso from the hips. This asana is considered as a great hip opener and it also opens the hamstrings.","steps":"1. Sit on the mat with left leg straight and the right leg folded, close to the inner part of the left thigh. \\n2. Keep your spine straight, inhale, and raise both the hands, Exhale and bend forward to hold your toe of the left leg with the both hands. \\n3. Keep your head on the left knee without bending the leg and hold the position for 10 - 20 seconds.\\n4. To release, inhale and come up, raise your hands and while exhaling bring the arms down to the sides.\\n5. Repeat the same with the other leg.","benefit_description":"Calms the brain and helps relieve mild depression\\nStretches the spine, shoulders, hamstrings, and groins\\nStimulates the liver and kidneys.\\nImproves digestion.\\nHelps relieve the symptoms of menopause.\\nRelieves anxiety, fatigue, headache, menstrual discomfort.\\nTherapeutic for high blood pressure, insomnia, and sinusitis.\\nStrengthens the back muscles during pregnancy (up to second trimester), done without coming forward, keeping your back spine concave and front torso long.","precautions":"Person suffering from sciatica, slipped disc, injured knee, or hernia problem should avoid this asana."},{"type":"kapha,pitta,vatta","name":"Ardha Matsyendrasana","shortdescription":"Ardha Matsyendrasana or half spinal twist yogasana is major asana effectively practiced in the hatha yoga. When you do this yogasana, the complete length of your spine receives the lateral twist in both the directions. This asana includes different movements that tones your ligaments and spinal nerves, and enhance your digestion.","steps":"1. Sit with both the legs stretched out\\n2. Cross the right leg over the left, placing the right foot flat on the floor close to the right knee. \\n3. Then bend the left leg to bring the heel next to the right hip.\\n4. Inhale and move the left hand up and as you exhale turn around your upper body with your right palm on the ground\\n5. Now slowly hold your right feet with your left hand\\n6. Hold the position for 10-15 seconds\\n7. Now slowly release your left hand get back to resting position\\n8. Repeat the same on with your left leg crossed over your right","benefit_description":"Ardha matsyendrasana is one of the best asans to improve the flexibility of the spine. It keeps your spine young.\\nIt stretches the muscles along the spinal column and tones the spinal nerves. This can relieve some mild pains caused by stiff back.\\nIt is good for mild cases of slipped disk.\\nThis asana massages the organs in the abdominal region.\\nIt improves digestion.\\nArdha matysendrasana tones the kidneys and improves secretion of the adrenal glands.\\nIt activates the pancreas and helps to manage diabetes.","precautions":"People who are suffering from peptic ulcer, hernia, heart and brain problems, hyperthyroidism should avoid. Women after two or three months of pregnancy should avoid."},{"type":"vatta","name":"Baddh Konasana","shortdescription":"Baddh Konasana, also known as Bound Angle asana, is a seated asana in hatha yoga and modern yoga as exercise. This asana strengthens and opens the hips and groin while eradicating abdominal discomfort.","steps":"1. Sit down on the floor with the legs stretched out\\n2. Pull in your feet as close as possible and place the soles of the feet together with your hands\\n3. Keep the upper body straight \\n4. Exhale and bend forward, bringing your forehead all the way down to touch the floor\\n5. Hold the pose for 5 breaths, Then raise the head and get back to starting position","benefit_description":"Relieves urinary disorders.\\nStrong hip and groin opener.\\nStimulates pelvis, abdomen and back.\\nRelieves sciatica pain and stretches spine.\\nPrevents hernia.\\nRelieves stress.\\nImproves blood circulation and reproductive system.\\nCorrects irregular menstruation.\\nEffective for lumbar region, flat feet, infertility and asthma.","precautions":"People with groin and knee injury, Sciatica patients and during menstruation should avoid this asana."}],"pranayama":[{"type":"pitta","name":"Bahirkumbhak Pranayama","shortdescription":"Bahirkumbhak pranayama is a yogic breathing technique that consists of a deep inhalation, full exhalation, and holding this full exhalation while enforcing 3 ?locks? in the chin, abdomen and naval/pelvis. It is beneficial for diseases pertaining to organs in the abdominal cavity. This pranayama is best done after Kapalbhati ? you make most efficient use of the built up energy from Kapalbhati in this pranayama.","steps":"- Sit comfortably in an upright posture and close your eyes\\n- Breathe in deeply\\n- Hold for 10-15 seconds (or as long as comfortably possible)\\n- Exhale fully with uniform force\\n- Start with 3 repetitions of Bahya pranayama and increase gradually.","benefit_description":"It makes the digestive system strong. It deals with constipation and gas (acidity). It offers wonderful benefits for Diabetic patients. It is helpful for concentration boosting.","precautions":""},{"type":"pitta","name":"Jalandhar Bandha","shortdescription":"Jalandhara Bandha is the chin Bandha described and employed in Hatha Yoga. This bandha is performed by extending the neck and elevating the sternum (breastbone) before dropping the head so that the chin may rest on the chest. Meanwhile, the tongue pushes up against the palate in the mouth. This bandha is the most important in practice of pranayama with breath retention.","steps":"Sit in a comfortable pose\\n- just relax your mind\\n- Inhale deeply and lock your chin To the neck\\n- hold the breathe until you maintain the lock\\n- slowly, release the lock and relax","benefit_description":"This posture works the spinal cord. It enhances blood circulation, thereby improving the health of your spinal cord. It awakens the inner energy centres, especially the Vishuddhi Chakra. Improves the ability to retain the breath for a long period of time and develops the ability to concentrate. Beneficial for throat diseases and regulates thyroid function.","precautions":"High or low blood pressure\\nCervical spondylitis or neck pain\\nVertigo or heart disease\\nHyper thyroid"},{"type":"vatta","name":"Bhramari Pranayama","shortdescription":"The Bhramari pranayama, or Humming Bee breathing, is breathing technique derives its name from the black Indian bee called Bhramari. Bhramari pranayama is effective in instantly calming down the mind. It is one of the best breathing exercises to free the mind of agitation, frustration or anxiety and get rid of anger to a great extent.","steps":"- Sit in a comfortable position\\n- Close the ears by pressing your thumbs on the cartilage between the cheek and the ear gently\\n- Bring the rest of your palm over to cover your eyes with the index and middle finger. Do not press\\ndown on the eyes\\n- Breathe in and slowly, while breathing out make a loud humming sound like a bee keeping your\\ncartilage pressed\\n- Breathe in again and repeat the same pattern for 6-7 times.","benefit_description":"It lowers blood pressure, thus relieving hypertension. It releases cerebral tension. It soothes the nerves. It stimulates the pineal and pituitary glands, thus supporting their proper functioning. It dissipates anger. It is the great cure for stress.","precautions":"Should be done on empty stomach"}],"meditation":[{"type":"kapha,pitta,vatta","name":"Sound Meditation","shortdescription":"You can do this exercise at any time, in any place, for any length of time you choose. I encourage you to practice it in different settings: a quiet space in your home, a park, a crowded office or shopping center, even alongside a major road or construction site.\\nDo not discriminate between settings you usually find to be ‘positive’ or ‘peaceful’ and those you find ‘negative’ ‘noisy’ or ‘annoying.’","steps":"As always, take a few moments to breathe, calming the mind, separating the next few minutes from the rest of your day, setting your intention to move within.\\nNow, turn your attention to the sounds around you. Listen to the sound of my voice, the sound of the music, and any others sounds that may be around you.\\nWherever you are, observe that there is always sound. With the music, this is obvious, but we can use the music as a symbol, a pointer, for listening more fully.\\nSo, ask yourself, what do you hear, right now?\\nListen more closely. How many instruments do you hear? How many tones do you hear? How many layers are there to the sound?\\nThese layers have different qualities to them. Some, like the sound of my voice, a melody, or a gong, come and go freely. They appear obvious\\nOthers are more subtle. The pedal-point of a song, the hum of a radiator, light, or appliance.\\nBut, even these more constant sounds vary. They pass in and out of our awareness. They expand and contract.\\nNow, begin to isolate one layer – one aspect – of the sound you hear. Choose anything, and focus on it.\\nAs it resonates, ask: what, really, is this sound? What is beside it, or behind it?\\nAs it passes, ask: where does the sound go? Where did it begin?\\nWhat is the canvas the sound is painted upon?\\nListen, observe, and repeat.","benefit_description":"Stress reduction.\\nReduced chance of brain decline.\\nReduction in anxiety and depression.\\nBetter sleep and relaxation.","precautions":""},{"type":"pitta,vatta,kapha","name":"Mindfulness Meditation","shortdescription":"Mindfulness meditation is the practice of intentionally focusing on the present moment, accepting and non-judgmentally paying attention to the sensations, thoughts, and emotions that arise. “Mindfulness” is the common western translation for the Buddhist term Anapanasati, “mindfulness of breathing”.","steps":"- For the “formal practice” time, sit on a cushion on the floor, or on a chair, with straight and unsupported back. Pay close attention to the movement of your breath. When you breath in, be aware that you are breathing in, and how it feels. When you breath out, be aware you are breathing out. Do like this for the length of your meditation practice, constantly redirecting the attention to the breath. Or you can move on to be paying attention to the sensations, thoughts and feelings that arise.\\n- The effort is to not intentionally add anything to our present moment experience, but to be aware of what is going on, without losing ourselves in anything that arises.\\n- Your mind will get distracted into going along with sounds, sensations, and thoughts. Whenever that happens, gently recognize that you have been distracted, and bring the attention back to the breathing, or to the objective noticing of that thought or sensation. There is a big different between being inside the thought/sensation, and simply being aware of its presence.\\n- Learn to enjoy your practice. Once you are done, appreciate how different the body and mind feel.","benefit_description":"Help relieve stress.\\nImprove sleep.\\nIncreased self-awareness.\\nSense of calmness.\\nIncrease focus.","precautions":""},{"type":"kapha","name":"Ajapa-Japa","shortdescription":"Ajapa Japa, a sadhana that dates from the Upanishads, is a powerful practice that combines elements of pranayama, mantra chanting and meditation. Japa means ","steps":"Sit in a comfortable position of your choice and relax your body completely. Practice kaya sthairyam (stillness of the body). Become aware of the breathing process. Observe every breath as your breathing becomes slow and rhythmic. \\n\\nNow visualize and try to imagine a transparent breathing tube spanning the body between the navel and the throat. Bring your awareness to your navel and start practicing ujjayi breathing. Slowly move your awareness up and down inside the psychic breathing tube (frontal passage). As you breathe in, your knowledge flows slowly and evenly up from the navel to the throat and as you breathe out, it flows from the throat to the navel.\\n\\nThen add a third force, prana in the form of golden liquid. Visualize prana as a golden liquid flowing up and down together with the breath and the awareness. You have the breath, the awareness, and pranic energy in the form of golden liquid ascending and descending inside this psychic passage. \\n\\nObserve this slender, flowing river of golden liquid flowing with the breath and the consciousness inside the passage.\\n\\nTo make the practice more constant, use the mantra SOHAM. (I am that). As you inhale, it is SO and as you exhale it is HAM. Now you have the breath, the awareness, the pranic energy and the mantra SOHAM ascending and descending inside the frontal passage. Practice this for a while. \\n\\n\\nNow get ready to end the practice. Leave the awareness of the psychic passage, of the prana and the breath. Become aware of your physical body, of your meditation posture and the external environment. \\nWhen your consciousness is fully externalized, slowly open your eyes.","benefit_description":"By bringing the consciousness into the heart, this breathing method supports Prana Vayu (energy pervades the chest region).\\nImproves blood circulation and oxygenation of the body, fills the mind with positive energy.\\nCultivate self-awareness and reduces the dominance of the senses and boosts mental faculties.","precautions":"Try not to move your physical body. The head, spine and back must remain straight, but without tensing. \\nDo not make the breath so long that your body starts jerking or shaking."}],"mudra":[{"type":"pitta, vatta","name":"Vipareet Karni Mudra","shortdescription":"Viparita karani mudra is a full-body gesture in yoga that is also an energizing inversion. The name comes from the Sanskrit viparita, meaning ","steps":"1. The base position is lying down supine with hands to the sides.\\n2. Inhale deeply and hold the breath inside. Bring the legs up to the right angle from the floor while keeping the knees extended. Check how the abdomen gets engaged in the process. Continue breathing normally.\\n3. Now inhale deeply and while holding the breath, contract the abdomen more strongly while lifting the spine off the floor. Bring the hands to support the torso adjacent to the sacrum bone, the flat space that you feel under the lower back and place the torso at a 45 degree angle from the floor. Legs will move parallel to the floor over and behind the head. The key point of awareness is abdomen which is the central axis of building the asana from here.\\n4. As you get comfortable, continue breathing and extend the hips and bring the legs to a 45 degree elevation with pelvic being the base. Hands will be bear weight of the body along with the abdomen so you might experience it in your wrists and elbows.\\n5. Stay in the posture for minimum 30 seconds while breathing deeply through diaphragm. You will feel your diaphragm here.\\n6. Coming out, flex the hips bringing the legs down and in a controlled manner put the torso down on the floor with a coordinated effort of hands and abdomen.\\n7. Check your breath and relax the abdomen.","benefit_description":"Vipreeta karani mudra has hte following benefits \\nIt is a nice way to build your inversion practise. \\nIt gives a stability of the core and strengthen the wrists and lower arms.\\nHelp in relieving the strain from the heart.\\nIt is used as a primary technique along with other mudras in Kundalini Yoga, for channelising the Pran Shakti.","precautions":"Avoid this Asana with high blood pressure or dizziness.\\nIf you have serious back and neck problems, make sure you do this asana under the guidance of a certified yoga instructor."},{"type":"pitta","name":"Tadaagi Mudra","shortdescription":"The Sanskrit meaning of ","steps":"Keep the feet a little apart and take a comfortable standing position.\\nKeeping hands on knees, slightly bend the body forward.\\nExhale out the air deeply and do not allow the air to enter the lungs again.\\nRaise the ribs so that the thorax relax. \\nThe diaphragm is raised to completely fill the vacuum and with this the abdominal wall is also pulled.\\nThis provides the concave shape to the abdomen.\\nWhile the abdominal wall is in relaxed position, the anus and pelvis are contracted.\\nHold the position as long as the person can take it comfortably, then inhale the air normally.\\nAfter a few normal breathings, this process can be repeated for few times.","benefit_description":"This benefits in \\nHealthy respiratory system, digestive system, abdomen and pelvis muscles.\\nBenefits various glands and organs of abdominal cavity.\\nDispels depression and headache. \\nImproves digestive function. \\nStrengthens the finger, arm, shoulder, chest and abdominal muscles.","precautions":"This Asana should not be practiced during menstruation, pregnancy or with haemorrhoids. If the Asana causes pain in the fingers, avoid its practice."},{"type":"vatta","name":"Maha Mudra, Maha Bhed Mudra","shortdescription":"Maha Bheda Mudra or the Great Piercing Attitude is mentioned in both Hatha Yoga Pradeepika and Gheranda Samhita. In Sanskrit, Maha means great, Bheda means to pierce and Mudra means a gesture, attitude or seal.","steps":"Sit on the floor with legs stretched out. Fold the left leg and press the perineum with the left heel. The right leg remains stretched out in front throughout the practice.\\nBend forward and hold the big toe of the right leg with the hands. Exhale while bending forward.\\nNow perform Maha Bandha. It comprises of the three Bandhas or locks Jalandhara Bandha, Uddhiyana Bandha and Moola Bandha done together.\\nPerform nose tip gazing or Nasikagra Dhristi.\\nNow begin to rotate the consciousness between the three chakras ","benefit_description":"Maha Bheda Mudra gives physical and spiritual benefits.\\nIt gives all the benefits of Maha Bandha.\\nIt harnesses the energy at the three chakra and induces concentration of the mind and prepares the mind for meditation.\\nIt supposed to give siddhis and perfection to the yogi.\\nAccording to the Hatha Yoga Pradeepika, this mudra gives siddhis, destroys old age and grey hair, increases appetite and gives steadiness to the body.\\nAccording to Gheranda Samhita, there is no fear of death and decay does not come to a yogi who practices Mahe Bheda Mudra.","precautions":""}],"kriya":[{"type":"kapha","name":"Jalneti Kriya","shortdescription":"Neti kriya is an integral part of shatkarmas - the six cleansing techniques that form the most important aspect of hatha yoga. Jal Neti is a nasal cleansing yogic process where salted lukewarm water is used to remove the congestion and blockages of nasal as well as respiratory regions.","steps":"The simple steps and technique of performing Jal neti are being given below:\\nFirst of all sit in Kagasana having 1 foot distance between legs.\\nLean forward from the lower back and tilt the head to the opposite side of the nostril whichever is more active at the moment.\\nInsert the nozzle of the pot into the nostril which is active at that moment. Open your mouth throughout the neti process and try to breathe through it.\\n\\nLet the water flow in through one nostril and out through the other nostril.\\nAfter finishing half of the water of the Neti pot, put it down and clear your nostril.\\nThe same thing should start from other side.\\nAfter finishing from both side, do forceful exhalation from both the nostrils in all the directions i.e. left \u0026 right, top \u0026 bottom.","benefit_description":"Daily practice helps maintain the nasal hygiene by removing the dirt and bacteria trapped along with the mucus in the nostrils.\\nIt soothes the sensitive tissues inside the nose, which can assuage a bout of rhinitis or allergies.\\nIt is beneficial in dealing with asthmatic conditions and making breathing easier.\\nIt reduces tinnitus and middle ear infections.\\nIt helps abate sinusitis or migraine attack.\\nIt can alleviate upper respiratory complaints like sore throats, tonsils, and dry coughs.\\nIt can clear the eye ducts and improve vision.\\nClearing of nasal passages helps improve the sense of smell and thereby improves digestion.\\nPeople have experienced a reduction in their anger by practicing Jal Neti regularly.\\nIt helps improve the quality of your meditation.","precautions":"The nose should be dried properly after the process.\\nPeople with high blood pressure should be careful during this part. If one feels dizzy while drying the nose, then it should be done standing upright.\\nTake care that you do not leave any water in the nasal passages as it might cause an infection.\\nLike any other yogic practice, learn it from an expert practitioner."},{"type":"kapha","name":"Sutraneti Kriya","shortdescription":"Sutra means thread, and neti refers to a prescribed system or process. This is described as ?yoga for cleaning your sinuses and is thought to relieve a blocked nose, ease headache, sinusitis and so on.","steps":"Sit in Kagasana.\\nTilt the head slight back and insert thread or rubber catheter into one of the nostrils, whichever is more active at the moment. Gently push it through the nostril using both hands.\\nWhen the thread has come through to the back of the throat, put the index and middle fingers into the mouth; catch hold of the thread and take it out carefully and slowly through the mouth.\\nLeave a few inches of the thread hanging out of the nose.\\nNow, slowly and gently pull the thread out and do it twice or thrice initially.\\nThe same process can be practiced through other nostril.\\nAfter becoming mastering of the process, the thread can be moved forward and backward as per convenience and take out slowly through the mouth.","benefit_description":"Several benefits of this kriya are listed below: \\nThis is one of the best yoga exercises to clean the nasal region and is good in the prevention and management of cold, cough and sneezing.\\nWhen practised along with Jal neti, it has the power to cure all nasal related disorders like sinusitis, blockage of nasal passage, etc. \\nIt massages the membranes and sinus glands thereby strengthening them. \\nIt improves the function of tear duct and olfactory zone of the brain.\\nIt helps to stimulate the nerves and improves functions of the eyes and eyesight.\\nIt increases resistance to invasion by viruses and bacteria.\\nThis practice greatly assists in balancing the airflow of the two nostrils.\\nThe practice of this yoga engages the Kosas and stimulates the _j?_cakra, the psychic centre in the midbrain.","precautions":"This is thought to be a more advanced kriya than jal neti and it is generally recommended that you seek some guidance from an expert before attempting this on your own. \\nIt is also recommended that a good quality rubber tube be used for the purpose. It should be soft and comfortable; the prescribed thickness is about 4mm but to begin with an even thinner tube or sutra can be used. The thickness can be increased as one gets more proficient at Sutra Neti.\\nPerson having nose bleeding shouldn?t perform it.\\nIt should be avoided during sinus."},{"type":"kapha, pitta, vatta","name":"Kunjal Kriya","shortdescription":"Kunjal Kriya is one of the purification techniques of Hatha yoga, especially practiced for cleansing of the Esophagus and Stomach. It is also known as Vaman Dhauti.","steps":"While standing, drink a glass of water as quick as you can. Repeat the process until your stomach gets full of water.\\nNow comes a time when you will not be able to drink even a drop of water. It looks like everything will come out now. At this time, lean your upper body (trunk and head ) in the forwarding position.\\nIn this position open your mouth wide and insert 2 fingers in it. Use your longest fingers i.e. middle finger along with index finger and slide it on tongue gently in to-and-fro motion. After rubbing like this you will get an urge to vomit and suddenly the water will come out. As soon as the water comes out, remove your fingers immediately.\\nA few movements later, the flow of water will stop. Again, put your fingers in mouth and rub your tongue gently.\\nRepeat the same process until there is no more water left in the stomach.","benefit_description":"Kunjal Kriya gives an effective wash to our digestive system. Hence, It helps to eliminate all diseases caused by poor digestion. \\nimproves the strength of the entire digestive system.\\nIt removes that extra mucus from the esophagus and gives relief from cough.\\nIt also minimizes the poor breathing issue.\\nReduces the chances of the formation of kidney stones.","precautions":"Those who suffer from any chronic disabling disease, an active stomach ulcer, hernia of the stomach or abdomen, high blood pressure, heart disease or esophageal varices, should only practice kunjal under the guidance of a qualified yoga teacher or ashram."}],"food_types":[{"food_type":"Oils","favour_foods":"","avoid_foods":""},{"food_type":"Meat \u0026 Eggs","favour_foods":"","avoid_foods":""},{"food_type":"Legumes","favour_foods":"","avoid_foods":""},{"food_type":"Grains","favour_foods":"","avoid_foods":""},{"food_type":"Nuts \u0026 Seeds","favour_foods":"","avoid_foods":""},{"food_type":"Dairy","favour_foods":"","avoid_foods":""},{"food_type":"Vegetables","favour_foods":"","avoid_foods":""},{"food_type":"Fruits","favour_foods":"","avoid_foods":""},{"food_type":"Spices","favour_foods":"","avoid_foods":""},{"food_type":"Sweeteners","favour_foods":"","avoid_foods":""}],"sparshna_master":{},"sparshna_result_desc":[{"title":"Oxygen Saturation","short_description":"Measure of the amount of oxygen-carrying hemoglobin in the blood relative to the amount of hemoglobin not carrying oxygen.","what_it_means":""},{"title":"Body Mass Index","short_description":"Measure of body fat based on height and weight (kgs/sqm) that applies to adult men and women.","what_it_means":""},{"title":"Basal Metabolic Rate","short_description":"Calories burnt by an individual’s body at rest.","what_it_means":""}],"type":""}';
*/
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>" + result.toString());
List<String> data_auyrthm = result.toString().split('@');
      log(">>>>>>list"+data_auyrthm.length.toString());
      log(">>>>>>listdata"+data_auyrthm.toString());
      log("json decode result"+json.decode(data_auyrthm[0]).toString());
      AyuRythmDataModel ayuRythmDataModel  = AyuRythmDataModel.fromJson(json.decode(data_auyrthm[0]));
      AyuRythmPostModel ayuRythmPostModel =AyuRythmPostModel(data: Data(type: null,foodTypes: null,
          herbs: null,kriya: null,meditation: null,mudra: null,pranayama: null,sparshnaMaster: null,sparshnaResultDesc: null,userId: null,yogasana: null
      ),prakriti: null,sparshna: null,vikriti: null) ;
      List<Herbs> herbs = [Herbs(herbsList: "",herbType: "")];
      ayuRythmPostModel.data.type ="gh";
      ayuRythmPostModel.data.userId="9178";
      ayuRythmPostModel.data.kriya = ayuRythmDataModel.kriya;
      ayuRythmPostModel.data.foodTypes = ayuRythmDataModel.foodTypes;
      ayuRythmPostModel.data.meditation = ayuRythmDataModel.meditation;
      ayuRythmPostModel.data.mudra = ayuRythmDataModel.mudra;
      ayuRythmPostModel.data.pranayama = ayuRythmDataModel.pranayama;
      ayuRythmPostModel.data.sparshnaMaster =ayuRythmDataModel.sparshnaMaster;
      ayuRythmPostModel.data.sparshnaResultDesc = ayuRythmDataModel.sparshnaResultDesc;
      ayuRythmPostModel.data.herbs =herbs;
      ayuRythmPostModel.data.yogasana = ayuRythmDataModel.yogasana;
      if(data_auyrthm[1] != "null" && data_auyrthm[1].toString().trim() !=""){
        print("data_auyrthm[1]"+data_auyrthm[1].toString());
        ayuRythmPostModel.prakriti = Vikriti.fromJson(jsonDecode(data_auyrthm[1].replaceAll(r"\'", "")));
      }else{
        ayuRythmPostModel.prakriti = null;
      }
      if(data_auyrthm[2] != "null" && data_auyrthm[2].toString().trim() !=""){
        print("data_auyrthm[2]"+data_auyrthm[2].toString());
        ayuRythmPostModel.sparshna = Sparshna.fromJson(json.decode(data_auyrthm[2]));
      }
      else{
        ayuRythmPostModel.sparshna = Sparshna(bala: null,bmi: null,bmr: null,bpm: null,dp: null,gati: null,kapha2: null,kath: null,o2r: null,pbreath: null,
        pitta2: null,rythm: null,sp: null,tbpm: null,vata2: null
        );
      }
      if(data_auyrthm[3] != "null" && data_auyrthm[3].toString().trim() !=""){
        print("data_auyrthm[3]"+data_auyrthm[3].toString());
        ayuRythmPostModel.vikriti = Vikriti.fromJson(json.decode(data_auyrthm[3]));
      }
      else{
        ayuRythmPostModel.vikriti = null;
      }
      log(">>>>>>>>>>>data_converted"+ayuRythmPostModel.toJson().toString());
    } on PlatformException catch (e) {}
  }
  callNadiApp(String val) async {
    val="9121401327185797"+","+"24"+","+"male"+","+"Jatin"+","+"120"+","+"60";
    var result = await AppData.channel.invokeMethod('call_nadi', val);
    NadiModel nadiModel = NadiModel.fromJson(jsonDecode(result));
    log("nadi data"+nadiModel.toJson().toString());
    widget.model.POSTMETHOD(
        api: "http://192.168.0.119:8062/nirmalyaRest/api/post-test-report-nadi",
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Response>>>" + jsonEncode(map));
          if(map['code']=="success"){
            AppData.showInSnackDone(context, map['message']);
          }
          else{
            AppData.showInSnackBar(context,map['message']);
          }
        },
        json:nadiModel.toJson());
    AppData.showInSnackBar(context, result??"Some thing wrong");
  }
}
